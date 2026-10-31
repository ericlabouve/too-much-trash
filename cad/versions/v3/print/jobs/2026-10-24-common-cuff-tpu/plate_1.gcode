; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 24m 57s; total estimated time: 33m 1s
; total layer number: 74
; total filament length [mm] : 606.27
; total filament volume [cm^3] : 1458.25
; total filament weight [g] : 1.81
; filament_density: 1.24
; filament_diameter: 1.75
; max_z_height: 8.96
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
M73 P0 R33
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
M73 P1 R32
    G1 E50 F200
    M400
    M1002 set_filament_type:TPU

    M104 S250

    G92 E0
    G1 E50 F49.8898
    M400
    M106 P1 S178
    G92 E0
M73 P2 R32
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P5 R31
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
M73 P18 R26
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
M73 P19 R26
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
    G29 A1 X81.2479 Y78.9279 I17.5042 J21.8723
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
M73 P20 R26
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
M73 P21 R26
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
; layer num/total_layer_count: 1/74
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X83.429 Y79.276 F18000
M204 S6000
G1 Z.4
M73 P22 R25
G1 Z.2
G1 E.4 F1800
; FEATURE: Support
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X81.859 Y79.381 E.0598
G1 X81.979 Y81.176 E.0684
G1 X81.989 Y83.707 E.09617
G1 X83.476 Y83.701 E.0565
G1 X83.477 Y79.294 E.16746
M204 S6000
G1 X82.89 Y83.497 F18000
G1 F900
M204 S500
M73 P23 R25
G1 X82.89 Y79.724 E.14341
G1 X82.382 Y79.758 E.01934
G1 X82.382 Y83.499 E.1422
M204 S6000
G1 X84.24 Y80.116 F18000
G1 F900
M204 S500
G1 X84.266 Y80.749 E.02407
G1 X84.252 Y81.476 E.02763
G1 X84.286 Y82.056 E.0221
G1 X84.286 Y83.697 E.06236
G1 X84.012 Y83.698 E.01041
G1 X84.012 Y82.681 E.03867
G1 X83.986 Y82.283 E.01515
M73 P24 R25
G1 X83.984 Y81.301 E.03731
G1 X84 Y81.001 E.01144
G1 X83.985 Y79.239 E.06697
G1 X84.24 Y79.222 E.00972
M73 P24 R24
G1 X84.24 Y80.048 E.03139
; WIPE_START
G1 X84.24 Y79.222 E-.15692
G1 X83.985 Y79.239 E-.04861
G1 X83.993 Y80.157 E-.17447
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X84.166 Y87.787 Z.6 F18000
G1 X84.284 Y92.964 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X84.278 Y92.734 E.00873
G1 X84.002 Y92.734 E.01049
G1 X83.978 Y93.253 E.01974
G1 X83.495 Y93.247 E.01836
G1 X83.484 Y92.735 E.0195
G1 X81.975 Y92.735 E.05734
G1 X81.976 Y97.184 E.1691
G1 X81.91 Y98.999 E.06901
G1 X83.471 Y99.056 E.05938
G1 X83.475 Y94.481 E.17388
G1 X83.501 Y93.545 E.0356
G1 X83.989 Y93.546 E.01855
G1 X84.012 Y94.617 E.04071
G1 X84.012 Y97.319 E.1027
G1 X83.986 Y97.717 E.01515
G1 X83.998 Y99.075 E.05163
G1 X84.263 Y99.085 E.01007
G1 X84.252 Y98.524 E.02133
G1 X84.286 Y97.944 E.0221
G1 X84.286 Y93.032 E.18666
M204 S6000
G1 X82.89 Y98.829 F18000
G1 F900
M204 S500
G1 X82.89 Y93.146 E.21599
G1 X82.386 Y93.146 E.01914
G1 X82.382 Y98.81 E.21527
; WIPE_START
G1 X82.384 Y96.81 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X90.016 Y96.903 Z.6 F18000
G1 X96 Y96.976 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X96 Y99 E.07694
G1 X96.017 Y99.61 E.0232
G1 X95.743 Y99.613 E.01038
G1 X95.734 Y97.546 E.07858
G1 X95.763 Y97.115 E.01639
G1 X95.734 Y96.543 E.0218
G1 X95.734 Y95.96 E.02213
G1 X96 Y95.957 E.01012
G1 X96 Y96.907 E.03609
M204 S6000
G1 X97.11 Y99.393 F18000
G1 F900
M204 S500
G1 X97.11 Y96.357 E.11538
G1 X97.598 Y96.351 E.01855
G1 X97.618 Y99.387 E.11538
M204 S6000
G1 X98.044 Y99.52 F18000
G1 F900
M204 S500
G1 X98.005 Y95.936 E.13622
G1 X96.703 Y95.95 E.04947
G1 X96.701 Y96.061 E.00424
G1 X96.571 Y96.409 E.01409
G1 X96.589 Y96.672 E.01002
G1 X96.539 Y96.941 E.01039
G1 X96.524 Y97.676 E.02795
G1 X96.529 Y99.605 E.07331
G1 X98.044 Y99.588 E.05759
; WIPE_START
G1 X96.529 Y99.605 E-.28791
G1 X96.528 Y99.12 E-.0921
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X97.11 Y92.208 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X97.11 Y87.372 E.18378
M204 S6000
G1 X98.028 Y89.255 F18000
G1 F900
M204 S500
G1 X98 Y87.154 E.07986
G1 X96.526 Y87.174 E.056
G1 X96.529 Y92.413 E.19911
G1 X98.029 Y92.413 E.05702
G1 X98.029 Y89.324 E.11741
M204 S6000
G1 X96 Y87.413 F18000
G1 F900
M204 S500
G1 X96.017 Y88.802 E.05278
G1 X96.005 Y92.413 E.13727
G1 X95.734 Y92.413 E.01028
G1 X95.734 Y92.146 E.01017
G1 X95.762 Y91.852 E.01121
G1 X95.748 Y91.54 E.01187
G1 X95.763 Y89.949 E.06045
G1 X95.748 Y88.46 E.05661
G1 X95.762 Y88.148 E.01187
G1 X95.734 Y87.854 E.01121
G1 X95.734 Y87.185 E.02544
G1 X96 Y87.181 E.01012
G1 X96 Y87.344 E.00619
; WIPE_START
G1 X96 Y87.181 E-.03096
G1 X95.734 Y87.185 E-.05059
G1 X95.734 Y87.854 E-.1272
G1 X95.762 Y88.148 E-.05606
G1 X95.748 Y88.46 E-.05932
G1 X95.751 Y88.754 E-.05586
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.118 Y92.531 Z.6 F18000
G1 X86.35 Y94.107 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X85.893 Y94.107 E.01737
G1 X85.893 Y85.893 E.31219
G1 X94.107 Y85.893 E.31219
G1 X94.107 Y94.107 E.31219
G1 X86.41 Y94.107 E.29254
M204 S6000
G1 X86.35 Y93.65 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X86.35 Y86.35 E.27745
G1 X93.65 Y86.35 E.27745
G1 X93.65 Y93.65 E.27745
G1 X86.41 Y93.65 E.27517
; WIPE_START
G1 X86.394 Y91.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X86.037 Y84.026 Z.6 F18000
G1 X85.866 Y80.364 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X94.134 Y80.364 E.31423
G1 X94.12 Y80.724 E.01369
G1 X94.12 Y82.535 E.06882
G1 X94.146 Y82.794 E.00992
G1 X94.12 Y83.422 E.02388
G1 X94.12 Y85.436 E.07653
G1 X85.892 Y85.436 E.31272
G1 X85.9 Y82.011 E.13016
G1 X85.867 Y81.437 E.02187
G1 X85.881 Y80.734 E.0267
G1 X85.868 Y80.424 E.0118
; WIPE_START
G1 X87.868 Y80.41 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X86.813 Y87.969 Z.6 F18000
G1 X85.892 Y94.564 Z.6
G1 Z.2
M73 P25 R24
G1 E.4 F1800
G1 F900
M204 S500
G1 X94.12 Y94.564 E.31272
G1 X94.12 Y96.578 E.07653
G1 X94.146 Y97.206 E.02388
G1 X94.12 Y97.465 E.00992
G1 X94.134 Y99.636 E.0825
G1 X85.866 Y99.636 E.31423
G1 X85.881 Y99.266 E.01408
G1 X85.867 Y98.563 E.0267
G1 X85.9 Y97.989 E.02187
G1 X85.892 Y94.624 E.12788
; WIPE_START
G1 X87.892 Y94.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X86.615 Y87.085 Z.6 F18000
G1 X85.397 Y79.907 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X94.603 Y79.907 E.34988
G1 X94.603 Y80.061 E.00586
G1 X94.577 Y80.733 E.02554
G1 X94.577 Y82.512 E.06762
G1 X94.604 Y82.781 E.01028
G1 X94.577 Y83.432 E.02475
G1 X94.577 Y87.912 E.17028
G1 X94.604 Y88.177 E.01013
G1 X94.59 Y88.435 E.00982
G1 X94.606 Y89.949 E.05755
G1 X94.59 Y91.565 E.06141
G1 X94.604 Y91.823 E.00981
G1 X94.577 Y92.088 E.01013
G1 X94.577 Y96.568 E.17028
G1 X94.604 Y97.219 E.02475
G1 X94.577 Y97.488 E.01028
G1 X94.577 Y99.267 E.06762
G1 X94.603 Y100.093 E.0314
G1 X85.397 Y100.093 E.34988
G1 X85.424 Y99.261 E.03164
G1 X85.41 Y98.555 E.02685
G1 X85.443 Y97.976 E.02202
G1 X85.43 Y92.571 E.20542
G1 X85.446 Y92.116 E.01731
G1 X85.441 Y90.625 E.05666
G1 X85.395 Y90.486 E.00557
G1 X85.395 Y89.514 E.03696
G1 X85.441 Y89.375 E.00557
G1 X85.446 Y87.884 E.05666
G1 X85.43 Y87.429 E.01731
G1 X85.443 Y82.024 E.20542
G1 X85.41 Y81.445 E.02202
G1 X85.424 Y80.739 E.02685
G1 X85.399 Y79.967 E.02936
M204 S6000
G1 X84.94 Y79.45 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X95.062 Y79.45 E.3847
G1 X95.06 Y80.071 E.02359
G1 X95.034 Y80.741 E.02551
G1 X95.034 Y82.489 E.06642
G1 X95.062 Y82.768 E.01064
G1 X95.034 Y83.441 E.02562
G1 X95.034 Y87.889 E.16905
G1 X95.062 Y88.166 E.01059
G1 X95.047 Y88.445 E.01059
G1 X95.063 Y89.949 E.05719
G1 X95.047 Y91.555 E.06104
G1 X95.062 Y91.834 E.01059
G1 X95.034 Y92.111 E.01059
G1 X95.034 Y96.559 E.16905
G1 X95.062 Y97.232 E.02562
G1 X95.034 Y97.511 E.01064
G1 X95.034 Y99.259 E.06642
G1 X95.062 Y100.55 E.0491
G1 X84.94 Y100.55 E.38468
G1 X84.94 Y99.898 E.02479
G1 X84.967 Y99.256 E.0244
G1 X84.952 Y98.546 E.027
G1 X84.986 Y97.964 E.02218
G1 X84.973 Y92.564 E.20521
G1 X84.989 Y92.109 E.01731
G1 X84.984 Y90.7 E.05357
G1 X84.938 Y90.56 E.00559
G1 X84.938 Y89.44 E.04255
G1 X84.984 Y89.3 E.00559
G1 X84.989 Y87.891 E.05357
G1 X84.973 Y87.436 E.01731
G1 X84.986 Y82.037 E.20521
G1 X84.952 Y81.454 E.02218
G1 X84.967 Y80.744 E.027
G1 X84.94 Y80.102 E.0244
G1 X84.94 Y79.51 E.02251
; WIPE_START
G1 X86.94 Y79.498 E-.38
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




G1 X93.937 Y81.494
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51435
G1 F900
M204 S500
G1 X93.196 Y80.753 E.04109
G1 X92.529 Y80.753 E.02613
G1 X93.732 Y81.955 E.06665
G1 X93.739 Y82.629 E.02643
G1 X91.863 Y80.753 E.10402
G1 X91.196 Y80.753 E.02613
G1 X93.737 Y83.293 E.14085
G1 X93.732 Y83.955 E.02594
G1 X90.529 Y80.753 E.17753
G1 X89.863 Y80.753 E.02613
G1 X93.732 Y84.622 E.21449
G1 X93.732 Y85.047 E.01669
G1 X93.491 Y85.047 E.00944
G1 X89.196 Y80.753 E.23809
G1 X88.529 Y80.753 E.02613
G1 X92.824 Y85.047 E.23809
G1 X92.157 Y85.047 E.02613
G1 X87.863 Y80.753 E.23809
G1 X87.196 Y80.753 E.02613
G1 X91.491 Y85.047 E.23809
G1 X90.824 Y85.047 E.02613
G1 X86.529 Y80.753 E.23809
G1 X86.269 Y80.753 E.01019
G1 X86.261 Y81.151 E.01564
G1 X90.157 Y85.047 E.21599
G1 X89.491 Y85.047 E.02613
G1 X86.279 Y81.836 E.17803
G1 X86.287 Y82.511 E.02646
G1 X88.824 Y85.047 E.14062
G1 X88.157 Y85.047 E.02613
G1 X86.286 Y83.176 E.10374
G1 X86.284 Y83.841 E.02607
G1 X87.49 Y85.047 E.06687
G1 X86.824 Y85.047 E.02613
G1 X86.077 Y84.301 E.04138
; WIPE_START
G1 X86.824 Y85.047 E-.20055
G1 X87.49 Y85.047 E-.12668
G1 X87.294 Y84.851 E-.05277
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X91.098 Y91.468 Z.6 F18000
G1 X92.982 Y94.747 Z.6
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.51481
G1 F900
M204 S500
G1 X93.732 Y95.497 E.0416
G1 X93.732 Y96.164 E.02619
G1 X92.52 Y94.953 E.06722
G1 X91.853 Y94.953 E.02619
G1 X93.742 Y96.842 E.10484
M73 P26 R24
G1 X93.757 Y97.194 E.01384
G1 X93.732 Y97.499 E.01199
G1 X91.186 Y94.953 E.1413
G1 X90.518 Y94.953 E.02619
G1 X93.736 Y98.17 E.17856
G1 X93.74 Y98.842 E.02635
G1 X89.851 Y94.953 E.21583
G1 X89.184 Y94.953 E.02619
G1 X93.478 Y99.247 E.23833
G1 X92.811 Y99.247 E.02619
G1 X88.516 Y94.953 E.23833
G1 X87.849 Y94.953 E.02619
G1 X92.144 Y99.247 E.23833
G1 X91.476 Y99.247 E.02619
G1 X87.181 Y94.953 E.23833
G1 X86.514 Y94.953 E.02619
G1 X90.809 Y99.247 E.23833
G1 X90.142 Y99.247 E.02619
G1 X86.282 Y95.388 E.21416
G1 X86.284 Y96.057 E.02625
G1 X89.474 Y99.247 E.17703
G1 X88.807 Y99.247 E.02619
G1 X86.286 Y96.726 E.13991
G1 X86.287 Y97.395 E.02625
G1 X88.14 Y99.247 E.10279
G1 X87.472 Y99.247 E.02619
G1 X86.285 Y98.06 E.06588
G1 X86.258 Y98.701 E.02515
G1 X87.011 Y99.453 E.04175
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X86.258 Y98.701 E-.20215
G1 X86.285 Y98.06 E-.1218
G1 X86.494 Y98.269 E-.05605
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 2/74
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
; open powerlost recovery
M1003 S1
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I1.214 J-.089 P1  F18000
G1 X85.557 Y85.557 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X85.557 Y94.443 E.1881
G1 X85.557 Y85.617 E.18683
; WIPE_START
M204 S6000
G1 X87.557 Y85.603 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.509 Y93.163 Z.72 F18000
G1 X86.39 Y94.019 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.664 Y84.017 Z.72 F18000
G1 X85.282 Y80.243 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.723 Y80.243 E.19984
G1 X94.763 Y80.483 E.00515
G1 X94.756 Y81.925 E.03052
G1 X94.728 Y82.49 E.01196
G1 X94.761 Y83.176 E.01455
G1 X94.756 Y87.33 E.08792
G1 X94.735 Y87.819 E.01035
G1 X94.761 Y88.729 E.01927
G1 X94.732 Y88.906 E.00379
G1 X94.751 Y90 E.02317
G1 X94.732 Y91.094 E.02317
G1 X94.761 Y91.271 E.00379
G1 X94.735 Y92.181 E.01927
G1 X94.756 Y92.67 E.01035
G1 X94.761 Y96.824 E.08792
G1 X94.728 Y97.51 E.01455
G1 X94.756 Y98.075 E.01197
G1 X94.764 Y99.514 E.03045
G1 X94.723 Y99.757 E.00521
G1 X85.282 Y99.757 E.19984
G1 X85.236 Y99.442 E.00672
G1 X85.254 Y97.46 E.04195
G1 X85.246 Y94.388 E.06504
G1 X85.272 Y92.752 E.03463
G1 X85.239 Y91.282 E.03112
G1 X85.268 Y91.116 E.00357
G1 X85.274 Y90.109 E.02131
G1 X85.254 Y90 E.00234
G1 X85.274 Y89.891 E.00234
G1 X85.268 Y88.884 E.02131
G1 X85.239 Y88.718 E.00357
G1 X85.272 Y87.249 E.03112
G1 X85.246 Y85.612 E.03463
G1 X85.254 Y82.543 E.06497
G1 X85.237 Y80.489 E.04347
G1 X85.271 Y80.303 E.00402
M204 S10000
G1 X84.847 Y79.819 F18000
G1 F1641.765
M204 S500
G1 X84.873 Y79.819 E.00055
G1 F1500
G1 X95.128 Y79.819 E.21707
G1 F1676.191
G1 X95.16 Y79.819 E.00068
G1 F2357.113
G1 X95.156 Y80.261 E.00936
G1 X95.188 Y80.449 E.00404
G1 F2160
G1 X95.185 Y81.049 E.0127
G1 F2340
G1 X95.18 Y81.937 E.01878
G1 F2357.113
G1 X95.153 Y82.49 E.01172
G1 X95.185 Y83.167 E.01434
G1 F2340
G1 X95.18 Y87.34 E.08833
G1 F2357.113
G1 X95.16 Y87.822 E.01021
G1 X95.186 Y88.758 E.01982
G1 X95.156 Y88.939 E.00388
G1 X95.165 Y89.898 E.0203
G1 X95.18 Y90 E.00219
G1 X95.165 Y90.102 E.00219
G1 X95.156 Y91.061 E.0203
G1 X95.186 Y91.242 E.00388
G1 X95.16 Y92.178 E.01982
G1 X95.18 Y92.66 E.01021
G1 F2340
G1 X95.185 Y96.833 E.08833
G1 F2357.113
G1 X95.153 Y97.51 E.01434
G1 X95.18 Y98.064 E.01173
G1 F2340
G1 X95.184 Y98.691 E.01329
G1 F2160
G1 X95.188 Y99.291 E.0127
G1 F2340
G1 X95.188 Y99.549 E.00545
G1 F2357.113
G1 X95.156 Y99.739 E.00407
G1 X95.16 Y100.181 E.00936
G1 F1677.099
G1 X95.128 Y100.181 E.00068
G1 F1500
G1 X84.873 Y100.181 E.21706
G1 F1641.765
G1 X84.847 Y100.181 E.00055
G1 F2357.113
G1 X84.844 Y99.723 E.00968
G1 X84.812 Y99.544 E.00385
G1 F2340
G1 X84.817 Y98.84 E.0149
G1 F2160
G1 X84.824 Y98.058 E.01655
G1 F1980
G1 X84.83 Y97.458 E.0127
G1 F2160
G1 X84.828 Y96.858 E.0127
G1 F1800
G1 X84.821 Y94.385 E.05235
G1 F1980
G1 X84.831 Y93.785 E.0127
G1 F2340
G1 X84.838 Y93.353 E.00915
G1 F2357.113
G1 X84.848 Y92.753 E.0127
G1 X84.834 Y92.153 E.0127
G1 F2160
G1 X84.827 Y91.848 E.00645
G1 F1800
G1 X84.813 Y91.249 E.0127
G1 F2160
G1 X84.844 Y91.077 E.0037
G1 F2357.113
G1 X84.85 Y90.146 E.01971
G1 X84.823 Y90 E.00313
G1 X84.85 Y89.854 E.00313
G1 X84.844 Y88.923 E.01971
G1 F2160
G1 X84.813 Y88.751 E.0037
G1 F1800
G1 X84.827 Y88.152 E.0127
G1 F2160
G1 X84.834 Y87.847 E.00645
G1 F2357.113
G1 X84.848 Y87.247 E.0127
G1 X84.838 Y86.647 E.0127
G1 F2340
G1 X84.831 Y86.215 E.00915
G1 F1980
G1 X84.821 Y85.615 E.0127
G1 F1800
G1 X84.823 Y85.015 E.0127
G1 F2160
G1 X84.83 Y82.543 E.05232
G1 F1980
G1 X84.825 Y81.943 E.0127
G1 F2160
G1 X84.818 Y81.053 E.01885
G1 F2340
G1 X84.813 Y80.453 E.0127
G1 F2357.113
G1 X84.844 Y80.277 E.00379
G1 X84.847 Y79.879 E.00841
M204 S250
G1 X84.49 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F720
M204 S500
G1 X84.859 Y79.41 E.00726
G1 F1500
G1 X85.259 Y79.41 E.00787
G1 X94.743 Y79.41 E.18654
G1 X95.143 Y79.41 E.00787
G1 F720
G1 X95.512 Y79.41 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F600
G1 X95.573 Y79.41 E.00128
G1 X95.566 Y80.229 E.01734

G1 X95.597 Y80.417 E.00402
G1 X95.589 Y81.948 E.03241
G1 X95.563 Y82.49 E.01149
G1 X95.595 Y83.157 E.01413
G1 X95.589 Y87.349 E.08871
G1 X95.569 Y87.825 E.01008
G1 X95.597 Y88.786 E.02035
G1 X95.566 Y88.971 E.00397
G1 X95.574 Y89.865 E.01893
G1 X95.594 Y90 E.00289
G1 X95.574 Y90.135 E.00289
G1 X95.566 Y91.029 E.01893
G1 X95.597 Y91.214 E.00397
G1 X95.569 Y92.175 E.02035
G1 X95.589 Y92.651 E.01008
G1 X95.595 Y96.843 E.08871
G1 X95.563 Y97.51 E.01413
G1 X95.589 Y98.052 E.0115
G1 X95.597 Y99.583 E.03239
G1 X95.566 Y99.771 E.00403
G1 X95.573 Y100.59 E.01734
G1 X95.512 Y100.59 E.00129
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X95.143 Y100.59 E.00726
G1 F1500
G1 X94.743 Y100.59 E.00787
G1 X85.259 Y100.59 E.18653
G1 X84.859 Y100.59 E.00787
G1 F720
G1 X84.49 Y100.59 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F600
G1 X84.44 Y100.59 E.00107
G1 X84.435 Y99.761 E.01754
G1 X84.403 Y99.581 E.00387
G1 X84.403 Y99.438 E.00302
G1 X84.421 Y97.456 E.04195
G1 X84.412 Y94.382 E.06506
G1 X84.438 Y92.754 E.03447
G1 X84.403 Y91.216 E.03255
G1 X84.435 Y91.039 E.00382
G1 X84.44 Y90.181 E.01815
G1 X84.407 Y90 E.0039
G1 X84.44 Y89.819 E.0039
G1 X84.435 Y88.961 E.01815
G1 X84.403 Y88.784 E.00382
G1 X84.438 Y87.246 E.03255
M73 P27 R24
G1 X84.412 Y85.618 E.03447
G1 X84.421 Y82.544 E.06506
G1 X84.403 Y80.418 E.045
G1 X84.435 Y80.239 E.00385
G1 X84.44 Y79.42 E.01734
; WIPE_START
M204 S6000
G1 X84.859 Y79.41 E-.0797
G1 X85.259 Y79.41 E-.076
G1 X86.44 Y79.41 E-.2243
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




G1 X87.672 Y83.137
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.498942
G1 F1500
M204 S6000
G1 X92.337 Y83.137 E.11011
G1 X92.314 Y82.663 E.01118
G1 X87.674 Y82.663 E.10955
G1 X87.673 Y83.077 E.00975
M204 S10000
G1 X87.237 Y83.57 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X92.774 Y83.57 E.1089
G1 X92.744 Y82.573 E.01962
G1 X92.753 Y82.23 E.00676
G1 X87.238 Y82.23 E.10847
G1 X87.238 Y83.51 E.02519
M204 S10000
G1 X86.842 Y83.965 F18000
G1 F1500
M204 S6000
G1 X93.168 Y83.965 E.12442
G1 X93.169 Y83.231 E.01442
G1 X93.138 Y82.555 E.01332
G1 X93.164 Y81.835 E.01416
G1 X86.84 Y81.835 E.12439
G1 X86.842 Y83.905 E.0407
M204 S10000
G1 X86.447 Y84.359 F18000
G1 F1500
M204 S6000
G1 X93.562 Y84.359 E.13995
G1 X93.563 Y83.232 E.02217
G1 X93.532 Y82.536 E.0137
G1 X93.561 Y81.441 E.02154
G1 X86.443 Y81.441 E.14
G1 X86.447 Y84.299 E.05621
M204 S10000
G1 X86.051 Y84.753 F18000
G1 F1500
M204 S6000
G1 X93.956 Y84.753 E.15547
G1 X93.958 Y83.232 E.02991
G1 X93.925 Y82.517 E.01407
G1 X93.952 Y81.922 E.01172
G1 X93.957 Y81.047 E.01721
G1 X86.045 Y81.047 E.15561
G1 X86.052 Y84.693 E.07171
M204 S10000
G1 X85.656 Y85.147 F18000
G1 F1500
M204 S6000
G1 X94.349 Y85.147 E.17099
G1 X94.352 Y83.233 E.03766
G1 X94.319 Y82.499 E.01445
G1 X94.347 Y81.887 E.01204
G1 X94.353 Y80.653 E.02428
G1 X85.648 Y80.653 E.17122
G1 X85.656 Y85.087 E.08722
; WIPE_START
G1 X85.652 Y83.087 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.76 Y90.639 Z.72 F18000
G1 X87.672 Y96.863 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.498952
G1 F1500
M204 S6000
G1 X87.674 Y97.337 E.01117
M73 P27 R23
G1 X92.314 Y97.337 E.10955
G1 X92.337 Y96.863 E.01118
G1 X87.732 Y96.863 E.1087
M204 S10000
G1 X87.237 Y96.43 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X87.238 Y97.77 E.02637
G1 X92.753 Y97.77 E.10847
G1 X92.774 Y96.43 E.02637
G1 X87.297 Y96.43 E.10772
M204 S10000
G1 X86.842 Y96.035 F18000
G1 F1500
M204 S6000
G1 X86.84 Y98.165 E.04188
G1 X93.165 Y98.165 E.1244
G1 X93.138 Y97.578 E.01155
G1 X93.169 Y96.769 E.01592
G1 X93.168 Y96.035 E.01442
G1 X86.902 Y96.035 E.12324
M204 S10000
G1 X86.447 Y95.641 F18000
G1 F1500
M204 S6000
G1 X86.442 Y98.559 E.05739
G1 X93.561 Y98.559 E.14002
G1 X93.532 Y97.559 E.01968
G1 X93.563 Y96.768 E.01556
G1 X93.562 Y95.641 E.02217
G1 X86.507 Y95.641 E.13877
M204 S10000
G1 X86.051 Y95.247 F18000
G1 F1500
M204 S6000
G1 X86.044 Y98.953 E.07289
G1 X93.957 Y98.953 E.15564
G1 X93.953 Y98.097 E.01684
G1 X93.925 Y97.539 E.01098
G1 X93.958 Y96.768 E.01519
G1 X93.956 Y95.247 E.02991
G1 X86.111 Y95.247 E.15429
M204 S10000
G1 X85.656 Y94.853 F18000
G1 F1500
M204 S6000
G1 X85.663 Y97.462 E.05133
G1 X85.646 Y99.347 E.03708
G1 X94.353 Y99.347 E.17126
G1 X94.347 Y98.086 E.0248
G1 X94.319 Y97.52 E.01115
G1 X94.352 Y96.767 E.01482
G1 X94.349 Y94.853 E.03766
G1 X85.716 Y94.853 E.16981
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X87.716 Y94.853 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/74
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I.359 J-1.163 P1  F18000
G1 X86.39 Y94.443 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.47 Y84.039 Z.84 F18000
G1 X84.987 Y80.243 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.016 Y80.243 E.21227
G1 X95.002 Y82.1 E.0393
G1 X95.018 Y82.65 E.01164
G1 X95.007 Y84.337 E.0357
G1 X94.992 Y84.568 E.00492
G1 X95.023 Y88.803 E.08963
G1 X95.007 Y94.931 E.12971
G1 X94.991 Y95.418 E.0103
G1 X95.007 Y95.663 E.00521
G1 X95.018 Y97.35 E.0357
G1 X95.002 Y97.9 E.01164
G1 X95.016 Y99.757 E.0393
G1 X84.987 Y99.757 E.21226
G1 X84.979 Y97.751 E.04245
G1 X85.005 Y97.352 E.00846
G1 X85.005 Y94.606 E.05811
G1 X84.977 Y93.299 E.02768
G1 X85.006 Y91.908 E.02945
G1 X84.978 Y91.18 E.01542
G1 X84.978 Y88.82 E.04994
G1 X85.006 Y88.092 E.01543
G1 X84.977 Y86.751 E.02838
G1 X85.005 Y85.393 E.02875
G1 X85.005 Y82.648 E.0581
G1 X84.979 Y82.249 E.00846
G1 X84.987 Y80.303 E.04118
M204 S10000
G1 X84.559 Y79.819 F18000
G1 F1500
M204 S500
G1 X95.443 Y79.819 E.23037
G1 X95.426 Y82.096 E.04818
G1 X95.442 Y82.645 E.01163
G1 X95.431 Y84.352 E.03613
G1 X95.416 Y84.581 E.00486
G1 X95.447 Y88.803 E.08935
G1 X95.431 Y94.939 E.12988
G1 X95.415 Y95.41 E.00998
G1 X95.431 Y95.648 E.00503
G1 X95.442 Y97.355 E.03613
M73 P28 R23
G1 X95.426 Y97.904 E.01163
G1 X95.443 Y100.181 E.04819
G1 X84.559 Y100.181 E.23036
G1 X84.569 Y98.986 E.0253
G1 X84.553 Y98.684 E.0064
G1 X84.555 Y97.736 E.02005
G1 X84.581 Y97.338 E.00845
G1 X84.581 Y94.611 E.05772
G1 X84.553 Y93.299 E.02777
G1 X84.581 Y91.912 E.02937
G1 X84.553 Y91.188 E.01533
G1 X84.553 Y88.812 E.05029
G1 X84.581 Y88.088 E.01533
G1 X84.553 Y86.752 E.02829
G1 X84.581 Y85.389 E.02885
G1 X84.581 Y82.662 E.05771
G1 X84.555 Y82.264 E.00845
G1 X84.553 Y81.316 E.02005
G1 X84.569 Y81.014 E.0064
G1 X84.56 Y79.879 E.02403
M204 S250
G1 X84.399 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.614 Y79.41 E.22059
G1 F1440
G1 X95.856 Y79.41 E.00476
G1 F600
G1 X95.851 Y80.01 E.0118
G1 X95.846 Y80.751 E.01457
G1 X95.835 Y82.091 E.02637
G1 X95.851 Y82.64 E.0108
G1 X95.844 Y83.767 E.02217
G1 X95.841 Y84.367 E.0118
G1 X95.825 Y84.594 E.00446
G1 X95.835 Y85.946 E.02659
G1 X95.841 Y86.698 E.01479
G1 X95.857 Y88.801 E.04138
G1 X95.853 Y90.226 E.02801
G1 X95.851 Y91.05 E.01621
G1 X95.846 Y92.698 E.03242
G1 X95.844 Y93.522 E.01621
G1 X95.841 Y94.947 E.02801
G1 X95.825 Y95.404 E.00899
G1 X95.841 Y95.633 E.00452
G1 X95.844 Y96.233 E.0118
G1 X95.851 Y97.36 E.02217
G1 X95.835 Y97.909 E.01081
G1 X95.84 Y98.509 E.0118
G1 X95.845 Y99.249 E.01457
G1 X95.855 Y100.59 E.02637
G1 F1440
G1 X95.614 Y100.59 E.00475
G1 F1500
G1 X84.399 Y100.59 E.22059
G1 F1440
G1 X84.147 Y100.59 E.00496
G1 F600
G1 X84.152 Y99.99 E.0118
G1 X84.155 Y99.595 E.00777
G1 X84.16 Y98.995 E.0118
G1 X84.144 Y98.694 E.00592
G1 X84.146 Y97.723 E.01912
G1 X84.172 Y97.325 E.00784
G1 X84.159 Y94.016 E.06508
G1 X84.157 Y93.899 E.00229
G1 X84.144 Y93.3 E.0118
G1 X84.156 Y92.7 E.0118
G1 X84.16 Y92.515 E.00363
G1 X84.172 Y91.915 E.0118
G1 X84.144 Y91.196 E.01417
G1 X84.144 Y88.804 E.04705
G1 X84.172 Y88.084 E.01417
G1 X84.159 Y87.484 E.0118
G1 X84.156 Y87.352 E.00261
G1 X84.144 Y86.752 E.0118
G1 X84.156 Y86.152 E.0118
G1 X84.16 Y85.984 E.00329
G1 X84.172 Y82.675 E.06508
G1 X84.146 Y82.277 E.00784
G1 X84.144 Y81.306 E.01912
G1 X84.16 Y81.005 E.00592
G1 X84.155 Y80.405 E.0118
G1 X84.152 Y80.01 E.00777
G1 X84.147 Y79.41 E.0118
G1 F1430.031
G1 X84.339 Y79.41 E.00378
; WIPE_START
M204 S6000
G1 X86.339 Y79.41 E-.38
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
G1 X85.281 Y85.345
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.170485
G1 F1500
M204 S6000
G1 X85.267 Y93.299 E.05744
G1 X85.281 Y94.656 E.0098
M204 S10000
G1 X85.987 Y95.247 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.949 Y95.327 E.00175
G1 X85.809 Y95.377 E.00292
G1 X85.787 Y98.953 E.07034
G1 X94.206 Y98.953 E.16558
G1 X94.204 Y95.708 E.06384
G1 X94.187 Y95.407 E.00592
G1 X94.058 Y95.329 E.00297
G1 X94.019 Y95.247 E.00179
G1 X86.047 Y95.247 E.1568
M204 S10000
G1 X86.203 Y95.641 F18000
G1 F1500
M204 S6000
G1 X86.203 Y97.359 E.03378
G1 X86.18 Y98.559 E.02361
G1 X93.809 Y98.559 E.15005
G1 X93.805 Y95.641 E.05739
G1 X86.263 Y95.641 E.14834
M204 S10000
G1 X86.597 Y96.035 F18000
G1 F1500
M204 S6000
G1 X86.597 Y97.359 E.02603
G1 X86.573 Y98.165 E.01586
G1 X93.412 Y98.165 E.13451
G1 X93.418 Y96.035 E.04188
G1 X86.657 Y96.035 E.13297
M204 S10000
G1 X86.992 Y96.43 F18000
G1 F1500
M204 S6000
G1 X86.992 Y97.359 E.01827
G1 X86.968 Y97.77 E.00811
G1 X93.018 Y97.77 E.119
G1 X93.026 Y96.43 E.02637
G1 X87.052 Y96.43 E.1175
; WIPE_START
G1 X89.052 Y96.43 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.36 Y96.863 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.498952
G1 F1500
M204 S6000
G1 X87.425 Y96.863 E.11649
G1 X87.425 Y97.337 E.01117
G1 X92.36 Y97.337 E.11649
G1 X92.598 Y97.322 E.00563
G1 X92.595 Y96.863 E.01083
G1 X92.42 Y96.863 E.00413
; WIPE_START
G1 X92.595 Y96.863 E-.03328
G1 X92.598 Y97.322 E-.08717
G1 X92.36 Y97.337 E-.0453
G1 X91.232 Y97.337 E-.21426
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.216 Y94.853 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.778 Y94.853 E.16597
G1 X85.703 Y95.019 E.00358
G1 X85.415 Y95.063 E.00575
G1 X85.415 Y97.359 E.04514
G1 X85.389 Y97.817 E.00903
G1 X85.395 Y99.347 E.0301
G1 X94.603 Y99.347 E.18112
G1 X94.592 Y95.065 E.08424
G1 X94.332 Y95.039 E.00515
G1 X94.248 Y94.904 E.00313
M204 S10000
G1 X94.726 Y94.656 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.171387
G1 F1500
M204 S6000
G1 X94.721 Y85.345 E.06765
; WIPE_START
G1 X94.722 Y87.345 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.36 Y83.137 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.498952
G1 F1500
M204 S6000
G1 X92.595 Y83.137 E.00555
G1 X92.598 Y82.678 E.01083
G1 X92.36 Y82.663 E.00563
G1 X87.425 Y82.663 E.11649
G1 X87.425 Y83.137 E.01117
G1 X92.3 Y83.137 E.11507
; WIPE_START
G1 X90.3 Y83.137 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.992 Y83.57 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.026 Y83.57 E.11868
G1 X93.018 Y82.23 E.02637
G1 X86.968 Y82.23 E.119
G1 X86.992 Y83.51 E.02519
M204 S10000
G1 X86.597 Y83.965 F18000
G1 F1500
M204 S6000
G1 X93.418 Y83.965 E.13415
G1 X93.412 Y81.835 E.04188
G1 X86.573 Y81.835 E.13451
G1 X86.594 Y82.551 E.01408
G1 X86.597 Y83.905 E.02663
M204 S10000
G1 X86.203 Y84.359 F18000
G1 F1500
M204 S6000
G1 X93.809 Y84.359 E.1496
G1 X93.809 Y81.441 E.05739
G1 X86.18 Y81.441 E.15005
G1 X86.203 Y84.299 E.05621
M204 S10000
G1 X85.986 Y84.753 F18000
G1 F1500
M204 S6000
G1 X94.015 Y84.753 E.15793
G1 X94.056 Y84.67 E.00183
G1 X94.2 Y84.619 E.00299
G1 X94.206 Y81.047 E.07026
G1 X85.787 Y81.047 E.16559
G1 X85.809 Y84.624 E.07035
G1 X85.947 Y84.673 E.00289
G1 X85.96 Y84.699 E.00057
M204 S10000
G1 X85.788 Y85.147 F18000
M73 P29 R23
G1 F1500
M204 S6000
G1 X94.225 Y85.147 E.16596
G1 X94.3 Y84.979 E.00363
G1 X94.589 Y84.936 E.00575
G1 X94.604 Y80.653 E.08424
G1 X85.395 Y80.653 E.18112
G1 X85.388 Y82.237 E.03116
G1 X85.415 Y82.9 E.01306
G1 X85.415 Y84.937 E.04006
G1 X85.702 Y84.981 E.00572
G1 X85.76 Y85.094 E.0025
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X85.702 Y84.981 E-.02413
G1 X85.415 Y84.937 E-.05522
G1 X85.415 Y83.354 E-.30065
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 4/74
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-1.212 J.107 P1  F18000
G1 X86.39 Y94.443 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.326 Y84.058 Z.96 F18000
G1 X84.766 Y80.243 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.235 Y80.243 E.22159
G1 X95.235 Y84.181 E.08333
G1 X95.208 Y84.578 E.00843
G1 X95.236 Y85.684 E.02341
G1 X95.236 Y94.316 E.18272
G1 X95.208 Y95.422 E.02341
G1 X95.235 Y95.819 E.00842
G1 X95.235 Y99.757 E.08334
G1 X84.766 Y99.757 E.22158
G1 X84.769 Y94.499 E.11127
G1 X84.796 Y93.526 E.0206
G1 X84.764 Y91.791 E.03675
G1 X84.764 Y88.209 E.0758
G1 X84.796 Y86.474 E.03675
G1 X84.769 Y85.501 E.0206
G1 X84.766 Y80.303 E.11
M204 S10000
G1 X84.342 Y79.819 F18000
G1 F1500
M204 S500
G1 X95.66 Y79.819 E.23956
G1 X95.659 Y84.195 E.09262
G1 X95.632 Y84.587 E.00831
G1 X95.66 Y85.678 E.02311
G1 X95.66 Y94.322 E.18295
G1 X95.632 Y95.413 E.02311
G1 X95.659 Y95.805 E.00831
G1 X95.659 Y100.181 E.09262
G1 X84.342 Y100.181 E.23954
G1 X84.345 Y94.494 E.12037
G1 X84.371 Y93.524 E.02052
G1 X84.34 Y91.794 E.03662
G1 X84.34 Y88.206 E.07596
G1 X84.371 Y86.476 E.03662
G1 X84.345 Y85.506 E.02052
G1 X84.342 Y79.879 E.1191
M204 S250
G1 X84.104 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.898 Y79.41 E.23198
G1 F1992.538
G1 X96.068 Y79.41 E.00335
G1 F840
G1 X96.069 Y79.864 E.00893
G1 X96.069 Y80.464 E.0118
G1 F720
G1 X96.069 Y82.037 E.03093
G1 F600
G1 X96.068 Y84.209 E.04273
G1 F720
G1 X96.042 Y84.596 E.00762
G1 F840
G1 X96.069 Y85.673 E.0212
G1 F600
G1 X96.069 Y94.327 E.17022
G1 F840
G1 X96.042 Y95.404 E.0212
G1 F720
G1 X96.068 Y95.791 E.00762
G1 F600
G1 X96.068 Y96.391 E.0118
G1 F720
G1 X96.068 Y98.19 E.0354
G1 F840
G1 X96.068 Y100.59 E.0472
G1 F1217.101
G1 X95.898 Y100.59 E.00335
G1 F1500
G1 X84.104 Y100.59 E.23198
G1 F1995.787
G1 X83.932 Y100.59 E.00338
G1 F840
G1 X83.933 Y99.99 E.0118
G1 F720
G1 X83.934 Y97.539 E.04821
G1 F600
G1 X83.934 Y96.313 E.02411
G1 X83.935 Y94.488 E.03591
G1 F840
G1 X83.962 Y93.522 E.019
G1 F1200
G1 X83.951 Y92.923 E.0118
G1 F840
G1 X83.942 Y92.398 E.01032
G1 F600
G1 X83.942 Y87.602 E.09433
G1 F840
G1 X83.951 Y87.077 E.01032
G1 F1200
G1 X83.962 Y86.478 E.0118
G1 F840
G1 X83.935 Y85.512 E.019
G1 F600
G1 X83.935 Y84.912 E.0118
G1 X83.934 Y83.687 E.02411
G1 F720
G1 X83.933 Y81.236 E.04821
G1 F840
G1 X83.932 Y79.41 E.03591
G1 F1347.964
G1 X84.044 Y79.41 E.0022
; WIPE_START
M204 S6000
G1 X86.044 Y79.41 E-.38
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




G1 X87.188 Y83.137
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.498957
G1 F1500
M204 S6000
G1 X92.815 Y83.137 E.13285
G1 X92.815 Y82.663 E.01117
G1 X87.187 Y82.663 E.13286
G1 X87.188 Y83.077 E.00976
M204 S10000
G1 X86.754 Y83.57 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.249 Y83.57 E.12774
G1 X93.249 Y82.23 E.02637
G1 X86.753 Y82.23 E.12776
G1 X86.754 Y83.51 E.02519
M204 S10000
G1 X86.36 Y83.965 F18000
G1 F1500
M204 S6000
G1 X93.643 Y83.965 E.14324
G1 X93.643 Y81.835 E.04188
G1 X86.359 Y81.835 E.14327
G1 X86.36 Y83.905 E.0407
M204 S10000
G1 X86.137 Y84.359 F18000
G1 F1500
M204 S6000
G1 X93.867 Y84.359 E.15204
G1 X93.979 Y84.26 E.00293
G1 X94.036 Y84.246 E.00115
G1 X94.037 Y81.441 E.05517
G1 X85.964 Y81.441 E.15879
G1 X85.966 Y84.264 E.05552
G1 X86.109 Y84.306 E.00293
M204 S10000
G1 X85.955 Y84.753 F18000
G1 F1500
M204 S6000
G1 X94.047 Y84.753 E.15915
G1 X94.159 Y84.611 E.00356
G1 X94.426 Y84.541 E.00543
M73 P30 R23
G1 X94.432 Y81.047 E.06873
G1 X85.57 Y81.047 E.1743
G1 X85.572 Y84.541 E.06872
G1 X85.891 Y84.635 E.00654
G1 X85.927 Y84.7 E.00147
M204 S10000
G1 X85.784 Y85.147 F18000
G1 F1500
M204 S6000
G1 X94.231 Y85.147 E.16616
G1 X94.339 Y84.962 E.00421
G1 X94.815 Y84.935 E.00938
G1 X94.826 Y80.653 E.08424
G1 X85.176 Y80.653 E.18981
G1 X85.178 Y84.935 E.08423
G1 X85.562 Y84.93 E.00755
G1 X85.673 Y84.963 E.00228
G1 X85.753 Y85.096 E.00304
M204 S10000
G1 X85.163 Y85.345 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.383356
G1 F1500
M204 S6000
G1 X85.176 Y86.475 E.02018
G1 X85.161 Y91.786 E.09475
G1 X85.176 Y93.525 E.03101
G1 X85.163 Y94.656 E.02018
; WIPE_START
G1 X85.176 Y93.525 E-.2149
G1 X85.168 Y92.656 E-.1651
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.585 Y94.457 Z.96 F18000
G1 X94.217 Y94.853 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.762 Y94.853 E.1663
G1 X85.673 Y95.037 E.00402
G1 X85.562 Y95.07 E.00228
G1 X85.178 Y95.065 E.00755
G1 X85.176 Y99.347 E.08423
G1 X94.826 Y99.347 E.1898
G1 X94.825 Y95.865 E.06849
G1 X94.807 Y95.065 E.01574
G1 X94.335 Y95.041 E.00931
G1 X94.249 Y94.904 E.00319
M204 S10000
G1 X94.043 Y95.247 F18000
G1 F1500
M204 S6000
G1 X85.955 Y95.247 E.15907
G1 X85.891 Y95.365 E.00265
G1 X85.572 Y95.459 E.00654
G1 X85.57 Y98.953 E.06872
G1 X94.431 Y98.953 E.17429
G1 X94.431 Y95.865 E.06074
G1 X94.396 Y95.458 E.00804
G1 X94.106 Y95.363 E.00601
G1 X94.072 Y95.3 E.00142
M204 S10000
G1 X93.862 Y95.641 F18000
G1 F1500
M204 S6000
G1 X86.137 Y95.641 E.15194
G1 X86.108 Y95.694 E.00119
G1 X85.966 Y95.736 E.00292
G1 X85.964 Y98.559 E.05552
G1 X94.037 Y98.559 E.15878
G1 X94.037 Y95.865 E.05298
G1 X94.03 Y95.754 E.00219
G1 X93.891 Y95.694 E.00297
; WIPE_START
G1 X94.03 Y95.754 E-.0287
G1 X94.037 Y95.865 E-.02113
G1 X94.037 Y97.603 E-.33018
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.188 Y96.863 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.498957
G1 F1500
M204 S6000
G1 X87.187 Y97.337 E.01117
G1 X92.815 Y97.337 E.13286
M73 P30 R22
G1 X92.815 Y96.863 E.01117
G1 X87.248 Y96.863 E.13143
M204 S10000
G1 X86.754 Y96.43 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X86.753 Y97.77 E.02637
G1 X93.249 Y97.77 E.12775
G1 X93.249 Y96.43 E.02637
G1 X86.814 Y96.43 E.12656
M204 S10000
G1 X86.36 Y96.035 F18000
G1 F1500
M204 S6000
G1 X86.359 Y98.165 E.04188
G1 X93.643 Y98.165 E.14326
G1 X93.643 Y96.035 E.04188
G1 X86.42 Y96.035 E.14206
; WIPE_START
G1 X88.42 Y96.035 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.835 Y94.656 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.389301
G1 F1500
M204 S6000
G1 X94.835 Y85.345 E.16888
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X94.835 Y87.345 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/74
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.783 J-.932 P1  F18000
G1 X86.39 Y94.443 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.214 Y84.076 Z1.08 F18000
G1 X84.594 Y80.243 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.398 Y80.243 E.22867
G1 X95.414 Y80.382 E.00296
G1 X95.398 Y83.208 E.05982
G1 X95.417 Y84.651 E.03055
G1 X95.394 Y85.485 E.01766
G1 X95.394 Y86.859 E.02908
G1 X95.419 Y88.205 E.02849
G1 X95.414 Y88.818 E.01296
G1 X95.394 Y88.99 E.00368
G1 X95.419 Y90 E.02138
G1 X95.394 Y91.01 E.02138
G1 X95.414 Y91.182 E.00368
G1 X95.419 Y91.795 E.01296
G1 X95.394 Y93.141 E.02849
G1 X95.394 Y94.515 E.02908
G1 X95.418 Y95.35 E.01769
G1 X95.398 Y97.2 E.03916
G1 X95.419 Y99.001 E.03812
G1 X95.414 Y99.618 E.01305
G1 X95.398 Y99.757 E.00296
G1 X84.594 Y99.757 E.22867
G1 X84.582 Y98.7 E.02237
G1 X84.608 Y97.333 E.02893
G1 X84.603 Y94.394 E.0622
G1 X84.62 Y93.77 E.01322
G1 X84.582 Y92.329 E.03051
G1 X84.589 Y91.11 E.02578
G1 X84.604 Y90.973 E.00292
G1 X84.602 Y90.232 E.0157
G1 X84.585 Y90 E.00492
G1 X84.602 Y89.768 E.00492
G1 X84.604 Y89.027 E.0157
G1 X84.589 Y88.89 E.00292
G1 X84.582 Y87.671 E.02578
G1 X84.62 Y86.23 E.03051
G1 X84.603 Y85.606 E.01322
G1 X84.608 Y82.667 E.0622
G1 X84.582 Y81.3 E.02893
G1 X84.593 Y80.303 E.0211
M204 S10000
G1 X84.174 Y79.819 F18000
G1 F1500
M204 S500
G1 X95.824 Y79.819 E.24658
G1 X95.819 Y80.193 E.00792
G1 X95.838 Y80.356 E.00346
G1 X95.843 Y80.999 E.01362
G1 X95.822 Y83.208 E.04675
G1 X95.842 Y84.654 E.03062
G1 X95.818 Y85.491 E.01772
G1 X95.818 Y86.856 E.02888
G1 X95.843 Y88.203 E.02853
G1 X95.838 Y88.844 E.01357
G1 X95.819 Y89.01 E.00354
G1 X95.843 Y90 E.02095
G1 X95.819 Y90.99 E.02095
G1 X95.838 Y91.156 E.00354
G1 X95.843 Y91.797 E.01357
G1 X95.818 Y93.144 E.02853
G1 X95.818 Y94.509 E.02888
G1 X95.842 Y95.347 E.01774
G1 X95.822 Y97.2 E.03923
G1 X95.843 Y99.001 E.03811
G1 X95.838 Y99.644 E.01362
G1 X95.819 Y99.81 E.00354
G1 X95.828 Y100.181 E.00784
G1 X84.174 Y100.181 E.24666
G1 X84.158 Y98.698 E.03138
G1 X84.184 Y97.33 E.02897
G1 X84.178 Y94.389 E.06224
G1 X84.195 Y93.769 E.01312
G1 X84.158 Y92.333 E.03041
G1 X84.165 Y91.086 E.0264
G1 X84.18 Y90.951 E.00288
G1 X84.178 Y90.248 E.01488
G1 X84.159 Y90 E.00526
G1 X84.178 Y89.752 E.00526
G1 X84.18 Y89.049 E.01488
G1 X84.165 Y88.914 E.00288
G1 X84.158 Y87.667 E.0264
M73 P31 R22
G1 X84.195 Y86.231 E.03042
G1 X84.178 Y85.611 E.01312
G1 X84.184 Y82.67 E.06224
G1 X84.158 Y81.302 E.02897
G1 X84.173 Y79.879 E.03011
M204 S250
G1 X83.898 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.109 Y79.41 E.24019
G1 F1867.19
G1 X96.239 Y79.41 E.00254
G1 F1440
G1 X96.229 Y80.172 E.01498
G1 F1320
G1 X96.247 Y80.33 E.00313
G1 F1200
G1 X96.247 Y81.6 E.02497
G1 F1320
G1 X96.237 Y82.607 E.01982
G1 F1440
G1 X96.24 Y83.807 E.0236
G1 F1320
G1 X96.243 Y84.058 E.00493
G1 F1200
G1 X96.251 Y84.657 E.0118
G1 X96.228 Y85.497 E.01652
G1 F1440
G1 X96.228 Y86.097 E.0118
G1 F1560
G1 X96.228 Y86.852 E.01485
G1 F1440
G1 X96.239 Y87.452 E.0118
G1 F1320
G1 X96.252 Y88.201 E.01474
G1 F1200
G1 X96.247 Y88.87 E.01316
G1 F1320
G1 X96.228 Y89.03 E.00316
G1 X96.252 Y90 E.01909
G1 X96.228 Y90.97 E.01909
G1 X96.247 Y91.13 E.00316
G1 F1200
G1 X96.252 Y91.799 E.01316
G1 F1320
G1 X96.239 Y92.548 E.01474
G1 F1440
G1 X96.228 Y93.148 E.0118
G1 F1560
G1 X96.228 Y93.903 E.01485
G1 F1440
G1 X96.228 Y94.503 E.0118
G1 F1200
G1 X96.251 Y95.343 E.01653
G1 F1080
G1 X96.245 Y95.943 E.0118
G1 F1320
G1 X96.238 Y96.6 E.01293
G1 F1440
G1 X96.238 Y97.8 E.0236
G1 F1320
G1 X96.252 Y99 E.02361
G1 F1200
G1 X96.247 Y99.67 E.01317
G1 F1320
G1 X96.228 Y99.83 E.00316
G1 F1440
G1 X96.247 Y100.59 E.01496
G1 F1824.717
G1 X96.109 Y100.59 E.00271
G1 F1500
G1 X83.898 Y100.59 E.24019
G1 F1878.434
G1 X83.765 Y100.59 E.00262
G1 F1320
G1 X83.749 Y98.696 E.03725
G1 F1200
G1 X83.76 Y98.096 E.0118
G1 F1320
G1 X83.763 Y97.926 E.00335
G1 F1440
G1 X83.769 Y94.384 E.06968
G1 X83.786 Y93.769 E.01209
G1 F1200
G1 X83.748 Y92.337 E.02817
G1 X83.752 Y91.662 E.01328
G1 F1320
G1 X83.769 Y90.263 E.02751
G1 F1200
G1 X83.749 Y90 E.00519
G1 X83.769 Y89.737 E.00519
G1 F1320
G1 X83.752 Y88.338 E.02751
G1 F1200
G1 X83.748 Y87.663 E.01328
G1 X83.786 Y86.231 E.02817
G1 F1440
G1 X83.769 Y85.616 E.01209
G1 X83.763 Y82.074 E.06968
G1 F1320
G1 X83.76 Y81.904 E.00335
G1 F1200
G1 X83.749 Y81.304 E.0118
G1 F1320
G1 X83.765 Y79.41 E.03725
G1 F1713.713
G1 X83.838 Y79.41 E.00144
; WIPE_START
M204 S6000
G1 X85.838 Y79.41 E-.38
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




G1 X85.08 Y85.345
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.559044
G1 F1500
M204 S6000
G1 X85.08 Y94.656 E.24773
; WIPE_START
G1 X85.08 Y92.656 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.501 Y94.44 Z1.08 F18000
G1 X94.215 Y94.853 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.769 Y94.853 E.16613
G1 X85.672 Y95.042 E.00417
G1 X85.013 Y95.064 E.01298
G1 X84.999 Y99.347 E.08424
G1 X95.007 Y99.347 E.19685
G1 X94.989 Y97.198 E.04227
G1 X95 Y95.065 E.04197
G1 X94.428 Y95.065 E.01125
G1 X94.328 Y95.038 E.00203
G1 X94.247 Y94.904 E.0031
; WIPE_START
G1 X94.328 Y95.038 E-.02991
G1 X94.428 Y95.065 E-.01965
G1 X95 Y95.065 E-.10864
G1 X94.994 Y96.232 E-.22179
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.644 Y96.035 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X86.29 Y96.035 E.14464
G1 X86.198 Y96.08 E.00201
G1 X86.185 Y98.165 E.04101
G1 X93.817 Y98.165 E.15012
G1 X93.818 Y96.083 E.04095
G1 X93.702 Y96.051 E.00237
; WIPE_START
G1 X93.818 Y96.083 E-.02287
G1 X93.817 Y97.962 E-.35713
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.027 Y96.863 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.498957
G1 F1500
M204 S6000
G1 X87.034 Y97.337 E.01117
G1 X92.98 Y97.337 E.14036
G1 X92.982 Y96.863 E.01117
G1 X87.087 Y96.863 E.13916
M204 S10000
G1 X86.593 Y96.43 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X86.586 Y97.77 E.02637
G1 X93.418 Y97.77 E.13437
G1 X93.42 Y96.43 E.02637
G1 X86.653 Y96.43 E.1331
M204 S10000
G1 X86.12 Y95.641 F18000
G1 F1500
M204 S6000
G1 X86.076 Y95.719 E.00177
G1 X85.803 Y95.793 E.00555
G1 X85.806 Y97.333 E.03029
G1 X85.783 Y98.559 E.02412
G1 X94.216 Y98.559 E.16586
G1 X94.2 Y97.212 E.0265
G1 X94.215 Y95.796 E.02785
G1 X93.93 Y95.719 E.00581
G1 X93.886 Y95.641 E.00176
G1 X86.18 Y95.641 E.15156
M204 S10000
G1 X85.95 Y95.247 F18000
G1 F1500
M204 S6000
G1 X85.874 Y95.381 E.00302
G1 X85.566 Y95.464 E.00627
G1 X85.408 Y95.462 E.00311
G1 X85.412 Y97.334 E.03681
G1 X85.389 Y98.953 E.03186
G1 X94.615 Y98.953 E.18146
G1 X94.595 Y97.207 E.03434
G1 X94.613 Y95.459 E.03438
G1 X94.429 Y95.46 E.00362
G1 X94.129 Y95.379 E.0061
G1 X94.054 Y95.247 E.00299
G1 X86.01 Y95.247 E.15821
; WIPE_START
G1 X88.01 Y95.247 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.921 Y94.656 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.561352
G1 F1500
M204 S6000
G1 X94.919 Y85.345 E.2488
; WIPE_START
G1 X94.919 Y87.345 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.743 Y83.137 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.498952
G1 F1500
M204 S6000
G1 X92.979 Y83.137 E.00555
G1 X92.981 Y82.663 E.01117
G1 X87.028 Y82.663 E.14054
G1 X87.027 Y83.137 E.01117
G1 X92.683 Y83.137 E.13353
; WIPE_START
G1 X90.683 Y83.137 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.593 Y83.57 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.417 Y83.57 E.13422
G1 X93.417 Y82.23 E.02637
G1 X86.586 Y82.23 E.13436
G1 X86.593 Y83.51 E.02519
M204 S10000
G1 X86.36 Y83.965 F18000
G1 F1500
M204 S6000
G1 X93.716 Y83.965 E.14469
G1 X93.815 Y83.918 E.00216
G1 X93.814 Y81.835 E.04096
G1 X86.185 Y81.835 E.15006
G1 X86.198 Y83.92 E.04101
G1 X86.302 Y83.949 E.00212
M204 S10000
G1 X86.12 Y84.359 F18000
G1 F1500
M204 S6000
G1 X93.884 Y84.359 E.15271
G1 X93.928 Y84.282 E.00175
G1 X94.214 Y84.204 E.00581
G1 X94.2 Y83.223 E.01931
G1 X94.21 Y81.441 E.03504
G1 X85.783 Y81.441 E.16576
G1 X85.806 Y82.647 E.02372
G1 X85.803 Y84.207 E.03069
G1 X86.076 Y84.281 E.00555
G1 X86.09 Y84.307 E.00059
M204 S10000
G1 X85.95 Y84.753 F18000
G1 F1500
M204 S6000
G1 X94.052 Y84.753 E.15936
G1 X94.127 Y84.622 E.00297
G1 X94.426 Y84.541 E.00608
G1 X94.612 Y84.541 E.00367
G1 X94.595 Y83.217 E.02604
G1 X94.607 Y81.047 E.04269
G1 X85.389 Y81.047 E.18131
G1 X85.412 Y82.654 E.03162
G1 X85.408 Y84.538 E.03705
G1 X85.566 Y84.536 E.00311
G1 X85.874 Y84.619 E.00627
G1 X85.92 Y84.701 E.00184
M204 S10000
G1 X85.788 Y85.147 F18000
G1 F1500
M204 S6000
G1 X94.229 Y85.147 E.16601
G1 X94.326 Y84.962 E.00412
G1 X95 Y84.935 E.01326
G1 X94.989 Y83.208 E.03397
G1 X95.003 Y80.653 E.05027
G1 X84.999 Y80.653 E.19678
G1 X85.013 Y84.936 E.08424
G1 X85.57 Y84.931 E.01095
G1 X85.672 Y84.958 E.00209
G1 X85.757 Y85.096 E.00318
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X85.672 Y84.958 E-.03072
G1 X85.57 Y84.931 E-.0202
G1 X85.013 Y84.936 E-.10579
G1 X85.009 Y83.761 E-.22329
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/74
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-1.207 J.156 P1  F18000
G1 X86.39 Y94.443 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.103 Y84.094 Z1.2 F18000
G1 X84.421 Y80.243 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P32 R22
G1 F1500
M204 S500
G1 X95.566 Y80.243 E.23589
G1 X95.579 Y81.005 E.01612
G1 X95.564 Y82.805 E.0381
G1 X95.579 Y83.648 E.01784
G1 X95.558 Y84.612 E.02041
G1 X95.578 Y85.063 E.00955
G1 X95.557 Y85.473 E.00869
G1 X95.557 Y86.904 E.03029
G1 X95.579 Y87.116 E.00452
G1 X95.561 Y89.24 E.04494
G1 X95.578 Y90.116 E.01856
G1 X95.561 Y90.758 E.01358
G1 X95.579 Y92.754 E.04225
G1 X95.557 Y93.118 E.00772
G1 X95.557 Y94.527 E.02983
G1 X95.578 Y94.937 E.00869
G1 X95.558 Y95.388 E.00955
G1 X95.579 Y96.352 E.02041
G1 X95.566 Y99.757 E.07206
G1 X84.421 Y99.757 E.23589
G1 X84.447 Y97.441 E.049
G1 X84.443 Y94.001 E.07281
G1 X84.422 Y93.255 E.01581
G1 X84.421 Y91.801 E.03077
G1 X84.422 Y86.745 E.107
G1 X84.443 Y85.999 E.0158
G1 X84.447 Y82.559 E.07281
G1 X84.422 Y80.303 E.04773
M204 S10000
G1 X83.997 Y79.819 F18000
G1 F1500
M204 S500
G1 X95.989 Y79.819 E.25382
G1 X95.986 Y79.963 E.00305
G1 X96.004 Y81.003 E.02201
G1 X95.989 Y82.803 E.0381
G1 X96.004 Y83.649 E.01791
G1 X95.982 Y84.607 E.02028
G1 X96.003 Y85.064 E.00969
G1 X95.981 Y85.484 E.0089
G1 X95.981 Y86.882 E.02959
G1 X96.003 Y87.096 E.00456
G1 X95.986 Y89.237 E.04532
G1 X96.002 Y90.118 E.01863
G1 X95.986 Y90.761 E.01362
G1 X96.004 Y92.765 E.04242
G1 X95.981 Y93.131 E.00776
G1 X95.981 Y94.516 E.02932
G1 X96.003 Y94.936 E.0089
G1 X95.982 Y95.393 E.00969
G1 X96.004 Y96.351 E.02028
G1 X95.989 Y100.181 E.08106
G1 X83.997 Y100.181 E.25381
G1 X84.022 Y97.438 E.05806
G1 X84.019 Y94.007 E.07261
G1 X83.998 Y93.261 E.01581
G1 X83.997 Y91.8 E.03091
G1 X83.998 Y86.739 E.10713
G1 X84.019 Y85.993 E.01581
G1 X84.022 Y82.562 E.07261
G1 X83.998 Y79.879 E.05679
M204 S250
G1 X83.722 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.28 Y79.41 E.24701
G1 F1867.759
G1 X96.409 Y79.41 E.00255
G1 F1440
G1 X96.395 Y79.965 E.01092
G1 F1560
G1 X96.413 Y81.001 E.02038
G1 F1440
G1 X96.398 Y82.801 E.03541
G1 F1320
G1 X96.413 Y83.65 E.0167
G1 F1560
G1 X96.392 Y84.602 E.01874
G1 X96.413 Y85.066 E.00912
G1 F1440
G1 X96.39 Y85.495 E.00845
G1 F1560
G1 X96.39 Y86.261 E.01507
G1 F1440
G1 X96.39 Y86.861 E.0118
G1 X96.413 Y87.077 E.00427
G1 X96.4 Y88.635 E.03065
G1 F1560
G1 X96.395 Y89.235 E.0118
G1 F1440
G1 X96.412 Y90.119 E.01739
G1 X96.395 Y90.764 E.01269
G1 F1560
G1 X96.4 Y91.364 E.0118
G1 F1440
G1 X96.413 Y92.776 E.02776
G1 X96.39 Y93.144 E.00725
G1 X96.39 Y93.744 E.0118
G1 F1560
G1 X96.39 Y94.505 E.01499
G1 F1440
G1 X96.413 Y94.934 E.00845
G1 F1560
G1 X96.392 Y95.398 E.00912
G1 X96.413 Y96.35 E.01874
G1 F1320
G1 X96.398 Y97.199 E.0167
G1 F1440
G1 X96.413 Y98.999 E.03541
G1 F1560
G1 X96.395 Y100.034 E.02037
G1 F1440
G1 X96.407 Y100.59 E.01093
G1 F1794.978
G1 X96.28 Y100.59 E.00251
G1 F1500
G1 X83.722 Y100.59 E.24701
G1 F1879.334
G1 X83.588 Y100.59 E.00262
G1 F1200
G1 X83.588 Y99.99 E.0118
G1 F1320
G1 X83.588 Y99.572 E.00821
G1 F1440
G1 X83.588 Y98.972 E.0118
G1 F1560
G1 X83.603 Y98.035 E.01845
G1 F1680
G1 X83.613 Y97.435 E.0118
G1 F1560
G1 X83.61 Y94.013 E.06729
G1 F1200
G1 X83.589 Y93.267 E.01469
G1 F1320
G1 X83.588 Y92.667 E.0118
G1 F1440
G1 X83.588 Y92.4 E.00524
G1 F1560
G1 X83.588 Y91.8 E.0118
G1 F1440
G1 X83.588 Y89.267 E.04983
G1 F1320
G1 X83.589 Y86.733 E.04983
G1 F1200
G1 X83.61 Y85.987 E.01469
G1 F1560
G1 X83.613 Y82.565 E.06729
G1 F1680
G1 X83.603 Y81.965 E.0118
G1 F1560
G1 X83.588 Y81.028 E.01845
G1 F1440
G1 X83.588 Y80.428 E.0118
G1 F1320
G1 X83.588 Y80.01 E.00821
G1 F1200
G1 X83.588 Y79.41 E.0118
G1 F1578.235
G1 X83.662 Y79.41 E.00144
; WIPE_START
M204 S6000
G1 X85.662 Y79.41 E-.38
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




G1 X85.685 Y80.748
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.684 Y80.606 E.00301
G1 X87.239 Y80.606 E.03291
G1 X87.418 Y80.896 E.00721
G1 X87.734 Y81.807 E.0204
G1 X87.764 Y82.262 E.00966
G1 X87.484 Y82.717 E.01131
G1 X87.031 Y82.979 E.01108
G1 X88.713 Y82.979 E.0356
G1 X88.874 Y82.717 E.00651
G1 X89.662 Y82.262 E.01926
G1 X90.345 Y81.807 E.01737
G1 X90.778 Y81.351 E.01331
G1 X91.059 Y80.896 E.01132
G1 X91.16 Y80.606 E.00649
G1 X92.857 Y80.606 E.03592
; WIPE_START
G1 X91.16 Y80.606 E-.32243
G1 X91.061 Y80.893 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.248 Y84.85 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.345 Y84.753 E.00269
G1 X94.656 Y84.753 E.18314
G1 X94.754 Y84.851 E.00273
G1 X94.775 Y83.66 E.02343
G1 X94.425 Y83.782 E.00729
G1 X85.583 Y83.782 E.17391
G1 X85.249 Y83.644 E.00712
G1 X85.248 Y84.79 E.02254
M204 S10000
G1 X85.734 Y84.268 F18000
; LINE_WIDTH: 0.602242
G1 F1500
M204 S6000
G1 X94.216 Y84.268 E.24397
; WIPE_START
G1 X92.216 Y84.268 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.188 Y90.119 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.3843
G1 F1500
M204 S6000
G1 X95.176 Y89.239 E.01573
G1 X95.189 Y87.145 E.03746
G1 X95.173 Y86.915 E.00413
G1 X95.173 Y85.344 E.02809
G1 X95.148 Y84.655 E.01234
G1 X95.168 Y83.561 E.01957
; LINE_WIDTH: 0.43178
G1 X95.142 Y82.81 E.01523
G1 X95.152 Y80.665 E.04345
G1 X94.738 Y80.665 E.00839
G1 X94.732 Y81.918 E.02539
G1 X94.71 Y82.474 E.01127
G1 X94.731 Y83.079 E.01225
G1 X94.669 Y83.227 E.00327
G1 X94.548 Y83.345 E.00343
G1 X94.276 Y83.388 E.00556
G1 X85.583 Y83.388 E.17609
G1 X85.444 Y83.33 E.00306
G1 X85.281 Y83.13 E.00523
G1 X85.264 Y80.664 E.04995
G1 X84.846 Y80.664 E.00845
G1 X84.865 Y82.558 E.03837
G1 X84.854 Y84.656 E.0425
; LINE_WIDTH: 0.384344
G1 X84.812 Y86.748 E.03744
G1 X84.812 Y93.249 E.11629
G1 X84.854 Y95.344 E.03749
G1 X84.855 Y96.427 E.01937
; LINE_WIDTH: 0.432031
G1 X84.866 Y97.442 E.02057
G1 X84.846 Y99.336 E.0384
G1 X85.264 Y99.336 E.00845
G1 X85.279 Y96.907 E.04925
G1 X85.346 Y96.766 E.00315
G1 X85.444 Y96.67 E.00278
G1 X85.583 Y96.612 E.00306
G1 X94.425 Y96.612 E.17922
G1 X94.568 Y96.673 E.00315
G1 X94.734 Y96.912 E.0059
G1 X94.712 Y97.495 E.01182
G1 X94.736 Y99.337 E.03734
G1 X95.149 Y99.337 E.00836
G1 X95.146 Y97.506 E.03712
G1 X95.17 Y96.361 E.02322
G1 X95.156 Y95.713 E.01314
; LINE_WIDTH: 0.378425
G1 X95.173 Y93.111 E.04577
G1 X95.189 Y92.737 E.00659
G1 X95.187 Y90.179 E.04501
M204 S10000
G1 X94.833 Y90.114 F18000
; LINE_WIDTH: 0.398239
G1 F1500
M204 S6000
G1 X94.828 Y94.656 E.0844
G1 X94.656 Y94.853 E.00487
G1 X85.345 Y94.853 E.17303
G1 X85.174 Y94.686 E.00444
G1 X85.173 Y85.344 E.1736
G1 X85.345 Y85.147 E.00486
G1 X94.656 Y85.147 E.17303
G1 X94.828 Y85.344 E.00487
G1 X94.833 Y90.054 E.08752
; WIPE_START
G1 X94.831 Y88.054 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.615 Y95.247 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.345 Y95.247 E.18234
G1 X85.248 Y95.166 E.00249
G1 X85.249 Y96.356 E.02342
G1 X85.583 Y96.218 E.00712
G1 X94.425 Y96.218 E.17391
G1 X94.775 Y96.342 E.0073
G1 X94.754 Y95.164 E.02316
G1 X94.667 Y95.216 E.002
M204 S10000
G1 X94.276 Y95.732 F18000
; LINE_WIDTH: 0.602252
G1 F1500
M204 S6000
G1 X85.794 Y95.732 E.24397
; WIPE_START
G1 X87.794 Y95.732 E-.38
; WIPE_END
M73 P33 R22
G1 E-.02 F1800
M204 S10000
G1 X86.519 Y99.394 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.683 Y99.394 E.01771
G1 X85.69 Y98.533 E.01821
G1 X86.014 Y98.194 E.00993
G1 X86.696 Y97.738 E.01737
G1 X87.484 Y97.283 E.01926
G1 X87.645 Y97.021 E.00651
G1 X89.328 Y97.021 E.0356
G1 X88.874 Y97.283 E.01108
G1 X88.594 Y97.738 E.01131
G1 X88.624 Y98.194 E.00966
G1 X88.941 Y99.104 E.0204
G1 X89.12 Y99.394 E.00721
G1 X92.482 Y99.394 E.07116
G1 X92.582 Y99.104 E.00649
G1 X92.863 Y98.649 E.01132
G1 X93.297 Y98.194 E.01331
G1 X93.98 Y97.738 E.01737
G1 X94.285 Y97.562 E.00746
G1 X94.305 Y97.021 E.01146
G1 X93.15 Y97.021 E.02446
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X94.305 Y97.021 E-.21955
G1 X94.285 Y97.562 E-.10284
G1 X94.022 Y97.714 E-.05761
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/74
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I.479 J-1.119 P1  F18000
G1 X86.39 Y94.443 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.012 Y84.111 Z1.32 F18000
G1 X84.279 Y80.243 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.721 Y80.243 E.24218
G1 X95.702 Y84.611 E.09244
G1 X95.723 Y85.457 E.01792
G1 X95.723 Y94.543 E.19232
G1 X95.702 Y95.389 E.01791
G1 X95.718 Y99.757 E.09244
G1 X84.279 Y99.757 E.24213
G1 X84.282 Y94.189 E.11784
G1 X84.301 Y93.245 E.01998
G1 X84.277 Y92.004 E.02629
G1 X84.277 Y87.851 E.08789
G1 X84.301 Y86.756 E.02318
G1 X84.282 Y85.811 E.02001
G1 X84.279 Y80.303 E.11657
M204 S10000
G1 X83.854 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.147 Y79.819 E.26018
G1 X96.126 Y84.606 E.10132
G1 X96.147 Y85.452 E.0179
G1 X96.147 Y94.548 E.19253
G1 X96.126 Y95.393 E.0179
G1 X96.144 Y100.181 E.10133
G1 X83.854 Y100.181 E.26013
G1 X83.857 Y94.185 E.12691
G1 X83.877 Y93.245 E.01989
G1 X83.853 Y92.008 E.02619
G1 X83.853 Y87.847 E.08807
G1 X83.877 Y86.756 E.02309
G1 X83.857 Y85.815 E.01991
G1 X83.854 Y79.879 E.12564
M204 S250
G1 X83.549 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P33 R21
G1 F1500
M204 S500
G1 X96.45 Y79.41 E.25375
G1 F1798.293
G1 X96.556 Y79.41 E.00209
G1 F1680
G1 X96.557 Y79.656 E.00484
G1 F1560
G1 X96.55 Y81.193 E.03022
G1 F1680
G1 X96.542 Y83.066 E.03684
G1 F1800
G1 X96.535 Y84.602 E.03022
G1 X96.556 Y85.447 E.01662
G1 F1560
G1 X96.556 Y94.553 E.17912
G1 F1800
G1 X96.538 Y95.998 E.02841
G1 F1680
G1 X96.548 Y98.659 E.05235
G1 F1560
G1 X96.555 Y100.59 E.03798
G1 F1863.454
G1 X96.449 Y100.59 E.00208
G1 F1500
G1 X83.549 Y100.59 E.25373
G1 F1793.478
G1 X83.445 Y100.59 E.00206
G1 F1560
G1 X83.448 Y94.18 E.12607
G1 F1680
G1 X83.467 Y93.245 E.01841
G1 F1980
G1 X83.456 Y92.645 E.0118
G1 F1800
G1 X83.455 Y92.611 E.00065
G1 F1680
G1 X83.444 Y87.842 E.09381
G1 F1800
G1 X83.467 Y86.756 E.02137
G1 F1680
G1 X83.448 Y85.82 E.01841
G1 F1560
G1 X83.445 Y79.41 E.12607
G1 F1812.988
G1 X83.489 Y79.41 E.00088
; WIPE_START
M204 S6000
G1 X85.489 Y79.41 E-.38
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




G1 X89.914 Y82.979
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X88.217 Y82.979 E.03592
G1 X88.179 Y82.927 E.00135
G1 X87.724 Y82.891 E.00967
G1 X87.443 Y82.979 E.00624
G1 X85.451 Y82.979 E.04216
G1 X85.425 Y82.235 E.01574
G1 X85.432 Y80.606 E.03448
G1 X87.278 Y80.606 E.03909
G1 X87.724 Y81.401 E.01929
G1 X88.179 Y82.506 E.0253
G1 X88.634 Y82.543 E.00967
G1 X89.09 Y82.4 E.0101
G1 X90 Y81.999 E.02106
G1 X90.455 Y81.686 E.01169
G1 X90.91 Y81.203 E.01405
G1 X91.245 Y80.606 E.01448
G1 X92.942 Y80.606 E.03592
; WIPE_START
G1 X91.245 Y80.606 E-.32243
G1 X91.097 Y80.871 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.297 Y85.465 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.424748
G1 F1200
M204 S6000
G1 X95.305 Y83.393 E.04126
; LINE_WIDTH: 0.404905
G1 X95.325 Y80.638 E.05211
G1 X94.961 Y80.638 E.00688
G1 X94.96 Y83.092 E.04643
G1 X94.915 Y83.23 E.00273
G1 X94.823 Y83.33 E.00258
G1 X94.685 Y83.388 E.00284
G1 X85.336 Y83.388 E.17684
G1 X85.197 Y83.33 E.00285
G1 X85.054 Y83.127 E.00471
G1 X85.033 Y82.25 E.01658
G1 X85.037 Y80.637 E.03051
G1 X84.673 Y80.637 E.0069
G1 X84.69 Y84.034 E.06426
; LINE_WIDTH: 0.445535
G1 X84.721 Y86.752 E.05691
G1 X84.703 Y87.858 E.02318
G1 X84.703 Y92.002 E.08678
G1 X84.721 Y93.242 E.02597
G1 X84.69 Y96.46 E.06739
; LINE_WIDTH: 0.40526
G1 X84.673 Y99.363 E.05497
G1 X85.037 Y99.363 E.0069
G1 X85.033 Y97.755 E.03044
G1 X85.052 Y96.9 E.01619
G1 X85.101 Y96.768 E.00266
G1 X85.197 Y96.67 E.0026
G1 X85.336 Y96.612 E.00286
G1 X94.685 Y96.612 E.177
G1 X94.823 Y96.669 E.00285
G1 X94.917 Y96.769 E.00259
G1 X94.96 Y96.904 E.00269
G1 X94.961 Y99.363 E.04655
G1 X95.323 Y99.363 E.00687
G1 X95.293 Y95.382 E.07538
; LINE_WIDTH: 0.452047
G1 X95.297 Y85.525 E.20963
; WIPE_START
G1 X95.296 Y87.525 E-.38
; WIPE_END
M73 P34 R21
G1 E-.02 F1800
M204 S10000
G1 X87.685 Y86.956 Z1.32 F18000
G1 X85.137 Y86.765 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.435868
G1 F1200
M204 S6000
G1 X85.132 Y85.344 E.02907
G1 X85.345 Y85.147 E.00594
G1 X94.656 Y85.147 E.19051
G1 X94.869 Y85.344 E.00594
G1 X94.866 Y94.698 E.19138
G1 X94.656 Y94.853 E.00534
G1 X85.345 Y94.853 E.19051
G1 X85.134 Y94.693 E.00542
G1 X85.136 Y86.825 E.16098
; WIPE_START
G1 X85.136 Y88.825 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.085 Y95.028 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X85.084 Y96.322 E.02544
G1 X85.336 Y96.218 E.00536
G1 X94.685 Y96.218 E.18387
G1 X94.902 Y96.307 E.00462
G1 X94.905 Y95.089 E.02397
G1 X94.731 Y95.242 E.00457
G1 X85.345 Y95.247 E.18462
G1 X85.131 Y95.067 E.0055
; WIPE_START
G1 X85.345 Y95.247 E-.05314
G1 X87.065 Y95.246 E-.32686
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.414 Y95.732 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.602252
G1 F1200
M204 S6000
G1 X85.63 Y95.732 E.25266
; WIPE_START
G1 X87.63 Y95.732 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.897 Y89.404 Z1.32 F18000
G1 X94.906 Y84.941 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.902 Y83.693 E.02456
G1 X94.685 Y83.782 E.00463
G1 X85.336 Y83.782 E.18387
G1 X85.084 Y83.678 E.00536
G1 X85.085 Y85.013 E.02626
G1 X85.345 Y84.753 E.00723
G1 X94.656 Y84.753 E.18314
G1 X94.747 Y84.76 E.00181
G1 X94.867 Y84.896 E.00355
; WIPE_START
G1 X94.747 Y84.76 E-.03433
G1 X94.656 Y84.753 E-.01744
G1 X92.928 Y84.753 E-.32823
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.57 Y84.268 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.602262
G1 F1200
M204 S6000
G1 X94.354 Y84.268 E.25267
; WIPE_START
G1 X92.354 Y84.268 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.006 Y91.872 Z1.32 F18000
G1 X93.448 Y97.021 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X94.57 Y97.021 E.02376
G1 X94.565 Y97.596 E.01216
G1 X93.642 Y98.001 E.02134
G1 X93.186 Y98.314 E.01169
G1 X92.731 Y98.797 E.01405
G1 X92.397 Y99.394 E.01448
G1 X89.08 Y99.394 E.0702
G1 X88.634 Y98.599 E.01929
G1 X88.179 Y97.494 E.0253
G1 X87.724 Y97.457 E.00967
G1 X87.269 Y97.6 E.0101
G1 X86.358 Y98.001 E.02106
G1 X85.903 Y98.314 E.01169
G1 X85.429 Y98.831 E.01484
G1 X85.425 Y97.765 E.02256
G1 X85.451 Y97.021 E.01574
G1 X88.158 Y97.021 E.05729
G1 X88.179 Y97.073 E.00118
G1 X88.634 Y97.109 E.00967
G1 X88.916 Y97.021 E.00624
G1 X90.613 Y97.021 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X88.916 Y97.021 E-.32243
G1 X88.634 Y97.109 E-.05602
G1 X88.626 Y97.109 E-.00155
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/74
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I.932 J-.782 P1  F18000
G1 X86.39 Y94.443 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.936 Y84.126 Z1.44 F18000
G1 X84.16 Y80.243 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.84 Y80.243 E.24722
G1 X95.854 Y81.101 E.01816
G1 X95.829 Y83.274 E.04598
G1 X95.852 Y84.905 E.03453
G1 X95.841 Y86.852 E.04123
G1 X95.854 Y88.195 E.02842
G1 X95.838 Y89.039 E.01785
G1 X95.853 Y90 E.02035
G1 X95.838 Y90.961 E.02035
G1 X95.854 Y91.805 E.01786
G1 X95.841 Y93.147 E.02842
G1 X95.852 Y95.095 E.04123
G1 X95.829 Y96.723 E.03446
G1 X95.847 Y99.757 E.06421
G1 X84.16 Y99.757 E.24737
G1 X84.147 Y98.993 E.01616
G1 X84.174 Y93.439 E.11756
G1 X84.147 Y91.8 E.03469
G1 X84.171 Y90.39 E.02986
G1 X84.149 Y90 E.00827
G1 X84.171 Y89.61 E.00827
G1 X84.147 Y88.2 E.02986
G1 X84.174 Y86.561 E.03469
G1 X84.147 Y81.007 E.11756
G1 X84.159 Y80.303 E.01489
M204 S10000
G1 X83.743 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.267 Y79.819 E.26509
G1 X96.263 Y80.16 E.00722
G1 X96.278 Y81.1 E.01989
G1 X96.253 Y83.273 E.046
G1 X96.276 Y84.903 E.0345
G1 X96.265 Y86.851 E.04124
G1 X96.278 Y88.197 E.02849
G1 X96.263 Y89.039 E.01783
G1 X96.277 Y90 E.02033
G1 X96.263 Y90.96 E.02033
G1 X96.278 Y91.803 E.01783
G1 X96.265 Y93.148 E.02849
G1 X96.276 Y95.097 E.04124
G1 X96.253 Y96.725 E.03446
G1 X96.274 Y100.181 E.07315
G1 X83.743 Y100.181 E.26522
G1 X83.722 Y98.996 E.02508
G1 X83.75 Y93.442 E.11756
G1 X83.722 Y91.8 E.03475
G1 X83.747 Y90.398 E.02968
G1 X83.724 Y90 E.00844
G1 X83.747 Y89.602 E.00844
G1 X83.722 Y88.2 E.02968
G1 X83.75 Y86.558 E.03475
G1 X83.722 Y81.004 E.11756
G1 X83.742 Y79.879 E.02381
M204 S250
G1 X83.404 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.597 Y79.41 E.25949
G1 F1988.551
G1 X96.682 Y79.41 E.00166
G1 F2340
G1 X96.672 Y80.16 E.01475
G1 F2160
G1 X96.687 Y81.099 E.01848
G1 F1800
G1 X96.68 Y81.699 E.0118
G1 F2160
G1 X96.669 Y82.673 E.01916
G1 F2340
G1 X96.662 Y83.273 E.0118
G1 F1980
G1 X96.671 Y83.873 E.0118
G1 F1800
G1 X96.677 Y84.301 E.00843
G1 F1680
G1 X96.686 Y84.901 E.0118
G1 F1980
G1 X96.682 Y85.501 E.0118
G1 F2160
G1 X96.674 Y86.85 E.02653
G1 F1980
G1 X96.682 Y87.599 E.01473
G1 F1800
G1 X96.687 Y88.199 E.0118
G1 F2160
G1 X96.672 Y89.04 E.01654
G1 X96.687 Y91.801 E.05429
M73 P35 R21
G1 F1800
G1 X96.682 Y92.401 E.0118
G1 F1980
G1 X96.674 Y93.15 E.01473
G1 F2160
G1 X96.682 Y94.499 E.02653
G1 F1980
G1 X96.686 Y95.099 E.0118
G1 F1680
G1 X96.677 Y95.699 E.0118
G1 F1800
G1 X96.671 Y96.127 E.00842
G1 F1980
G1 X96.662 Y96.727 E.0118
G1 F2520
G1 X96.666 Y97.327 E.0118
G1 F2340
G1 X96.671 Y98.214 E.01746
G1 F2160
G1 X96.676 Y99.102 E.01746
G1 F1980
G1 X96.685 Y100.59 E.02926
G1 F2013.903
G1 X96.597 Y100.59 E.00175
G1 F1500
G1 X83.404 Y100.59 E.25948
G1 F1949.018
G1 X83.326 Y100.59 E.00154
G1 F2520
G1 X83.337 Y100.394 E.00387
G1 F2340
G1 X83.327 Y99.794 E.0118
G1 F2160
G1 X83.323 Y99.599 E.00384
G1 F1980
G1 X83.316 Y98.399 E.0236
G1 F2160
G1 X83.323 Y96.947 E.02855
G1 F2340
G1 X83.341 Y93.444 E.0689
G1 F1980
G1 X83.331 Y92.844 E.0118
G1 F2160
G1 X83.313 Y91.8 E.02055
G1 F1980
G1 X83.323 Y91.2 E.0118
G1 F2160
G1 X83.327 Y91.006 E.00381
G1 F2340
G1 X83.337 Y90.406 E.0118
G1 X83.314 Y90 E.008
G1 X83.337 Y89.594 E.008
G1 X83.327 Y88.994 E.0118
G1 F2160
G1 X83.323 Y88.8 E.00382
G1 F1980
G1 X83.313 Y88.2 E.0118
G1 F2160
G1 X83.331 Y87.156 E.02055
G1 F1980
G1 X83.341 Y86.556 E.0118
G1 F2340
G1 X83.331 Y84.504 E.04035
G1 F2160
G1 X83.323 Y83.053 E.02855
G1 F1980
G1 X83.323 Y80.401 E.05215
G1 F2160
G1 X83.327 Y80.206 E.00384
G1 F2340
G1 X83.337 Y79.606 E.0118
G1 F2520
G1 X83.326 Y79.41 E.00387
G1 F2536.476
G1 X83.344 Y79.41 E.00036
; WIPE_START
M204 S6000
G1 X85.344 Y79.41 E-.38
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




G1 X85.615 Y80.606
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X87.311 Y80.606 E.03592
G1 X87.724 Y81.207 E.01543
G1 X88.179 Y81.967 E.01875
G1 X88.634 Y82.263 E.01149
G1 X89.09 Y82.249 E.00964
G1 X90 Y81.948 E.0203
G1 X90.455 Y81.673 E.01126
G1 X90.91 Y81.248 E.01318
G1 X91.351 Y80.606 E.01648
G1 X94.595 Y80.606 E.06866
G1 X94.79 Y80.89 E.00729
G1 X94.789 Y82.587 E.03592
M204 S10000
G1 X95.307 Y83.151 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.655042
G1 F1200
M204 S6000
G1 X95.319 Y80.833 E.07279
; WIPE_START
G1 X95.309 Y82.833 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.307 Y83.151 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.628182
G1 F1200
M204 S6000
G1 X95.265 Y83.192 E.00176
; LINE_WIDTH: 0.589322
G1 X95.222 Y83.232 E.00165
; LINE_WIDTH: 0.550462
G1 X95.18 Y83.273 E.00153
; LINE_WIDTH: 0.512526
G1 X95.088 Y83.311 E.00242
; LINE_WIDTH: 0.475512
G1 X94.996 Y83.35 E.00223
; LINE_WIDTH: 0.420178
G1 X94.904 Y83.388 E.00196
G1 X85.098 Y83.388 E.19297
; LINE_WIDTH: 0.439062
G1 X85.006 Y83.35 E.00206
; LINE_WIDTH: 0.477202
G1 X84.914 Y83.312 E.00225
; LINE_WIDTH: 0.515342
G1 X84.821 Y83.274 E.00244
; LINE_WIDTH: 0.555776
G1 X84.777 Y83.233 E.0016
; LINE_WIDTH: 0.598502
G1 X84.732 Y83.192 E.00173
; LINE_WIDTH: 0.641229
G1 X84.688 Y83.151 E.00186
; LINE_WIDTH: 0.640787
G1 X84.666 Y83.219 E.0022
; LINE_WIDTH: 0.597177
G1 X84.645 Y83.288 E.00205
; LINE_WIDTH: 0.553567
G1 X84.623 Y83.356 E.00189
; LINE_WIDTH: 0.509957
G1 X84.602 Y83.425 E.00173
; LINE_WIDTH: 0.466347
G1 X84.581 Y83.493 E.00158
; LINE_WIDTH: 0.432267
G1 X84.572 Y84.272 E.0158
; LINE_WIDTH: 0.44196
G1 X84.597 Y84.809 E.01116
; LINE_WIDTH: 0.500095
G1 X84.622 Y85.346 E.01272
G1 X84.626 Y86.566 E.02888
; LINE_WIDTH: 0.510716
G1 X84.605 Y88.195 E.03942
G1 X84.624 Y89.61 E.03424
G1 X84.605 Y91.796 E.05289
G1 X84.622 Y94.654 E.06916
; LINE_WIDTH: 0.485895
G1 X84.597 Y95.138 E.01111
; LINE_WIDTH: 0.427752
G1 X84.573 Y95.621 E.0097
G1 X84.568 Y96.507 E.01777
; LINE_WIDTH: 0.443772
G1 X84.592 Y96.586 E.00173
; LINE_WIDTH: 0.491332
G1 X84.615 Y96.666 E.00193
; LINE_WIDTH: 0.538892
G1 X84.638 Y96.745 E.00212
; LINE_WIDTH: 0.586452
G1 X84.662 Y96.825 E.00232
; LINE_WIDTH: 0.634012
G1 X84.685 Y96.904 E.00252
; LINE_WIDTH: 0.638061
G1 X84.722 Y96.863 E.0017
; LINE_WIDTH: 0.598598
G1 X84.759 Y96.821 E.00159
; LINE_WIDTH: 0.559136
G1 X84.797 Y96.78 E.00148
; LINE_WIDTH: 0.519673
G1 X84.834 Y96.738 E.00137
; LINE_WIDTH: 0.479955
G1 X84.966 Y96.675 E.00332
; LINE_WIDTH: 0.420287
G1 X85.098 Y96.612 E.00288
G1 X94.904 Y96.612 E.19302
; LINE_WIDTH: 0.440181
G1 X95.009 Y96.663 E.00241
; LINE_WIDTH: 0.480557
G1 X95.113 Y96.715 E.00264
; LINE_WIDTH: 0.520934
G1 X95.217 Y96.766 E.00288
; LINE_WIDTH: 0.557974
G1 X95.248 Y96.812 E.00147
; LINE_WIDTH: 0.591677
G1 X95.279 Y96.858 E.00156
; LINE_WIDTH: 0.625381
G1 X95.309 Y96.904 E.00165
; LINE_WIDTH: 0.620008
G1 X95.332 Y96.827 E.0024
; LINE_WIDTH: 0.57556
G1 X95.355 Y96.749 E.00222
; LINE_WIDTH: 0.531112
G1 X95.377 Y96.671 E.00204
; LINE_WIDTH: 0.486664
G1 X95.4 Y96.594 E.00186
; LINE_WIDTH: 0.422761
G1 X95.422 Y96.516 E.0016
G1 X95.439 Y95.098 E.0281
; LINE_WIDTH: 0.450597
G1 X95.415 Y94.876 E.00472
; LINE_WIDTH: 0.514292
G1 X95.392 Y94.654 E.00543
G1 X95.385 Y93.147 E.03673
G1 X95.392 Y85.346 E.19014
; LINE_WIDTH: 0.49239
G1 X95.417 Y85.124 E.0052
; LINE_WIDTH: 0.426655
G1 X95.443 Y84.902 E.00447
G1 X95.409 Y83.484 E.02836
; LINE_WIDTH: 0.466478
G1 X95.392 Y83.429 E.00127
; LINE_WIDTH: 0.50673
G1 X95.375 Y83.374 E.00138
; LINE_WIDTH: 0.546982
G1 X95.358 Y83.319 E.0015
; LINE_WIDTH: 0.587234
G1 X95.341 Y83.264 E.00162
; LINE_WIDTH: 0.627486
G1 X95.325 Y83.209 E.00173
; WIPE_START
G1 X95.341 Y83.264 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.909 Y81.528 Z1.44 F18000
G1 X84.681 Y80.774 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.662787
G1 F1200
M204 S6000
G1 X84.685 Y83.091 E.07362
; WIPE_START
G1 X84.682 Y81.091 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.028 Y88.715 Z1.44 F18000
G1 X85.104 Y90.394 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.509829
G1 F1200
M204 S6000
G1 X85.104 Y85.344 E.12196
; LINE_WIDTH: 0.485895
G1 X85.224 Y85.246 E.00357
; LINE_WIDTH: 0.420348
G1 X85.345 Y85.147 E.00306
G1 X94.656 Y85.147 E.1833
G1 X94.788 Y85.198 E.00279
; LINE_WIDTH: 0.444125
G1 X94.845 Y85.271 E.00193
; LINE_WIDTH: 0.513045
G1 X94.901 Y85.344 E.00225
G1 X94.899 Y86.858 E.03679
; LINE_WIDTH: 0.514843
G1 X94.901 Y94.656 E.19028
; LINE_WIDTH: 0.494547
G1 X94.846 Y94.73 E.00217
; LINE_WIDTH: 0.450597
G1 X94.791 Y94.805 E.00197
; LINE_WIDTH: 0.420103
G1 X94.554 Y94.853 E.00476
G1 X85.345 Y94.853 E.18119
; LINE_WIDTH: 0.44287
G1 X85.225 Y94.775 E.00298
; LINE_WIDTH: 0.50462
G1 X85.105 Y94.696 E.00342
G1 X85.105 Y93.43 E.03026
; LINE_WIDTH: 0.512116
G1 X85.104 Y90.454 E.0722
; WIPE_START
G1 X85.105 Y92.454 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.97 Y94.931 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X84.964 Y96.273 E.0264
G1 X85.098 Y96.218 E.00286
G1 X94.904 Y96.218 E.19287
G1 X95.032 Y96.27 E.00271
G1 X95.049 Y95.096 E.02311
G1 X94.656 Y95.247 E.00828
G1 X85.345 Y95.247 E.18314
G1 X85.016 Y94.97 E.00845
; WIPE_START
G1 X85.345 Y95.247 E-.08165
G1 X86.915 Y95.247 E-.29835
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.681 Y99.226 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.662793
G1 F1200
M204 S6000
G1 X84.685 Y96.964 E.07187
; WIPE_START
G1 X84.682 Y98.964 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.935 Y96.59 Z1.44 F18000
G1 X94.554 Y95.732 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.602262
G1 F1200
M204 S6000
G1 X85.512 Y95.732 E.26007
; WIPE_START
G1 X87.512 Y95.732 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.477 Y98.853 Z1.44 F18000
G1 X95.316 Y99.229 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.649192
G1 F1200
M204 S6000
G1 X95.31 Y96.964 E.07045
; WIPE_START
G1 X95.316 Y98.964 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.173 Y91.333 Z1.44 F18000
G1 X95.032 Y83.73 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.904 Y83.782 E.00271
G1 X85.098 Y83.782 E.19287
G1 X84.964 Y83.727 E.00286
G1 X84.971 Y85.127 E.02754
G1 X85.345 Y84.753 E.0104
G1 X94.656 Y84.753 E.18314
G1 X95.049 Y84.904 E.00828
G1 X95.032 Y83.79 E.02193
; WIPE_START
G1 X95.049 Y84.904 E-.21181
G1 X94.656 Y84.753 E-.07996
G1 X94.192 Y84.753 E-.08823
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.571 Y84.33 Z1.44 F18000
G1 X85.452 Y84.268 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.602262
G1 F1200
M204 S6000
G1 X94.494 Y84.268 E.26007
; WIPE_START
G1 X92.494 Y84.268 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y91.86 Z1.44 F18000
G1 X93.815 Y97.021 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X94.789 Y97.021 E.02062
G1 X94.789 Y97.744 E.01529
G1 X94.552 Y97.751 E.00502
G1 X93.642 Y98.052 E.0203
G1 X93.186 Y98.327 E.01126
G1 X92.731 Y98.752 E.01318
G1 X92.291 Y99.394 E.01647
G1 X89.047 Y99.394 E.06866
G1 X88.634 Y98.793 E.01543
G1 X88.179 Y98.033 E.01875
G1 X87.724 Y97.737 E.01149
G1 X87.269 Y97.751 E.00964
G1 X86.358 Y98.052 E.0203
G1 X85.903 Y98.327 E.01126
G1 X85.448 Y98.752 E.01318
G1 X85.212 Y99.096 E.00882
G1 X85.213 Y97.399 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X85.212 Y99.096 E-.32243
G1 X85.384 Y98.846 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/74
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I1.186 J.271 P1  F18000
G1 X86.39 Y94.443 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y94.443 E.01764
G1 X85.557 Y85.557 E.1881
G1 X94.444 Y85.557 E.1881
G1 X94.444 Y94.443 E.1881
G1 X86.45 Y94.443 E.16919
M204 S10000
G1 X86.39 Y94.019 F18000
G1 F1500
M204 S500
G1 X85.981 Y94.019 E.00866
G1 X85.981 Y85.981 E.17014
G1 X94.02 Y85.981 E.17014
G1 X94.02 Y94.019 E.17014
G1 X86.45 Y94.019 E.16021
M204 S250
G1 X86.39 Y93.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.867 Y84.14 Z1.56 F18000
G1 X84.05 Y80.243 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.968 Y80.243 E.25224
G1 X95.954 Y83.068 E.05978
G1 X95.972 Y84.347 E.02708
G1 X95.955 Y85.493 E.02425
G1 X95.955 Y86.872 E.02919
G1 X95.973 Y87.316 E.0094
G1 X95.956 Y88.723 E.0298
G1 X95.974 Y92.68 E.08375
G1 X95.955 Y93.132 E.00957
G1 X95.972 Y95.649 E.05329
G1 X95.954 Y96.932 E.02716
G1 X95.968 Y99.757 E.05978
G1 X84.05 Y99.757 E.25224
G1 X84.027 Y98.979 E.01646
G1 X84.048 Y93.643 E.11296
G1 X84.027 Y91.817 E.03864
G1 X84.049 Y91.311 E.01073
G1 X84.054 Y90.237 E.02272
G1 X84.032 Y90 E.00504
G1 X84.054 Y89.763 E.00504
G1 X84.049 Y88.689 E.02272
G1 X84.027 Y88.183 E.01073
G1 X84.048 Y86.357 E.03864
G1 X84.027 Y81.021 E.11296
G1 X84.049 Y80.303 E.01519
M204 S10000
G1 X83.628 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.394 Y79.819 E.27021
G1 X96.378 Y83.066 E.06872
G1 X96.396 Y84.347 E.02712
M73 P36 R21
G1 X96.379 Y85.496 E.02431
G1 X96.379 Y86.863 E.02894
G1 X96.398 Y87.309 E.00945
G1 X96.381 Y88.725 E.02997
G1 X96.398 Y92.688 E.08389
G1 X96.379 Y93.139 E.00955
G1 X96.394 Y100.181 E.14904
G1 X83.628 Y100.181 E.27021
G1 X83.603 Y98.988 E.02526
G1 X83.624 Y93.644 E.1131
G1 X83.603 Y91.81 E.03882
G1 X83.625 Y91.301 E.01079
G1 X83.629 Y90.256 E.02212
G1 X83.606 Y90 E.00544
G1 X83.629 Y89.744 E.00544
G1 X83.625 Y88.699 E.02212
G1 X83.603 Y88.19 E.01079
G1 X83.624 Y86.356 E.03883
G1 X83.603 Y81.012 E.1131
G1 X83.627 Y79.879 E.02399
M204 S250
G1 X83.279 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.723 Y79.41 E.26443
G1 F1976.951
G1 X96.806 Y79.41 E.00163
G1 F2160
G1 X96.803 Y80.01 E.0118
G1 F2340
G1 X96.796 Y81.237 E.02414
G1 F2520
G1 X96.787 Y83.064 E.03594
G1 F1980
G1 X96.805 Y84.347 E.02523
G1 F2520
G1 X96.788 Y86.854 E.04932
G1 X96.807 Y87.303 E.00884
G1 F2160
G1 X96.8 Y87.903 E.0118
G1 F2340
G1 X96.792 Y89.327 E.028
G1 F2160
G1 X96.807 Y92.696 E.06627
G1 F2520
G1 X96.788 Y93.146 E.00887
G1 X96.792 Y93.746 E.0118
G1 F2340
G1 X96.797 Y94.399 E.01284
G1 F2160
G1 X96.805 Y95.652 E.02464
G1 F1980
G1 X96.787 Y96.936 E.02525
G1 F2520
G1 X96.79 Y97.536 E.0118
G1 F2340
G1 X96.796 Y98.763 E.02414
G1 F2160
G1 X96.805 Y100.59 E.03594
G1 F1965.324
G1 X96.724 Y100.59 E.00159
G1 F1500
G1 X83.279 Y100.59 E.26445
G1 F1869.706
G1 X83.214 Y100.59 E.00128
G1 F2271.656
G1 X83.22 Y100.526 E.00126
G1 F2340
G1 X83.216 Y99.509 E.02001
G1 F2160
G1 X83.194 Y98.996 E.01011
G1 X83.196 Y98.396 E.0118
G1 F2340
G1 X83.215 Y93.646 E.09342
G1 F2160
G1 X83.194 Y91.803 E.03624
G1 X83.216 Y91.291 E.01009
G1 F2340
G1 X83.22 Y90.274 E.02001
G1 F2536.476
G1 X83.195 Y90 E.0054
G1 X83.22 Y89.726 E.0054
G1 F2340
G1 X83.216 Y88.709 E.02001
G1 F2160
G1 X83.194 Y88.197 E.01009
G1 X83.215 Y86.354 E.03624
G1 F2340
G1 X83.204 Y83.679 E.05261
G1 F2160
G1 X83.194 Y81.004 E.05261
G1 X83.216 Y80.491 E.01011
G1 F2340
G1 X83.22 Y79.474 E.02001
G1 F2536.476
G1 X83.214 Y79.41 E.00126
G1 X83.219 Y79.41 E.0001
; WIPE_START
M204 S6000
G1 X85.219 Y79.41 E-.38
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




G1 X85.654 Y80.606
G1 Z1.16
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P36 R20
G1 F1500
M204 S6000
G1 X87.351 Y80.606 E.03592
G1 X88.179 Y81.703 E.02908
G1 X88.634 Y82.051 E.01213
G1 X89.09 Y82.117 E.00974
G1 X90 Y81.906 E.01978
G1 X90.455 Y81.668 E.01087
G1 X90.91 Y81.295 E.01245
G1 X91.431 Y80.606 E.01827
G1 X94.634 Y80.606 E.06781
G1 X94.965 Y81.044 E.0116
G1 X94.955 Y82.741 E.03592
; WIPE_START
G1 X94.965 Y81.044 E-.32243
G1 X94.782 Y80.802 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.466 Y80.743 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.601272
G1 F1200
M204 S6000
G1 X95.454 Y83.014 E.06522
; WIPE_START
G1 X95.464 Y81.014 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.485 Y87.33 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.57024
G1 F1200
M204 S6000
G1 X95.471 Y85.487 E.05007
; LINE_WIDTH: 0.544259
G1 X95.501 Y85.111 E.00977
; LINE_WIDTH: 0.494552
G1 X95.532 Y84.734 E.00883
; LINE_WIDTH: 0.428001
G1 X95.562 Y84.358 E.00758
G1 X95.551 Y83.564 E.01594
; LINE_WIDTH: 0.443185
G1 X95.526 Y83.442 E.0026
; LINE_WIDTH: 0.48957
G1 X95.502 Y83.319 E.00289
; LINE_WIDTH: 0.535955
G1 X95.477 Y83.197 E.00318
; LINE_WIDTH: 0.573226
G1 X95.452 Y83.074 E.00341
G1 X95.364 Y83.219 E.00461
; LINE_WIDTH: 0.509526
G1 X95.258 Y83.275 E.00291
; LINE_WIDTH: 0.473712
G1 X95.151 Y83.332 E.0027
; LINE_WIDTH: 0.420204
G1 X95.044 Y83.388 E.00237
G1 X84.96 Y83.388 E.19846
; LINE_WIDTH: 0.439164
G1 X84.859 Y83.338 E.00232
; LINE_WIDTH: 0.477507
G1 X84.759 Y83.287 E.00253
; LINE_WIDTH: 0.515851
G1 X84.658 Y83.237 E.00275
; LINE_WIDTH: 0.55885
G1 X84.604 Y83.178 E.00212
; LINE_WIDTH: 0.606505
G1 X84.55 Y83.12 E.00231
; LINE_WIDTH: 0.606627
G1 X84.527 Y83.206 E.00259
; LINE_WIDTH: 0.559217
G1 X84.503 Y83.292 E.00237
; LINE_WIDTH: 0.511807
G1 X84.48 Y83.378 E.00216
; LINE_WIDTH: 0.464397
G1 X84.456 Y83.464 E.00195
; LINE_WIDTH: 0.430342
G1 X84.449 Y84.271 E.01629
; LINE_WIDTH: 0.444974
G1 X84.476 Y84.629 E.00751
; LINE_WIDTH: 0.494937
G1 X84.502 Y84.987 E.0084
; LINE_WIDTH: 0.56262
G1 X84.529 Y85.345 E.00962
G1 X84.532 Y86.361 E.02719
; LINE_WIDTH: 0.57042
G1 X84.516 Y88.168 E.0491
G1 X84.535 Y90.229 E.05603
G1 X84.516 Y91.832 E.04357
G1 X84.529 Y94.655 E.07669
; LINE_WIDTH: 0.544901
G1 X84.502 Y95.013 E.0093
; LINE_WIDTH: 0.494937
G1 X84.476 Y95.371 E.0084
; LINE_WIDTH: 0.427689
G1 X84.449 Y95.729 E.0072
G1 X84.446 Y96.535 E.01617
; LINE_WIDTH: 0.440568
G1 X84.466 Y96.614 E.00168
; LINE_WIDTH: 0.48172
G1 X84.487 Y96.692 E.00184
; LINE_WIDTH: 0.522872
G1 X84.507 Y96.77 E.00201
; LINE_WIDTH: 0.564024
G1 X84.527 Y96.849 E.00218
; LINE_WIDTH: 0.605176
G1 X84.547 Y96.927 E.00234
; LINE_WIDTH: 0.606069
G1 X84.588 Y96.875 E.00191
; LINE_WIDTH: 0.566702
G1 X84.628 Y96.823 E.00178
; LINE_WIDTH: 0.527336
G1 X84.669 Y96.771 E.00165
; LINE_WIDTH: 0.485737
G1 X84.814 Y96.691 E.0038
; LINE_WIDTH: 0.420346
G1 X84.959 Y96.612 E.00326
G1 X95.043 Y96.612 E.19853
; LINE_WIDTH: 0.437894
G1 X95.15 Y96.669 E.00249
; LINE_WIDTH: 0.473697
G1 X95.257 Y96.726 E.0027
; LINE_WIDTH: 0.509501
G1 X95.364 Y96.783 E.00292
; LINE_WIDTH: 0.546885
G1 X95.408 Y96.855 E.0022
; LINE_WIDTH: 0.58585
G1 X95.452 Y96.927 E.00236
; LINE_WIDTH: 0.582165
G1 X95.477 Y96.804 E.00347
; LINE_WIDTH: 0.53583
G1 X95.502 Y96.682 E.00318
; LINE_WIDTH: 0.489495
G1 X95.526 Y96.559 E.0029
; LINE_WIDTH: 0.423163
G1 X95.551 Y96.436 E.00248
G1 X95.562 Y95.647 E.01564
; LINE_WIDTH: 0.439782
G1 X95.541 Y95.422 E.00468
; LINE_WIDTH: 0.479362
G1 X95.52 Y95.196 E.00513
; LINE_WIDTH: 0.518942
G1 X95.498 Y94.971 E.00557
; LINE_WIDTH: 0.573177
G1 X95.477 Y94.746 E.00619
G1 X95.471 Y93.128 E.04418
G1 X95.485 Y92.664 E.01266
G1 X95.472 Y88.724 E.10761
G1 X95.484 Y87.39 E.03643
; WIPE_START
G1 X95.472 Y88.724 E-.25344
G1 X95.474 Y89.39 E-.12656
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.47 Y97.023 Z1.56 F18000
G1 X95.468 Y99.259 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.596305
G1 F1200
M204 S6000
G1 X95.454 Y96.987 E.06469
; WIPE_START
G1 X95.466 Y98.987 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.41 Y96.077 Z1.56 F18000
G1 X85.075 Y94.702 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.570227
G1 F1200
M204 S6000
G1 X85.073 Y85.344 E.25419
; LINE_WIDTH: 0.544901
G1 X85.163 Y85.279 E.0029
; LINE_WIDTH: 0.494937
G1 X85.254 Y85.213 E.00262
; LINE_WIDTH: 0.420289
G1 X85.345 Y85.147 E.0022
G1 X94.661 Y85.147 E.18337
; LINE_WIDTH: 0.43876
G1 X94.727 Y85.197 E.00171
; LINE_WIDTH: 0.476295
G1 X94.794 Y85.246 E.00187
; LINE_WIDTH: 0.51383
G1 X94.861 Y85.295 E.00202
; LINE_WIDTH: 0.572698
G1 X94.928 Y85.344 E.00227
G1 X94.928 Y94.701 E.25533
; LINE_WIDTH: 0.558522
G1 X94.86 Y94.739 E.00207
; LINE_WIDTH: 0.518942
G1 X94.792 Y94.777 E.00192
; LINE_WIDTH: 0.479362
G1 X94.724 Y94.815 E.00176
; LINE_WIDTH: 0.420156
G1 X94.656 Y94.853 E.00153
G1 X85.342 Y94.853 E.18327
; LINE_WIDTH: 0.439243
G1 X85.288 Y94.822 E.00127
; LINE_WIDTH: 0.477746
G1 X85.234 Y94.792 E.00139
; LINE_WIDTH: 0.516248
G1 X85.181 Y94.762 E.00151
; LINE_WIDTH: 0.554751
G1 X85.127 Y94.731 E.00163
M204 S10000
G1 X84.847 Y94.828 F18000
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X84.841 Y96.27 E.02835
G1 X84.959 Y96.218 E.00253
G1 X95.043 Y96.218 E.19835
G1 X95.16 Y96.253 E.00239
G1 X95.163 Y94.826 E.02807
G1 X94.721 Y95.243 E.01196
G1 X94.656 Y95.247 E.00127
G1 X85.336 Y95.247 E.18331
G1 X84.893 Y94.867 E.01148
; WIPE_START
G1 X85.336 Y95.247 E-.11088
G1 X86.753 Y95.247 E-.26913
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.535 Y99.257 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.610432
G1 F1200
M204 S6000
G1 X84.547 Y96.987 E.06622
; WIPE_START
G1 X84.536 Y98.987 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.804 Y96.655 Z1.56 F18000
G1 X94.681 Y95.732 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.602322
G1 F1200
M204 S6000
G1 X85.389 Y95.732 E.2673
; WIPE_START
G1 X87.389 Y95.732 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.93 Y89.598 Z1.56 F18000
G1 X95.155 Y85.242 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X95.16 Y83.747 E.0294
G1 X95.044 Y83.782 E.00237
G1 X84.96 Y83.782 E.19835
G1 X84.841 Y83.73 E.00254
G1 X84.847 Y85.249 E.02988
G1 X85.336 Y84.753 E.01369
G1 X94.656 Y84.753 E.18331
G1 X94.715 Y84.756 E.00116
G1 X95.115 Y85.198 E.01172
; WIPE_START
G1 X94.715 Y84.756 E-.11317
G1 X94.656 Y84.753 E-.01124
G1 X93.311 Y84.753 E-.25559
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.692 Y84.29 Z1.56 F18000
G1 X85.329 Y84.268 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.602322
G1 F1200
M204 S6000
G1 X94.621 Y84.268 E.2673
; WIPE_START
G1 X92.621 Y84.268 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.625 Y81.218 Z1.56 F18000
G1 X84.535 Y80.743 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.610501
G1 F1200
M204 S6000
G1 X84.547 Y83.06 E.0676
; WIPE_START
G1 X84.537 Y81.06 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.774 Y88.689 Z1.56 F18000
G1 X85.05 Y97.556 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.034 Y99.253 E.03591
G1 X85.448 Y98.705 E.01454
G1 X85.903 Y98.332 E.01245
G1 X86.358 Y98.094 E.01087
G1 X87.269 Y97.883 E.01978
M73 P37 R20
G1 X87.724 Y97.949 E.00974
G1 X88.179 Y98.297 E.01213
G1 X89.007 Y99.394 E.02908
G1 X92.211 Y99.394 E.06781
G1 X92.731 Y98.705 E.01827
G1 X93.186 Y98.332 E.01245
G1 X93.642 Y98.094 E.01087
G1 X94.552 Y97.883 E.01978
G1 X94.961 Y97.943 E.00874
G1 X94.954 Y97.021 E.0195
G1 X94.179 Y97.021 E.01642
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X94.954 Y97.021 E-.14736
G1 X94.961 Y97.943 E-.17507
G1 X94.661 Y97.899 E-.05758
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/74
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I1.007 J-.684 P1  F18000
G1 X84.825 Y83.425 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X95.176 Y83.425 E.21908
G1 X95.176 Y88.616 E.10987
G1 X94.444 Y88.616 E.01549
G1 X94.444 Y91.384 E.05861
G1 X95.176 Y91.384 E.01549
G1 X95.176 Y96.575 E.10987
G1 X84.825 Y96.575 E.21908
G1 X84.825 Y91.384 E.10987
G1 X85.557 Y91.384 E.01549
G1 X85.557 Y88.616 E.05861
G1 X84.825 Y88.616 E.01549
G1 X84.825 Y83.485 E.1086
M204 S10000
G1 X85.249 Y83.849 F18000
G1 F1500
M204 S500
G1 X94.752 Y83.849 E.20113
G1 X94.752 Y88.191 E.09191
G1 X94.02 Y88.191 E.01549
G1 X94.02 Y91.809 E.07657
G1 X94.752 Y91.809 E.01549
G1 X94.752 Y96.151 E.09191
G1 X85.249 Y96.151 E.20113
G1 X85.249 Y91.809 E.09191
G1 X85.981 Y91.809 E.01549
G1 X85.981 Y88.191 E.07657
G1 X85.249 Y88.191 E.01549
G1 X85.249 Y83.909 E.09064
; WIPE_START
M204 S6000
G1 X87.249 Y83.896 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.577 Y91.499 Z1.68 F18000
G1 X86.39 Y93.61 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y86.39 E.14201
G1 X93.61 Y86.39 E.14201
G1 X93.61 Y93.61 E.14201
G1 X86.45 Y93.61 E.14083
; WIPE_START
M204 S6000
G1 X86.434 Y91.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.789 Y84.157 Z1.68 F18000
G1 X83.926 Y80.243 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.083 Y80.243 E.25732
G1 X96.084 Y84.264 E.0851
G1 X96.069 Y85.497 E.02611
G1 X96.084 Y87.306 E.03827
G1 X96.084 Y92.682 E.1138
G1 X96.069 Y93.134 E.00956
G1 X96.081 Y99.757 E.14018
G1 X83.926 Y99.757 E.25728
G1 X83.926 Y80.303 E.41174
M204 S10000
G1 X83.506 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.508 Y79.819 E.27518
G1 X96.508 Y84.267 E.09413
G1 X96.493 Y85.499 E.02608
G1 X96.508 Y87.304 E.03821
G1 X96.508 Y92.689 E.11399
G1 X96.493 Y93.14 E.00955
G1 X96.506 Y100.181 E.14902
G1 X83.506 Y100.181 E.27515
G1 X83.492 Y92.703 E.15828
G1 X83.512 Y90.119 E.05467
G1 X83.497 Y90 E.00255
G1 X83.512 Y89.879 E.00257
G1 X83.493 Y88.196 E.03562
G1 X83.506 Y79.879 E.17604
M204 S250
G1 X83.171 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.846 Y79.41 E.26898
G1 F1902.079
G1 X96.917 Y79.41 E.00139
G1 F2520
G1 X96.917 Y79.81 E.00787
G1 X96.917 Y80.01 E.00393
G1 F2340
G1 X96.917 Y84.269 E.08378
G1 F2536.476
G1 X96.909 Y84.9 E.0124
G1 F2520
G1 X96.907 Y86.1 E.0236
G1 F2340
G1 X96.917 Y87.302 E.02365
G1 F2536.476
G1 X96.917 Y92.696 E.1061
G1 F2520
G1 X96.902 Y93.147 E.00887
G1 F2536.476
G1 X96.903 Y93.747 E.0118
G1 F2520
G1 X96.916 Y100.59 E.1346
G1 F1909.096
G1 X96.845 Y100.59 E.00141
G1 F1500
G1 X83.171 Y100.59 E.26894
G1 F1895.015
G1 X83.102 Y100.59 E.00136
G1 F2340
G1 X83.084 Y98.998 E.03131
G1 X83.083 Y92.702 E.12385
G1 F2536.476
G1 X83.088 Y92.102 E.0118
G1 F2520
G1 X83.093 Y91.422 E.01336
G1 F2340
G1 X83.103 Y90.143 E.02516
G1 F2536.476
G1 X83.085 Y90 E.00283
G1 X83.103 Y89.857 E.00284
G1 F2340
G1 X83.084 Y88.198 E.03262
G1 F2536.476
G1 X83.084 Y87.598 E.0118
G1 F2520
G1 X83.084 Y85.6 E.03932
G1 F2340
G1 X83.084 Y81.002 E.09044
G1 X83.102 Y79.41 E.03131
G1 F2536.476
G1 X83.111 Y79.41 E.00018
; WIPE_START
M204 S6000
G1 X85.111 Y79.41 E-.38
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




G1 X85.708 Y80.606
G1 Z1.28
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X87.405 Y80.606 E.03592
G1 X88.179 Y81.508 E.02516
G1 X88.634 Y81.878 E.01241
G1 X89.09 Y82 E.00998
G1 X89.545 Y81.982 E.00964
G1 X90 Y81.872 E.00991
G1 X90.455 Y81.67 E.01054
G1 X90.91 Y81.344 E.01185
G1 X91.544 Y80.606 E.02059
G1 X94.688 Y80.606 E.06654
G1 X95.462 Y81.508 E.02516
G1 X95.721 Y81.718 E.00704
G1 X95.721 Y82.85 E.02396
G1 X95.156 Y82.85 E.01196
M204 S10000
G1 X95.63 Y83.213 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.503036
G1 F1500
M204 S6000
G1 X95.63 Y88.828 E.1337
M204 S10000
G1 X94.853 Y89.025 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.853 Y90.975 E.03836
G1 X94.97 Y90.96 E.00232
G1 X95.167 Y90.763 E.00548
G1 X95.675 Y90.763 E.00998
G1 X95.675 Y89.237 E.03003
G1 X95.167 Y89.238 E.00999
G1 X94.969 Y89.041 E.00549
G1 X94.912 Y89.033 E.00112
; WIPE_START
G1 X94.969 Y89.041 E-.01083
G1 X95.167 Y89.238 E-.05303
G1 X95.675 Y89.237 E-.09654
G1 X95.675 Y90.392 E-.21959
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.264 Y90.352 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.453132
G1 F1500
M204 S6000
G1 X95.264 Y89.708 E.01373
; WIPE_START
G1 X95.264 Y90.352 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.63 Y91.172 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.501146
G1 F1500
M204 S6000
G1 X95.626 Y96.787 E.13317
M204 S10000
G1 X95.654 Y97.15 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.713 Y97.15 E.00126
G1 X95.716 Y98.788 E.03466
G1 X95.462 Y98.492 E.00825
M73 P38 R20
G1 X95.007 Y98.122 E.01241
G1 X94.552 Y98 E.00998
G1 X94.097 Y98.018 E.00964
G1 X93.642 Y98.128 E.00991
G1 X93.186 Y98.33 E.01054
G1 X92.731 Y98.656 E.01185
G1 X92.097 Y99.394 E.02059
G1 X88.954 Y99.394 E.06654
G1 X88.179 Y98.492 E.02515
G1 X87.724 Y98.122 E.01241
G1 X87.269 Y98 E.00998
G1 X86.814 Y98.018 E.00964
G1 X86.358 Y98.128 E.00991
G1 X85.903 Y98.33 E.01054
G1 X85.448 Y98.656 E.01185
G1 X84.814 Y99.394 E.02059
G1 X84.289 Y99.394 E.01112
G1 X84.289 Y98.222 E.02479
; WIPE_START
G1 X84.289 Y99.394 E-.22257
G1 X84.814 Y99.394 E-.09986
G1 X85.012 Y99.164 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.371 Y96.787 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.50378
G1 F1500
M204 S6000
G1 X84.377 Y91.172 E.13391
; WIPE_START
G1 X84.375 Y93.172 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.571 Y92.13 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X86.072 Y92.087 E.00854
; WIPE_START
G1 X85.571 Y92.13 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.148 Y89.544 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.439066
G1 F1500
M204 S6000
G1 X85.129 Y89.39 E.00319
; LINE_WIDTH: 0.477212
G1 X85.109 Y89.237 E.00348
; LINE_WIDTH: 0.515359
G1 X85.09 Y89.083 E.00378
G1 X85.007 Y89.134 E.00239
; LINE_WIDTH: 0.477212
G1 X84.923 Y89.185 E.0022
; LINE_WIDTH: 0.420417
G1 X84.84 Y89.236 E.00193
G1 X84.335 Y89.237 E.00994
G1 X84.335 Y90.763 E.03005
G1 X84.841 Y90.764 E.00996
G1 X85.038 Y90.961 E.00549
G1 X85.148 Y90.975 E.00218
G1 X85.148 Y89.604 E.027
M204 S10000
G1 X84.741 Y90.357 F18000
; LINE_WIDTH: 0.444072
G1 F1500
M204 S6000
G1 X84.741 Y89.703 E.01366
M204 S10000
G1 X84.375 Y88.828 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.505723
G1 F1500
M204 S6000
G1 X84.371 Y83.213 E.13446
; WIPE_START
G1 X84.372 Y85.213 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.568 Y87.872 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X85.903 Y87.929 E.00576
G1 X86.08 Y87.927 E.00301
; WIPE_START
G1 X85.903 Y87.929 E-.1303
G1 X85.568 Y87.872 E-.2497
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.201 Y87.914 Z1.68 F18000
G1 X93.869 Y87.918 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X94.37 Y87.875 E.00854
; WIPE_START
G1 X93.869 Y87.918 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.52 Y86.874 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X93.827 Y87.567 E.01926
G1 X93.827 Y87.009
G1 X94.52 Y86.317 E.01926
G1 X94.52 Y85.759
G1 X93.827 Y86.452 E.01926
G1 X93.548 Y86.173
G1 X94.52 Y85.202 E.02703
G1 X94.52 Y84.644
G1 X92.99 Y86.173 E.04253
G1 X92.433 Y86.173
G1 X94.52 Y84.087 E.05804
G1 X93.968 Y84.081
G1 X91.875 Y86.173 E.0582
G1 X91.318 Y86.173
G1 X93.41 Y84.081 E.0582
G1 X92.853 Y84.081
G1 X90.76 Y86.173 E.0582
G1 X90.203 Y86.173
G1 X92.295 Y84.081 E.0582
G1 X91.738 Y84.081
G1 X89.645 Y86.173 E.0582
G1 X89.088 Y86.173
G1 X91.18 Y84.081 E.0582
G1 X90.623 Y84.081
G1 X88.53 Y86.173 E.0582
G1 X87.973 Y86.173
G1 X90.065 Y84.081 E.0582
G1 X89.507 Y84.081
G1 X87.415 Y86.173 E.0582
G1 X86.858 Y86.173
G1 X88.95 Y84.081 E.0582
G1 X88.392 Y84.081
G1 X86.3 Y86.173 E.0582
G1 X86.173 Y87.415
G1 X85.77 Y87.818 E.01121
G1 X85.481 Y87.55
G1 X86.173 Y86.857 E.01926
G1 X86.173 Y86.3
G1 X85.481 Y86.992 E.01926
G1 X85.481 Y86.435
G1 X87.835 Y84.081 E.06547
G1 X87.277 Y84.081
G1 X85.481 Y85.877 E.04997
G1 X85.481 Y85.319
G1 X86.72 Y84.081 E.03446
G1 X86.162 Y84.081
G1 X85.481 Y84.762 E.01895
; WIPE_START
M204 S6000
G1 X86.162 Y84.081 E-.18304
G1 X86.72 Y84.081 E-.10593
G1 X86.381 Y84.42 E-.09103
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.184 Y86.057 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0779812
G1 F1500
M204 S6000
G1 X86.079 Y86.151 E.00037
G1 X86.061 Y86.188 E.00011
; WIPE_START
G1 X86.079 Y86.151 E-.08575
G1 X86.184 Y86.057 E-.29425
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.665 Y87.573 Z1.68 F18000
G1 X94.484 Y87.739 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.208144
G1 F1500
M204 S6000
G1 X93.902 Y87.775 E.00531
G1 X93.807 Y87.552 E.0022
; WIPE_START
G1 X93.902 Y87.775 E-.11141
G1 X94.484 Y87.739 E-.26859
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.86 Y92.074 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X94.116 Y92.073 E.00433
G1 X94.367 Y92.115 E.00432
; WIPE_START
G1 X94.116 Y92.073 E-.18979
G1 X93.86 Y92.074 E-.19021
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.52 Y95.237 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X93.838 Y95.919 E.01897
G1 X93.28 Y95.919
G1 X94.52 Y94.68 E.03448
G1 X94.52 Y94.122
G1 X92.723 Y95.919 E.04999
G1 X92.165 Y95.919
G1 X94.52 Y93.565 E.0655
G1 X93.827 Y93.7
G1 X94.52 Y93.007 E.01926
G1 X94.52 Y92.45
G1 X93.827 Y93.142 E.01926
G1 X93.827 Y92.585
G1 X94.23 Y92.182 E.0112
; WIPE_START
M204 S6000
G1 X93.827 Y92.585 E-.10816
G1 X93.827 Y93.142 E-.10593
G1 X94.445 Y92.525 E-.16591
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.7 Y93.827 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X91.607 Y95.919 E.0582
G1 X91.05 Y95.919
G1 X93.142 Y93.827 E.0582
G1 X92.585 Y93.827
G1 X90.492 Y95.919 E.0582
G1 X89.935 Y95.919
G1 X92.027 Y93.827 E.0582
G1 X91.47 Y93.827
G1 X89.377 Y95.919 E.0582
G1 X88.82 Y95.919
G1 X90.912 Y93.827 E.0582
G1 X90.355 Y93.827
G1 X88.262 Y95.919 E.0582
G1 X87.705 Y95.919
G1 X89.797 Y93.827 E.0582
G1 X89.24 Y93.827
G1 X87.147 Y95.919 E.0582
G1 X86.59 Y95.919
G1 X88.682 Y93.827 E.0582
G1 X88.124 Y93.827
G1 X86.032 Y95.919 E.0582
G1 X85.481 Y95.913
G1 X87.567 Y93.827 E.05802
G1 X87.009 Y93.827
G1 X85.481 Y95.355 E.04251
G1 X85.481 Y94.798
G1 X86.452 Y93.827 E.027
G1 X86.173 Y93.548
G1 X85.481 Y94.24 E.01926
G1 X85.481 Y93.683
G1 X86.173 Y92.99 E.01926
G1 X86.173 Y92.433
G1 X85.481 Y93.125 E.01926
; WIPE_START
M204 S6000
G1 X86.173 Y92.433 E-.18605
G1 X86.173 Y92.99 E-.10593
G1 X85.846 Y93.318 E-.08801
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.433 Y92.485 Z1.68 F18000
G1 X94.539 Y92.364 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.129998
G1 F1500
M204 S6000
G1 X94.265 Y92.188 E.00169
; WIPE_START
G1 X94.539 Y92.364 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.518 Y93.444 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.0827824
G1 F1500
M204 S6000
G1 X94.497 Y93.309 E.00039
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X94.518 Y93.444 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/74
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.345 J-1.167 P1  F18000
G1 X86.39 Y95.843 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.902 Y85.534 Z1.8 F18000
G1 X83.815 Y80.243 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.172 Y80.243 E.26155
G1 X96.186 Y81.007 E.01616
G1 X96.173 Y83.679 E.05655
G1 X96.186 Y88.192 E.09553
G1 X96.167 Y89.276 E.02294
G1 X96.185 Y90 E.01533
G1 X96.167 Y90.724 E.01533
G1 X96.186 Y91.808 E.02293
G1 X96.173 Y95.921 E.08707
G1 X96.186 Y98.993 E.06501
G1 X96.172 Y99.757 E.01617
G1 X83.815 Y99.757 E.26155
G1 X83.815 Y80.303 E.41174
M204 S10000
G1 X83.391 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.589 Y79.819 E.27935
G1 X96.61 Y81.004 E.02508
G1 X96.597 Y83.679 E.05661
G1 X96.61 Y88.195 E.0956
G1 X96.591 Y89.274 E.02284
G1 X96.609 Y90 E.01537
G1 X96.591 Y90.726 E.01537
G1 X96.61 Y91.804 E.02283
G1 X96.597 Y95.921 E.08713
G1 X96.61 Y98.996 E.06509
G1 X96.589 Y100.181 E.02509
G1 X83.391 Y100.181 E.27935
G1 X83.391 Y79.879 E.4297
M204 S250
G1 X83.061 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.955 Y79.41 E.27328
G1 F1829.422
G1 X97.014 Y79.41 E.00115
G1 F2536.476
G1 X97.001 Y79.927 E.01018
G1 X97.019 Y81.001 E.02112
G1 X97.017 Y81.601 E.0118
G1 X97.013 Y82.34 E.01453
G1 X97.008 Y84.279 E.03813
G1 X97.013 Y85.938 E.03265
G1 X97.019 Y88.198 E.04445
G1 X97.001 Y89.273 E.02113
G1 X97.019 Y90 E.01431
G1 X97.001 Y90.727 E.01431
G1 X97.019 Y91.801 E.02113
G1 X97.018 Y92.401 E.0118
G1 X97.013 Y93.861 E.0287
G1 X97.009 Y96.52 E.05231
G1 X97.012 Y97.146 E.01231
G1 X97.014 Y97.772 E.01231
G1 X97.019 Y98.998 E.02412
G1 X97.001 Y100.073 E.02113
G1 X97.013 Y100.59 E.01018
G1 F1836.957
G1 X96.954 Y100.59 E.00117
G1 F1500
G1 X83.061 Y100.59 E.27325
G1 F1956.856
G1 X82.982 Y100.59 E.00156
G1 F2340
G1 X82.982 Y79.41 E.41659
G1 F2536.476
G1 X83.001 Y79.41 E.00038
; WIPE_START
M204 S6000
G1 X85.001 Y79.41 E-.38
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




G1 X85.773 Y80.606
G1 Z1.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P39 R20
G1 F1500
M204 S6000
G1 X87.47 Y80.606 E.03592
G1 X88.179 Y81.348 E.02171
G1 X88.634 Y81.73 E.01258
G1 X89.09 Y81.897 E.01026
G1 X89.545 Y81.92 E.00965
G1 X90 Y81.846 E.00976
G1 X90.455 Y81.68 E.01025
G1 X90.91 Y81.397 E.01135
G1 X91.666 Y80.606 E.02314
G1 X94.753 Y80.606 E.06534
G1 X95.271 Y81.148 E.01585
G1 X95.264 Y82.767 E.03427
G1 X95.186 Y82.767 E.00165
; WIPE_START
G1 X95.264 Y82.767 E-.01479
G1 X95.271 Y81.148 E-.30764
G1 X95.062 Y80.929 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.727 Y80.697 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.516423
G1 F2038.026;_EXTRUDE_SET_SPEED
M204 S6000
G1 X95.72 Y82.866 E.0531
; Slow Down End
; WIPE_START
G1 X95.726 Y80.866 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.284 Y82.559 Z1.8 F18000
G1 X84.225 Y83.482 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X84.225 Y96.519 E.25644
; LINE_WIDTH: 0.442982
G1 X84.248 Y96.819 E.00625
; LINE_WIDTH: 0.488712
G1 X84.271 Y97.118 E.00693
G1 X84.359 Y96.963 E.00412
; LINE_WIDTH: 0.429156
G1 X84.581 Y96.826 E.00526
G1 X84.691 Y96.795 E.00229
G1 X84.894 Y96.631 E.00526
; LINE_WIDTH: 0.404104
G1 X95.104 Y96.63 E.19273
G1 X95.378 Y96.824 E.00633
G1 X95.521 Y96.878 E.00288
; LINE_WIDTH: 0.448772
G1 X95.63 Y96.962 E.00291
; LINE_WIDTH: 0.479272
G1 X95.675 Y97.039 E.00203
; LINE_WIDTH: 0.504392
G1 X95.72 Y97.117 E.00214
; LINE_WIDTH: 0.492712
G1 X95.743 Y96.821 E.0069
; LINE_WIDTH: 0.420539
G1 X95.766 Y96.526 E.00584
G1 X95.777 Y91.805 E.09298
G1 X95.758 Y90.723 E.02132
G1 X95.776 Y90 E.01425
G1 X95.758 Y89.277 E.01425
G1 X95.777 Y88.184 E.02152
G1 X95.764 Y83.678 E.08875
; LINE_WIDTH: 0.43453
G1 X95.751 Y83.382 E.00605
; LINE_WIDTH: 0.463605
G1 X95.738 Y83.086 E.00648
; LINE_WIDTH: 0.486839
G1 X95.718 Y82.926 E.00369
G1 X95.526 Y83.126 E.00639
; LINE_WIDTH: 0.405156
G1 X95.269 Y83.241 E.00532
G1 X95.106 Y83.37 E.00393
G1 X85.345 Y83.379 E.18477
G1 X84.894 Y83.369 E.00853
G1 X84.611 Y83.176 E.0065
G1 X84.464 Y83.126 E.00294
; LINE_WIDTH: 0.459582
G1 X84.368 Y83.025 E.00301
; LINE_WIDTH: 0.496962
G1 X84.272 Y82.924 E.00327
; LINE_WIDTH: 0.491737
G1 X84.251 Y83.173 E.00581
; LINE_WIDTH: 0.443907
G1 X84.23 Y83.422 E.00521
; WIPE_START
G1 X84.251 Y83.173 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.869 Y83.642 Z1.8 F18000
G1 X94.811 Y83.824 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.412431
G1 F1200
M204 S6000
G1 X94.853 Y83.944 E.00247
G1 X94.853 Y96.056 E.23364
G1 X94.809 Y96.177 E.00249
G1 X94.656 Y96.244 E.00323
G1 X85.345 Y96.244 E.17963
G1 X85.19 Y96.177 E.00326
G1 X85.148 Y96.056 E.00247
G1 X85.148 Y83.944 E.23364
G1 X85.191 Y83.824 E.00247
G1 X85.345 Y83.756 E.00324
G1 X94.656 Y83.756 E.17963
G1 X94.756 Y83.8 E.00211
M204 S10000
G1 X95.3 Y83.792 F18000
; LINE_WIDTH: 0.547948
G1 F1200
M204 S6000
G1 X95.315 Y88.185 E.11445
G1 X95.302 Y96.149 E.20747
; WIPE_START
G1 X95.305 Y94.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.72 Y97.117 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; Slow Down Start
; LINE_WIDTH: 0.514318
G1 F2046.809;_EXTRUDE_SET_SPEED
M204 S6000
G1 X95.726 Y99.242 E.0518
; Slow Down End
; WIPE_START
G1 X95.721 Y97.242 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.122 Y96.527 Z1.8 F18000
G1 X84.695 Y96.205 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.554716
G1 F1200
M204 S6000
M73 P39 R19
G1 X84.691 Y83.855 E.32592
; WIPE_START
G1 X84.692 Y85.855 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.272 Y82.924 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; Slow Down Start
; LINE_WIDTH: 0.513791
G1 F2049.018;_EXTRUDE_SET_SPEED
M204 S6000
G1 X84.27 Y80.758 E.05274
; Slow Down End
; WIPE_START
G1 X84.272 Y82.758 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.271 Y90.391 Z1.8 F18000
G1 X84.27 Y99.302 Z1.8
G1 Z1.4
G1 E.4 F1800
; Slow Down Start
; LINE_WIDTH: 0.510792
G1 F2061.686;_EXTRUDE_SET_SPEED
M204 S6000
G1 X84.271 Y97.178 E.05139
; Slow Down End
M204 S10000
G1 X84.725 Y97.663 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.725 Y99.36 E.03592
G1 X85.448 Y98.604 E.02216
G1 X85.903 Y98.32 E.01135
G1 X86.358 Y98.154 E.01025
G1 X86.814 Y98.08 E.00976
G1 X87.269 Y98.103 E.00965
G1 X87.724 Y98.27 E.01026
G1 X88.179 Y98.652 E.01258
G1 X88.888 Y99.394 E.02171
G1 X91.976 Y99.394 E.06535
G1 X92.731 Y98.604 E.02314
G1 X93.186 Y98.32 E.01135
G1 X93.642 Y98.154 E.01025
G1 X94.097 Y98.08 E.00976
G1 X94.552 Y98.103 E.00965
G1 X95.007 Y98.27 E.01026
G1 X95.268 Y98.489 E.0072
G1 X95.263 Y97.234 E.02657
G1 X95.181 Y97.234 E.00174
G1 X94.969 Y97.021 E.00636
G1 X94.909 Y97.021 E.00125
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X94.969 Y97.021 E-.01122
G1 X95.181 Y97.234 E-.05709
G1 X95.263 Y97.234 E-.0156
G1 X95.268 Y98.489 E-.23853
G1 X95.036 Y98.294 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/74
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I.332 J-1.171 P1  F18000
G1 X86.39 Y95.843 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.849 Y85.545 Z1.92 F18000
G1 X83.721 Y80.243 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.259 Y80.243 E.26539
G1 X96.278 Y81.467 E.0259
G1 X96.275 Y88.19 E.14229
G1 X96.259 Y88.994 E.01702
G1 X96.28 Y90 E.02131
G1 X96.259 Y91.006 E.0213
G1 X96.275 Y91.81 E.01702
G1 X96.278 Y98.532 E.14228
G1 X96.259 Y99.757 E.02591
G1 X83.721 Y99.757 E.26539
G1 X83.721 Y80.303 E.41174
M204 S10000
G1 X83.297 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.691 Y79.819 E.28349
G1 X96.683 Y80.206 E.00818
G1 X96.702 Y81.464 E.02664
G1 X96.699 Y88.194 E.14245
G1 X96.683 Y88.993 E.01693
G1 X96.705 Y90 E.02131
G1 X96.683 Y91.007 E.02131
G1 X96.699 Y91.806 E.01693
G1 X96.691 Y100.181 E.17726
G1 X83.297 Y100.181 E.28351
G1 X83.297 Y79.879 E.4297
M204 S250
G1 X82.944 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.047 Y79.41 E.27741
G1 F1843.079
G1 X97.108 Y79.41 E.00119
G1 F2536.476
G1 X97.1 Y79.81 E.00787
G1 X97.092 Y80.206 E.0078
G1 X97.102 Y80.861 E.01287
G1 X97.108 Y88.198 E.14431
G1 X97.092 Y88.993 E.01565
G1 X97.114 Y90 E.01981
G1 X97.092 Y91.007 E.01981
G1 X97.108 Y91.802 E.01565
G1 X97.102 Y99.139 E.1443
G1 X97.092 Y99.794 E.01288
G1 X97.101 Y100.19 E.0078
G1 X97.109 Y100.59 E.00787
G1 F1851.357
M73 P40 R19
G1 X97.047 Y100.59 E.00122
G1 F1500
G1 X82.944 Y100.59 E.27741
G1 F1815.344
G1 X82.888 Y100.59 E.0011
G1 F2536.476
G1 X82.888 Y100.19 E.00787
G1 X82.888 Y79.414 E.40864
; WIPE_START
M204 S6000
G1 X84.888 Y79.413 E-.38
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




G1 X85.886 Y80.606
G1 Z1.52
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X87.583 Y80.606 E.03592
G1 X87.724 Y80.726 E.00391
G1 X88.179 Y81.208 E.01403
G1 X88.634 Y81.6 E.01272
G1 X89.09 Y81.805 E.01056
G1 X89.545 Y81.866 E.00972
G1 X90 Y81.826 E.00967
G1 X90.455 Y81.695 E.01003
G1 X90.91 Y81.452 E.01092
G1 X91.366 Y81.066 E.01263
G1 X91.8 Y80.606 E.0134
G1 X94.866 Y80.606 E.06489
G1 X95.007 Y80.726 E.00391
G1 X95.407 Y81.149 E.01233
G1 X95.389 Y82.767 E.03424
G1 X95.309 Y82.767 E.00168
; WIPE_START
G1 X95.389 Y82.767 E-.01509
G1 X95.407 Y81.149 E-.30734
G1 X95.199 Y80.929 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.833 Y80.676 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.479131
G1 F1200
M204 S6000
G1 X95.832 Y82.864 E.04949
; WIPE_START
G1 X95.833 Y80.864 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.856 Y88.496 Z1.92 F18000
G1 X95.866 Y91.819 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X95.85 Y91.002 E.01608
G1 X95.871 Y90 E.01971
G1 X95.85 Y88.994 E.01979
G1 X95.866 Y88.18 E.01601
G1 X95.868 Y83.541 E.09124
; LINE_WIDTH: 0.438742
G1 X95.849 Y83.233 E.00637
; LINE_WIDTH: 0.471589
G1 X95.831 Y82.924 E.00688
G1 X95.648 Y83.125 E.00605
; LINE_WIDTH: 0.405308
G1 X95.486 Y83.176 E.00321
G1 X95.345 Y83.176 E.00267
G1 X95.116 Y83.365 E.00562
G1 X94.656 Y83.379 E.00872
G1 X85.345 Y83.379 E.17632
G1 X84.886 Y83.365 E.0087
G1 X84.657 Y83.176 E.00562
G1 X84.487 Y83.176 E.00323
G1 X84.342 Y83.124 E.00291
; LINE_WIDTH: 0.455287
G1 X84.163 Y82.922 E.00578
G1 X84.13 Y83.533 E.0131
; LINE_WIDTH: 0.419992
G1 X84.13 Y96.467 E.25441
; LINE_WIDTH: 0.435547
G1 X84.146 Y96.792 E.00664
; LINE_WIDTH: 0.466849
G1 X84.161 Y97.116 E.00715
G1 X84.239 Y96.966 E.00372
; LINE_WIDTH: 0.405444
G1 X84.487 Y96.824 E.00541
G1 X84.656 Y96.824 E.00321
G1 X84.885 Y96.635 E.00563
G1 X85.345 Y96.621 E.00871
G1 X94.656 Y96.621 E.17638
G1 X95.113 Y96.635 E.00867
G1 X95.342 Y96.824 E.00561
G1 X95.5 Y96.824 E.00301
; LINE_WIDTH: 0.438602
G1 X95.749 Y96.964 E.00589
; LINE_WIDTH: 0.460612
G1 X95.831 Y97.116 E.00374
G1 X95.868 Y96.456 E.01434
; LINE_WIDTH: 0.419992
G1 X95.866 Y91.879 E.09002
; WIPE_START
G1 X95.867 Y93.879 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.832 Y99.323 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.485081
G1 F1200
M204 S6000
G1 X95.831 Y97.176 E.04919
; WIPE_START
G1 X95.832 Y99.176 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.2 Y99.269 Z1.92 F18000
G1 X84.159 Y99.318 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.477212
G1 F1200
M204 S6000
G1 X84.161 Y97.176 E.04824
; WIPE_START
G1 X84.16 Y99.176 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.671 Y91.561 Z1.92 F18000
G1 X85.191 Y83.824 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.412421
G1 F1200
M204 S6000
G1 X85.345 Y83.756 E.00324
G1 X94.656 Y83.756 E.17962
G1 X94.811 Y83.824 E.00326
G1 X94.853 Y83.944 E.00247
G1 X94.853 Y96.056 E.23364
G1 X94.809 Y96.177 E.00249
G1 X94.656 Y96.244 E.00323
G1 X85.345 Y96.244 E.17962
G1 X85.19 Y96.177 E.00326
G1 X85.148 Y96.056 E.00247
G1 X85.148 Y83.944 E.23364
G1 X85.171 Y83.88 E.00132
; WIPE_START
G1 X85.148 Y83.944 E-.01296
G1 X85.148 Y85.876 E-.36704
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.159 Y80.682 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.477237
G1 F1200
M204 S6000
G1 X84.161 Y82.862 E.04911
; WIPE_START
G1 X84.16 Y80.862 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.539 Y82.811 Z1.92 F18000
G1 X95.355 Y83.819 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.64291
G1 F1200
M204 S6000
G1 X95.357 Y96.122 E.37882
; WIPE_START
G1 X95.357 Y94.122 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.861 Y95.562 Z1.92 F18000
G1 X84.644 Y96.18 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.648938
G1 F1200
M204 S6000
G1 X84.642 Y83.879 E.38246
; WIPE_START
G1 X84.642 Y85.879 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.614 Y93.512 Z1.92 F18000
G1 X84.599 Y97.654 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.599 Y99.351 E.03592
G1 X84.993 Y98.934 E.01215
G1 X85.448 Y98.548 E.01263
G1 X85.903 Y98.305 E.01092
G1 X86.358 Y98.174 E.01003
G1 X86.814 Y98.134 E.00967
G1 X87.269 Y98.195 E.00972
G1 X87.724 Y98.4 E.01056
G1 X88.179 Y98.792 E.01272
G1 X88.634 Y99.274 E.01403
G1 X88.775 Y99.394 E.00391
G1 X91.841 Y99.394 E.06489
G1 X92.276 Y98.934 E.0134
G1 X92.731 Y98.548 E.01263
G1 X93.186 Y98.305 E.01092
G1 X93.642 Y98.174 E.01003
G1 X94.097 Y98.134 E.00967
G1 X94.552 Y98.195 E.00972
G1 X95.007 Y98.4 E.01056
G1 X95.395 Y98.734 E.01083
G1 X95.386 Y97.233 E.03177
G1 X95.19 Y97.234 E.00415
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X95.386 Y97.233 E-.03725
G1 X95.395 Y98.734 E-.28518
G1 X95.165 Y98.537 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/74
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I.357 J-1.163 P1  F18000
G1 X86.39 Y95.843 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.8 Y85.556 Z2.04 F18000
G1 X83.632 Y80.243 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.354 Y80.243 E.26926
G1 X96.351 Y80.485 E.00511
G1 X96.365 Y82.043 E.03298
G1 X96.351 Y88.72 E.14133
G1 X96.369 Y90 E.02709
G1 X96.351 Y91.28 E.02709
G1 X96.354 Y99.757 E.17942
M73 P41 R19
G1 X83.637 Y99.757 E.26917
G1 X83.632 Y80.303 E.41174
M204 S10000
G1 X83.207 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.783 Y79.819 E.28733
G1 X96.775 Y80.485 E.0141
G1 X96.789 Y82.042 E.03294
G1 X96.775 Y88.718 E.14131
G1 X96.794 Y90 E.02714
G1 X96.775 Y91.282 E.02714
G1 X96.785 Y100.181 E.18835
G1 X83.211 Y100.181 E.28731
G1 X83.207 Y79.879 E.4297
M204 S250
G1 X82.848 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.142 Y79.41 E.28117
G1 F1803.968
G1 X97.196 Y79.41 E.00106
G1 F2536.476
G1 X97.192 Y79.81 E.00787
G1 X97.184 Y80.485 E.01329
G1 X97.19 Y81.085 E.0118
G1 X97.198 Y82.04 E.01878
G1 X97.197 Y82.64 E.0118
G1 X97.189 Y86.29 E.0718
G1 X97.184 Y88.715 E.0477
G1 X97.203 Y90 E.02527
G1 X97.184 Y91.284 E.02527
G1 X97.186 Y91.884 E.0118
G1 X97.193 Y95.534 E.07179
G1 X97.198 Y97.959 E.0477
G1 X97.19 Y98.915 E.01879
G1 X97.184 Y99.515 E.0118
G1 X97.194 Y100.19 E.01328
G1 X97.2 Y100.59 E.00787
G1 F1824.388
G1 X97.142 Y100.59 E.00113
G1 F1500
G1 X82.848 Y100.59 E.28117
G1 F1771.511
G1 X82.799 Y100.59 E.00095
G1 F2536.476
G1 X82.802 Y99.99 E.0118
G1 X82.811 Y97.892 E.04126
G1 X82.798 Y79.42 E.36333
; WIPE_START
M204 S6000
G1 X84.798 Y79.419 E-.38
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




G1 X86.002 Y80.606
G1 Z1.64
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X87.699 Y80.606 E.03592
G1 X88.179 Y81.079 E.01426
G1 X88.634 Y81.482 E.01287
G1 X89.09 Y81.721 E.01088
G1 X89.545 Y81.819 E.00985
G1 X90 Y81.814 E.00964
G1 X90.455 Y81.717 E.00985
G1 X90.91 Y81.511 E.01057
G1 X91.366 Y81.167 E.01208
G1 X91.942 Y80.606 E.01701
G1 X94.982 Y80.606 E.06436
G1 X95.518 Y81.128 E.01583
G1 X95.509 Y82.767 E.03468
G1 X95.451 Y82.767 E.00124
; WIPE_START
G1 X95.509 Y82.767 E-.01109
G1 X95.518 Y81.128 E-.31134
G1 X95.301 Y80.917 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.936 Y80.66 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.447566
G1 F1200
M204 S6000
G1 X95.936 Y82.86 E.04632
; WIPE_START
G1 X95.936 Y80.86 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.956 Y88.493 Z2.04 F18000
G1 X95.96 Y90.008 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.422366
G1 F1200
M204 S6000
G1 X95.942 Y88.721 E.02546
G1 X95.953 Y83.505 E.10322
G1 X95.934 Y82.92 E.01157
G1 X95.767 Y83.122 E.00519
G1 X95.509 Y83.176 E.00522
G1 X95.345 Y83.176 E.00324
G1 X95.087 Y83.378 E.00648
; LINE_WIDTH: 0.413267
G1 X85.345 Y83.379 E.18835
G1 X84.879 Y83.361 E.00901
G1 X84.657 Y83.176 E.00558
G1 X84.365 Y83.176 E.00564
G1 X84.223 Y83.122 E.00294
G1 X84.058 Y82.919 E.00505
G1 X84.042 Y83.5 E.01122
G1 X84.046 Y96.504 E.25142
G1 X84.058 Y97.117 E.01185
G1 X84.124 Y96.973 E.00306
G1 X84.224 Y96.88 E.00265
G1 X84.365 Y96.824 E.00293
G1 X84.656 Y96.824 E.00562
G1 X84.914 Y96.622 E.00633
G1 X85.345 Y96.621 E.00832
G1 X94.656 Y96.621 E.18002
G1 X95.119 Y96.638 E.00897
G1 X95.342 Y96.824 E.0056
G1 X95.624 Y96.824 E.00546
G1 X95.765 Y96.88 E.00293
G1 X95.865 Y96.973 E.00264
G1 X95.931 Y97.116 E.00306
G1 X95.942 Y91.275 E.11293
G1 X95.959 Y90.068 E.02334
; WIPE_START
G1 X95.942 Y91.275 E-.22936
G1 X95.94 Y92.068 E-.15064
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.689 Y96.243 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.412431
G1 F1200
M204 S6000
G1 X85.345 Y96.244 E.18026
G1 X85.19 Y96.177 E.00326
G1 X85.148 Y96.056 E.00247
G1 X85.148 Y83.944 E.23364
G1 X85.191 Y83.824 E.00247
G1 X85.345 Y83.756 E.00324
G1 X94.656 Y83.756 E.17963
G1 X94.811 Y83.824 E.00326
G1 X94.853 Y83.944 E.00247
G1 X94.853 Y96.056 E.23364
G1 X94.809 Y96.177 E.00249
G1 X94.741 Y96.214 E.00149
; WIPE_START
G1 X94.809 Y96.177 E-.01469
G1 X94.853 Y96.056 E-.02449
G1 X94.853 Y94.262 E-.34082
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.937 Y99.339 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.440862
G1 F1200
M204 S6000
G1 X95.931 Y97.176 E.04479
; WIPE_START
G1 X95.937 Y99.176 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.644 Y91.55 Z2.04 F18000
G1 X95.585 Y90.003 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.375352
G1 F1200
M204 S6000
G1 X95.571 Y88.721 E.02236
G1 X95.577 Y83.551 E.09017
G1 X95.464 Y83.568 E.002
G1 X95.206 Y83.733 E.00535
G1 X95.226 Y83.944 E.0037
G1 X95.228 Y90 E.10562
G1 X95.224 Y96.056 E.10562
G1 X95.203 Y96.269 E.00373
G1 X95.571 Y96.451 E.00716
G1 X95.584 Y90.063 E.11142
; WIPE_START
G1 X95.58 Y92.063 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.542 Y87.394 Z2.04 F18000
G1 X84.813 Y83.737 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.38067
G1 F1200
M204 S6000
G1 X84.491 Y83.553 E.00656
G1 X84.419 Y83.553 E.00129
G1 X84.422 Y96.448 E.22834
G1 X84.537 Y96.431 E.00207
G1 X84.794 Y96.266 E.0054
G1 X84.774 Y96.056 E.00375
G1 X84.773 Y83.944 E.21445
G1 X84.801 Y83.796 E.00267
; WIPE_START
G1 X84.773 Y83.944 E-.02866
G1 X84.773 Y85.794 E-.35134
; WIPE_END
M73 P42 R19
G1 E-.02 F1800
M204 S10000
G1 X84.058 Y80.669 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.44602
G1 F1200
M204 S6000
G1 X84.056 Y82.859 E.04592
; WIPE_START
G1 X84.058 Y80.859 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.059 Y88.492 Z2.04 F18000
G1 X84.06 Y99.333 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.441497
G1 F1200
M204 S6000
G1 X84.058 Y97.177 E.04473
M204 S10000
G1 X84.478 Y97.638 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.484 Y99.335 E.03591
G1 X84.993 Y98.833 E.01513
G1 X85.448 Y98.489 E.01208
G1 X85.903 Y98.283 E.01057
G1 X86.358 Y98.186 E.00985
G1 X86.814 Y98.181 E.00964
G1 X87.269 Y98.279 E.00985
G1 X87.724 Y98.518 E.01088
G1 X88.179 Y98.921 E.01287
G1 X88.659 Y99.394 E.01426
G1 X91.7 Y99.394 E.06436
G1 X92.276 Y98.833 E.01701
G1 X92.731 Y98.489 E.01208
G1 X93.186 Y98.283 E.01057
G1 X93.642 Y98.186 E.00985
G1 X94.097 Y98.181 E.00964
G1 X94.552 Y98.279 E.00985
G1 X95.007 Y98.518 E.01088
G1 X95.518 Y98.976 E.01453
G1 X95.51 Y97.279 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X95.518 Y98.976 E-.32243
G1 X95.293 Y98.774 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/74
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I.381 J-1.156 P1  F18000
G1 X86.39 Y95.843 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.753 Y85.566 Z2.16 F18000
G1 X83.549 Y80.243 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.452 Y80.243 E.27312
G1 X96.44 Y92.972 E.2694
G1 X96.451 Y99.757 E.14361
G1 X83.549 Y99.757 E.27308
G1 X83.549 Y80.303 E.41174
M204 S10000
G1 X83.124 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.877 Y79.819 E.29109
G1 X96.864 Y92.971 E.27838
G1 X96.876 Y100.181 E.15259
G1 X83.124 Y100.181 E.29107
G1 X83.137 Y92.967 E.15269
G1 X83.124 Y79.879 E.27701
M204 S250
G1 X82.758 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.237 Y79.41 E.2848
G1 F1774.311
G1 X97.286 Y79.41 E.00096
G1 F2536.476
G1 X97.286 Y79.879 E.00923
G1 X97.286 Y80.479 E.0118
G1 X97.28 Y86.425 E.11695
G1 X97.277 Y89.398 E.05848
G1 X97.274 Y93.571 E.08208
G1 X97.282 Y97.85 E.08417
G1 X97.285 Y100.19 E.04602
G1 X97.286 Y100.59 E.00787
G1 F1772.736
G1 X97.237 Y100.59 E.00096
G1 F1500
G1 X82.758 Y100.59 E.2848
G1 F1742.586
G1 X82.715 Y100.59 E.00086
G1 F2536.476
G1 X82.715 Y100.19 E.00787
G1 X82.716 Y99.99 E.00393
G1 X82.721 Y96.778 E.06317
G1 X82.727 Y92.967 E.07497
G1 X82.727 Y92.367 E.0118
G1 X82.714 Y79.426 E.25453
; WIPE_START
M204 S6000
M73 P42 R18
G1 X84.714 Y79.424 E-.38
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




G1 X84.372 Y82.69
G1 Z1.76
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.372 Y80.993 E.03592
G1 X84.788 Y80.606 E.01204
G1 X87.81 Y80.606 E.06396
G1 X88.634 Y81.373 E.02382
G1 X89.09 Y81.645 E.01123
G1 X89.545 Y81.779 E.01004
G1 X90 Y81.807 E.00965
G1 X90.455 Y81.744 E.00973
G1 X90.91 Y81.575 E.01028
G1 X91.366 Y81.268 E.01163
G1 X92.071 Y80.606 E.02048
G1 X95.093 Y80.606 E.06396
G1 X95.638 Y81.117 E.0158
G1 X95.638 Y82.767 E.03492
G1 X95.59 Y82.767 E.001
M204 S10000
G1 X96.043 Y82.916 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.415882
G1 F1200
M204 S6000
G1 X96.045 Y80.711 E.04292
; WIPE_START
G1 X96.044 Y82.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.043 Y82.916 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.413699
G1 F1200
M204 S6000
G1 X95.892 Y83.118 E.00489
G1 X95.753 Y83.176 E.00292
G1 X95.345 Y83.176 E.0079
G1 X95.093 Y83.376 E.00623
G1 X94.656 Y83.379 E.00845
G1 X84.909 Y83.376 E.18864
G1 X84.657 Y83.176 E.00623
G1 X84.257 Y83.176 E.00775
G1 X84.116 Y83.119 E.00293
G1 X83.962 Y82.917 E.00493
G1 X83.96 Y97.118 E.27486
G1 X84.019 Y96.978 E.00294
G1 X84.117 Y96.881 E.00266
G1 X84.257 Y96.824 E.00292
G1 X84.656 Y96.824 E.00773
G1 X84.909 Y96.624 E.00623
G1 X85.345 Y96.621 E.00844
G1 X95.09 Y96.624 E.18861
G1 X95.342 Y96.824 E.00622
G1 X95.745 Y96.824 E.00781
M73 P43 R18
G1 X95.885 Y96.881 E.00292
G1 X95.982 Y96.978 E.00265
G1 X96.041 Y97.117 E.00293
G1 X96.043 Y82.976 E.2737
; WIPE_START
G1 X96.043 Y84.976 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.445 Y84.257 Z2.16 F18000
G1 X85.148 Y83.944 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.412419
G1 F1200
M204 S6000
G1 X85.191 Y83.824 E.00247
G1 X85.345 Y83.756 E.00324
G1 X94.656 Y83.756 E.17962
G1 X94.811 Y83.824 E.00326
G1 X94.853 Y83.944 E.00247
G1 X94.853 Y96.056 E.23364
G1 X94.809 Y96.177 E.00249
G1 X94.656 Y96.244 E.00323
G1 X85.345 Y96.244 E.17962
G1 X85.19 Y96.177 E.00326
G1 X85.148 Y96.056 E.00247
G1 X85.148 Y84.004 E.23248
M204 S10000
G1 X84.786 Y83.75 F18000
; LINE_WIDTH: 0.423406
G1 F1200
M204 S6000
G1 X84.469 Y83.573 E.00721
G1 X84.355 Y83.573 E.00225
G1 X84.355 Y96.427 E.25501
G1 X84.542 Y96.4 E.00373
G1 X84.779 Y96.236 E.00572
G1 X84.752 Y96.056 E.00361
G1 X84.752 Y83.944 E.24027
G1 X84.775 Y83.81 E.00272
; WIPE_START
G1 X84.752 Y83.944 E-.02602
G1 X84.752 Y85.807 E-.35398
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.96 Y80.655 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.424352
G1 F1200
M204 S6000
G1 X83.96 Y82.857 E.04379
; WIPE_START
G1 X83.96 Y80.857 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.394 Y82.585 Z2.16 F18000
G1 X95.646 Y83.573 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.423385
G1 F1200
M204 S6000
G1 X95.46 Y83.6 E.00373
G1 X95.222 Y83.765 E.00573
G1 X95.249 Y83.944 E.0036
G1 X95.249 Y96.056 E.24026
G1 X95.229 Y96.253 E.00393
G1 X95.53 Y96.427 E.00692
G1 X95.645 Y96.427 E.00227
G1 X95.646 Y83.633 E.25381
; WIPE_START
G1 X95.646 Y85.633 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.867 Y93.262 Z2.16 F18000
G1 X96.043 Y99.348 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.420022
G1 F1200
M204 S6000
G1 X96.041 Y97.177 E.0427
; WIPE_START
G1 X96.043 Y99.177 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.411 Y99.284 Z2.16 F18000
G1 X83.96 Y99.345 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.423712
G1 F1200
M204 S6000
G1 X83.96 Y97.178 E.04304
M204 S10000
G1 X84.372 Y97.62 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.372 Y99.317 E.03592
G1 X84.993 Y98.732 E.01805
G1 X85.448 Y98.425 E.01163
G1 X85.903 Y98.256 E.01028
G1 X86.358 Y98.193 E.00973
G1 X86.814 Y98.221 E.00965
G1 X87.269 Y98.355 E.01004
G1 X87.724 Y98.627 E.01123
G1 X88.548 Y99.394 E.02382
G1 X91.57 Y99.394 E.06396
G1 X92.276 Y98.732 E.02047
G1 X92.731 Y98.425 E.01163
G1 X93.186 Y98.256 E.01028
G1 X93.642 Y98.193 E.00973
G1 X94.097 Y98.221 E.00965
G1 X94.552 Y98.355 E.01004
G1 X95.007 Y98.627 E.01123
G1 X95.634 Y99.206 E.01807
G1 X95.631 Y97.509 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X95.634 Y99.206 E-.32243
G1 X95.412 Y99.001 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/74
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I.402 J-1.149 P1  F18000
G1 X86.39 Y95.843 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.71 Y85.576 Z2.28 F18000
G1 X83.47 Y80.243 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.532 Y80.243 E.27647
G1 X96.532 Y80.698 E.00963
G1 X96.532 Y99.757 E.40338
G1 X83.47 Y99.757 E.27647
G1 X83.47 Y80.303 E.41174
M204 S10000
G1 X83.045 Y79.819 F18000
G1 F1500
M204 S500
G1 X96.956 Y79.819 E.29443
G1 X96.956 Y80.698 E.01861
G1 X96.956 Y100.181 E.41236
G1 X83.045 Y100.181 E.29443
G1 X83.045 Y79.879 E.4297
M204 S250
G1 X82.674 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.327 Y79.41 E.28822
G1 F1709.772
G1 X97.365 Y79.41 E.00074
G1 F2536.476
G1 X97.365 Y79.81 E.00787
G1 X97.365 Y80.098 E.00567
G1 X97.366 Y80.698 E.0118
G1 X97.366 Y81.298 E.0118
G1 X97.365 Y100.19 E.37158
G1 X97.365 Y100.59 E.00787
G1 F1709.428
G1 X97.327 Y100.59 E.00074
G1 F1500
G1 X82.674 Y100.59 E.28822
G1 F1709.886
G1 X82.636 Y100.59 E.00074
G1 F2536.476
G1 X82.636 Y100.19 E.00787
G1 X82.636 Y79.432 E.40829
; WIPE_START
M204 S6000
G1 X84.636 Y79.429 E-.38
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




G1 X85.194 Y85.974
G1 Z1.88
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.194 Y87.671 E.03592
G1 X84.993 Y87.806 E.00513
G1 X84.261 Y88.491 E.02122
G1 X84.261 Y92.024 E.07478
G1 X84.993 Y91.346 E.02113
G1 X85.194 Y91.225 E.00496
G1 X85.194 Y94.954 E.07892
G1 X84.993 Y95.089 E.00513
G1 X84.261 Y95.775 E.02122
G1 X84.261 Y99.307 E.07478
G1 X84.993 Y98.629 E.02113
G1 X85.448 Y98.356 E.01123
G1 X85.903 Y98.222 E.01004
G1 X86.358 Y98.193 E.00965
G1 X86.814 Y98.255 E.00973
G1 X87.269 Y98.424 E.01027
M73 P44 R18
G1 X87.724 Y98.731 E.01162
G1 X88.431 Y99.394 E.02051
G1 X91.453 Y99.394 E.06396
G1 X92.276 Y98.629 E.02378
G1 X92.731 Y98.356 E.01123
G1 X93.186 Y98.222 E.01004
G1 X93.642 Y98.193 E.00965
G1 X94.097 Y98.255 E.00972
G1 X94.552 Y98.424 E.01028
G1 X95.007 Y98.731 E.01162
G1 X95.714 Y99.394 E.02051
G1 X94.017 Y99.394 E.03592
; WIPE_START
G1 X95.714 Y99.394 E-.32243
G1 X95.493 Y99.187 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.133 Y99.357 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.400272
G1 F1500
M204 S6000
G1 X96.133 Y80.703 E.34856
; WIPE_START
G1 X96.133 Y82.703 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.732 Y82.797 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.74 Y81.1 E.03592
G1 X95.21 Y80.606 E.01533
G1 X92.188 Y80.606 E.06396
G1 X91.366 Y81.371 E.02378
G1 X90.91 Y81.645 E.01123
G1 X90.455 Y81.778 E.01004
G1 X90 Y81.807 E.00965
G1 X89.545 Y81.745 E.00973
G1 X89.09 Y81.576 E.01027
G1 X88.634 Y81.269 E.01162
G1 X87.927 Y80.606 E.02052
G1 X84.905 Y80.606 E.06396
G1 X84.261 Y81.208 E.01866
G1 X84.261 Y84.741 E.07478
G1 X84.993 Y84.062 E.02113
G1 X85.194 Y83.942 E.00496
G1 X85.194 Y83.794 E.00314
G1 X85.441 Y83.794 E.00523
G1 X85.903 Y83.656 E.01021
G1 X86.358 Y83.627 E.00965
G1 X86.814 Y83.689 E.00973
G1 X87.096 Y83.794 E.00637
G1 X92.724 Y83.794 E.11913
G1 X93.186 Y83.656 E.01021
G1 X93.642 Y83.627 E.00965
G1 X94.097 Y83.689 E.00972
G1 X94.379 Y83.794 E.00637
G1 X94.807 Y83.794 E.00905
G1 X94.807 Y84.03 E.00499
G1 X95.007 Y84.165 E.00512
G1 X95.731 Y84.842 E.02098
G1 X95.737 Y88.381 E.07489
G1 X95.007 Y87.704 E.02106
G1 X94.807 Y87.584 E.00495
G1 X94.807 Y91.313 E.07893
G1 X95.007 Y91.448 E.00512
G1 X95.739 Y92.133 E.02122
G1 X95.728 Y95.656 E.07456
G1 X95.007 Y94.987 E.02081
G1 X94.807 Y94.867 E.00495
G1 X94.807 Y96.206 E.02835
G1 X90.918 Y96.206 E.08231
G1 X90.455 Y96.344 E.01022
G1 X90 Y96.374 E.00965
G1 X89.545 Y96.311 E.00973
G1 X89.262 Y96.206 E.00638
G1 X87.565 Y96.206 E.03592
; WIPE_START
G1 X89.262 Y96.206 E-.32243
G1 X89.545 Y96.311 E-.05727
G1 X89.546 Y96.311 E-.00031
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.865 Y99.361 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.392972
G1 F1500
M204 S6000
G1 X83.865 Y80.699 E.34189
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.865 Y82.699 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/74
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I-1.195 J.23 P1  F18000
G1 X86.39 Y95.843 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.671 Y85.585 Z2.4 F18000
G1 X83.399 Y80.243 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.604 Y80.243 E.27948
G1 X96.59 Y86.416 E.13065
G1 X96.606 Y86.901 E.01027
G1 X96.606 Y93.099 E.13118
G1 X96.59 Y93.583 E.01025
G1 X96.601 Y99.757 E.13068
G1 X83.399 Y99.757 E.27943
G1 X83.399 Y80.303 E.41174
M204 S10000
G1 X82.973 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.029 Y79.819 E.2975
G1 X97.028 Y80.014 E.00413
G1 X97.014 Y86.41 E.13537
G1 X97.03 Y86.894 E.01026
G1 X97.03 Y93.106 E.13147
G1 X97.014 Y93.59 E.01025
G1 X97.027 Y100.181 E.13951
G1 X82.973 Y100.181 E.29747
G1 X82.987 Y97.2 E.06308
G1 X82.973 Y79.879 E.36662
M204 S250
G1 X82.595 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.406 Y79.41 E.29132
G1 F1680.676
G1 X97.439 Y79.41 E.00064
G1 F2536.476
G1 X97.438 Y79.81 E.00787
G1 X97.438 Y80.015 E.00403
G1 X97.436 Y80.615 E.0118
G1 X97.432 Y82.344 E.03402
G1 X97.423 Y86.403 E.07983
G1 X97.439 Y86.888 E.00953
G1 X97.439 Y93.112 E.12244
G1 X97.423 Y93.596 E.00953
G1 X97.423 Y97.2 E.07088
G1 X97.426 Y97.8 E.0118
G1 X97.431 Y98.895 E.02154
G1 X97.438 Y100.59 E.03334
G1 F1678.007
G1 X97.406 Y100.59 E.00063
G1 F1500
G1 X82.595 Y100.59 E.29132
G1 F1682.04
G1 X82.562 Y100.59 E.00065
G1 F2536.476
G1 X82.565 Y99.99 E.0118
G1 X82.571 Y98.53 E.02871
G1 X82.573 Y95.1 E.06746
G1 X82.569 Y93.6 E.0295
G1 X82.566 Y87.9 E.11212
G1 X82.569 Y86.4 E.02951
G1 X82.575 Y82.2 E.08262
G1 X82.568 Y80.74 E.02871
G1 X82.562 Y79.437 E.02563
; WIPE_START
M204 S6000
G1 X84.562 Y79.433 E-.38
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
M73 P45 R18
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X85.194 Y86.058
G1 Z2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.194 Y87.755 E.03592
G1 X84.993 Y87.907 E.00533
G1 X84.538 Y88.361 E.0136
G1 X84.167 Y88.689 E.01049
G1 X84.167 Y92.009 E.07027
G1 X84.538 Y91.639 E.01108
G1 X84.993 Y91.236 E.01287
G1 X85.194 Y91.131 E.00481
G1 X85.194 Y95.038 E.08271
G1 X84.993 Y95.19 E.00533
G1 X84.538 Y95.644 E.0136
G1 X84.167 Y95.972 E.01049
G1 X84.167 Y99.292 E.07027
G1 X84.538 Y98.923 E.01108
G1 X84.993 Y98.52 E.01287
G1 X85.448 Y98.28 E.01089
G1 X85.903 Y98.182 E.00986
G1 X86.358 Y98.187 E.00963
G1 X86.814 Y98.283 E.00985
G1 X87.269 Y98.488 E.01057
G1 X87.724 Y98.832 E.01207
G1 X88.302 Y99.394 E.01705
G1 X91.343 Y99.394 E.06436
G1 X91.821 Y98.923 E.01421
G1 X92.276 Y98.52 E.01287
G1 X92.731 Y98.28 E.01089
G1 X93.186 Y98.182 E.00986
G1 X93.642 Y98.187 E.00964
G1 X94.097 Y98.283 E.00985
G1 X94.552 Y98.488 E.01057
G1 X95.007 Y98.832 E.01207
G1 X95.585 Y99.394 E.01705
G1 X93.888 Y99.394 E.03592
; WIPE_START
G1 X95.585 Y99.394 E-.32243
G1 X95.368 Y99.182 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.249 Y96.428 Z2.4 F18000
G1 X87.677 Y96.206 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X89.374 Y96.206 E.03592
G1 X89.545 Y96.283 E.00397
G1 X90 Y96.38 E.00985
G1 X90.455 Y96.384 E.00964
G1 X90.91 Y96.286 E.00986
G1 X91.063 Y96.206 E.00364
G1 X94.807 Y96.206 E.07924
G1 X94.807 Y94.772 E.03035
G1 X95.007 Y94.878 E.0048
G1 X95.462 Y95.281 E.01287
G1 X95.831 Y95.648 E.01101
G1 X95.829 Y92.327 E.07029
G1 X95.462 Y92.002 E.01037
G1 X95.007 Y91.549 E.0136
G1 X94.807 Y91.397 E.00532
G1 X94.807 Y87.489 E.08271
G1 X95.007 Y87.595 E.0048
G1 X95.462 Y87.998 E.01287
G1 X95.826 Y88.36 E.01085
G1 X95.831 Y85.045 E.07016
G1 X95.462 Y84.719 E.01041
G1 X95.007 Y84.266 E.0136
G1 X94.807 Y84.114 E.00532
G1 X94.807 Y83.794 E.00678
G1 X94.268 Y83.794 E.01141
G1 X94.097 Y83.717 E.00396
G1 X93.642 Y83.62 E.00985
G1 X93.186 Y83.616 E.00964
M73 P45 R17
G1 X92.731 Y83.714 E.00986
G1 X92.579 Y83.794 E.00363
G1 X86.984 Y83.794 E.11842
G1 X86.814 Y83.717 E.00396
G1 X86.358 Y83.62 E.00985
G1 X85.903 Y83.616 E.00963
G1 X85.448 Y83.714 E.00986
G1 X85.296 Y83.794 E.00363
G1 X85.194 Y83.794 E.00216
G1 X85.194 Y83.847 E.00114
G1 X84.993 Y83.953 E.00481
G1 X84.538 Y84.356 E.01287
G1 X84.167 Y84.726 E.01108
G1 X84.167 Y81.406 E.07027
G1 X84.538 Y81.078 E.01049
G1 X85.016 Y80.606 E.01421
G1 X88.057 Y80.606 E.06436
G1 X88.634 Y81.168 E.01706
G1 X89.09 Y81.512 E.01207
G1 X89.545 Y81.717 E.01057
G1 X90 Y81.814 E.00985
G1 X90.455 Y81.818 E.00964
G1 X90.91 Y81.72 E.00986
G1 X91.366 Y81.481 E.01089
G1 X91.821 Y81.078 E.01287
G1 X92.299 Y80.606 E.01422
G1 X95.34 Y80.606 E.06436
G1 X95.826 Y81.077 E.01433
G1 X95.832 Y82.774 E.03592
; WIPE_START
G1 X95.826 Y81.077 E-.32242
G1 X95.609 Y80.867 E-.05758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.211 Y80.635 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.373302
G1 F1500
M204 S6000
G1 X96.21 Y99.306 E.32374
; WIPE_START
G1 X96.21 Y97.306 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.681 Y98.558 Z2.4 F18000
G1 X83.783 Y99.373 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.369012
G1 F1500
M204 S6000
G1 X83.783 Y80.687 E.32
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.783 Y82.687 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/74
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I-1.194 J.237 P1  F18000
G1 X86.39 Y95.843 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.634 Y85.594 Z2.52 F18000
G1 X83.332 Y80.243 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.67 Y80.243 E.28233
G1 X96.655 Y82.8 E.05411
G1 X96.676 Y89.999 E.15238
G1 X96.655 Y97.2 E.15241
G1 X96.67 Y99.757 E.05411
G1 X83.332 Y99.757 E.28232
G1 X83.345 Y97.2 E.0541
G1 X83.326 Y90.001 E.15239
G1 X83.345 Y82.8 E.15242
G1 X83.332 Y80.303 E.05283
M204 S10000
G1 X82.905 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.097 Y79.819 E.30038
G1 X97.08 Y82.8 E.06309
G1 X97.1 Y89.999 E.15238
G1 X97.08 Y97.2 E.15241
G1 X97.097 Y100.181 E.06309
G1 X82.905 Y100.181 E.30038
G1 X82.921 Y97.2 E.06308
G1 X82.902 Y90.001 E.15239
G1 X82.921 Y82.8 E.15242
G1 X82.905 Y79.879 E.06181
M204 S250
G1 X82.521 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.48 Y79.41 E.29423
G1 F1657.918
G1 X97.509 Y79.41 E.00056
G1 F2536.476
G1 X97.506 Y79.81 E.00787
G1 X97.505 Y80.01 E.00393
G1 X97.489 Y82.8 E.05488
G1 X97.491 Y83.4 E.0118
G1 X97.499 Y86.4 E.059
G1 X97.508 Y90.599 E.0826
G1 X97.499 Y93.6 E.05901
G1 X97.499 Y98.895 E.10415
G1 X97.508 Y100.59 E.03334
G1 F1657.974
G1 X97.48 Y100.59 E.00056
G1 F1500
G1 X82.521 Y100.59 E.29422
G1 F1651.436
G1 X82.494 Y100.59 E.00054
G1 F2536.476
G1 X82.496 Y100.19 E.00787
G1 X82.508 Y97.8 E.047
G1 X82.512 Y97.2 E.0118
G1 F2340
G1 X82.51 Y96.6 E.0118
G1 F2536.476
G1 X82.506 Y95.1 E.0295
G1 X82.498 Y92.101 E.059
M73 P46 R17
G1 X82.494 Y89.401 E.0531
G1 X82.502 Y86.4 E.05902
G1 X82.506 Y84.9 E.02951
G1 F2340
G1 X82.512 Y82.8 E.04131
G1 F2536.476
G1 X82.508 Y82.2 E.0118
G1 X82.494 Y79.442 E.05423
; WIPE_START
M204 S6000
G1 X84.494 Y79.438 E-.38
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




G1 X85.194 Y86.141
G1 Z2.12
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.194 Y87.838 E.03592
G1 X84.993 Y88.008 E.00557
G1 X84.538 Y88.489 E.01402
G1 X84.08 Y88.882 E.01277
G1 X84.081 Y91.994 E.06585
G1 X84.538 Y91.511 E.01406
G1 X84.993 Y91.119 E.01272
G1 X85.194 Y91.028 E.00467
G1 X85.194 Y95.121 E.08662
G1 X84.993 Y95.291 E.00557
G1 X84.538 Y95.772 E.01402
G1 X84.082 Y96.165 E.01273
G1 X84.083 Y99.275 E.06584
G1 X84.538 Y98.794 E.01401
G1 X84.993 Y98.402 E.01272
G1 X85.448 Y98.197 E.01057
G1 X85.903 Y98.135 E.00972
G1 X86.358 Y98.174 E.00967
G1 X86.814 Y98.305 E.01002
G1 X87.269 Y98.547 E.01092
G1 X87.724 Y98.932 E.01262
G1 X88.16 Y99.394 E.01344
G1 X91.226 Y99.394 E.06489
G1 X91.366 Y99.276 E.00387
G1 X91.821 Y98.794 E.01402
G1 X92.276 Y98.402 E.01272
G1 X92.731 Y98.197 E.01057
G1 X93.186 Y98.135 E.00972
G1 X93.642 Y98.174 E.00967
G1 X94.097 Y98.305 E.01002
G1 X94.552 Y98.547 E.01092
G1 X95.007 Y98.932 E.01262
G1 X95.443 Y99.394 E.01344
G1 X95.908 Y99.394 E.00984
G1 X95.908 Y98.162 E.02608
; WIPE_START
G1 X95.908 Y99.394 E-.23408
G1 X95.443 Y99.394 E-.08835
G1 X95.235 Y99.174 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.139 Y96.363 Z2.52 F18000
G1 X87.744 Y96.206 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X89.441 Y96.206 E.03592
G1 X89.545 Y96.262 E.00249
G1 X90 Y96.392 E.01002
G1 X90.455 Y96.431 E.00967
G1 X90.91 Y96.37 E.00972
G1 X91.273 Y96.206 E.00841
G1 X94.807 Y96.206 E.0748
G1 X94.807 Y94.67 E.03252
G1 X95.007 Y94.76 E.00466
G1 X95.462 Y95.153 E.01272
G1 X95.907 Y95.623 E.01369
G1 X95.906 Y92.513 E.06583
G1 X95.462 Y92.131 E.01239
G1 X95.007 Y91.649 E.01402
G1 X94.807 Y91.48 E.00556
G1 X94.807 Y87.387 E.08663
G1 X95.007 Y87.477 E.00466
G1 X95.462 Y87.87 E.01272
G1 X95.906 Y88.339 E.01366
G1 X95.912 Y85.235 E.06568
G1 X95.462 Y84.847 E.01257
G1 X95.007 Y84.366 E.01402
G1 X94.807 Y84.197 E.00556
G1 X94.807 Y83.794 E.00853
G1 X94.2 Y83.794 E.01283
G1 X94.097 Y83.738 E.00248
G1 X93.642 Y83.608 E.01002
G1 X93.186 Y83.569 E.00967
G1 X92.731 Y83.63 E.00972
G1 X92.369 Y83.794 E.00841
G1 X86.917 Y83.794 E.11539
G1 X86.814 Y83.738 E.00248
G1 X86.358 Y83.608 E.01002
G1 X85.903 Y83.569 E.00967
G1 X85.448 Y83.63 E.00972
G1 X84.993 Y83.836 E.01057
G1 X84.538 Y84.228 E.01272
G1 X84.079 Y84.712 E.01412
G1 X84.078 Y81.6 E.06587
G1 X84.538 Y81.206 E.01282
G1 X84.993 Y80.725 E.01402
G1 X85.133 Y80.606 E.00387
G1 X88.198 Y80.606 E.06488
G1 X88.634 Y81.068 E.01344
G1 X89.09 Y81.453 E.01262
G1 X89.545 Y81.695 E.01092
G1 X90 Y81.826 E.01002
G1 X90.455 Y81.865 E.00967
G1 X90.91 Y81.803 E.00972
G1 X91.366 Y81.598 E.01057
G1 X91.821 Y81.206 E.01272
G1 X92.276 Y80.725 E.01402
G1 X92.416 Y80.606 E.00387
G1 X95.481 Y80.606 E.06488
G1 X95.91 Y81.06 E.01322
G1 X95.918 Y82.757 E.03592
; WIPE_START
G1 X95.91 Y81.06 E-.32243
G1 X95.702 Y80.84 E-.05758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.287 Y80.624 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.366981
G1 F1500
M204 S6000
G1 X96.3 Y90.001 E.15963
G1 X96.288 Y99.317 E.15858
; WIPE_START
G1 X96.29 Y97.317 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.759 Y98.553 Z2.52 F18000
G1 X83.708 Y99.382 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X83.706 Y80.676 E.31731
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.706 Y82.676 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 18/74
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I-1.192 J.243 P1  F18000
G1 X86.39 Y95.843 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.597 Y85.603 Z2.64 F18000
G1 X83.265 Y80.243 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.741 Y80.243 E.28522
G1 X96.721 Y82.805 E.05422
G1 X96.737 Y83.79 E.02085
G1 X96.738 Y85.756 E.0416
G1 X96.721 Y86.39 E.01343
G1 X96.742 Y90 E.07642
G1 X96.721 Y93.61 E.07642
G1 X96.738 Y94.244 E.01342
G1 X96.721 Y97.194 E.06243
G1 X96.736 Y99.757 E.05424
G1 X83.265 Y99.757 E.28512
G1 X83.28 Y97.187 E.05439
G1 X83.264 Y96.695 E.01041
G1 X83.28 Y93.599 E.06553
G1 X83.259 Y90.259 E.0707
G1 X83.28 Y86.4 E.08168
G1 X83.265 Y80.303 E.12904
M204 S10000
G1 X82.838 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.166 Y79.819 E.30325
G1 X97.165 Y80.199 E.00803
G1 X97.145 Y82.803 E.05513
G1 X97.161 Y83.787 E.02082
G1 X97.162 Y85.761 E.04179
G1 X97.145 Y86.394 E.0134
G1 X97.166 Y90 E.07633
G1 X97.145 Y93.606 E.07633
G1 X97.162 Y94.239 E.0134
G1 X97.161 Y96.213 E.04179
G1 X97.145 Y97.196 E.02081
G1 X97.163 Y100.181 E.06317
G1 X82.838 Y100.181 E.30319
G1 X82.855 Y97.192 E.06326
G1 X82.84 Y96.701 E.0104
G1 X82.855 Y93.6 E.06564
G1 X82.835 Y90.259 E.0707
G1 X82.855 Y86.4 E.08169
G1 X82.84 Y83.299 E.06564
G1 X82.855 Y82.808 E.0104
G1 X82.839 Y79.879 E.06199
M204 S250
G1 X82.452 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.55 Y79.41 E.29696
G1 F1639.071
G1 X97.575 Y79.41 E.0005
G1 F2536.476
G1 X97.575 Y79.81 E.00787
G1 X97.574 Y80.2 E.00766
M73 P47 R17
G1 X97.57 Y80.8 E.0118
G1 X97.555 Y82.801 E.03937
G1 X97.571 Y85.766 E.05832
G1 X97.555 Y86.398 E.01243
G1 F2340
G1 X97.558 Y86.998 E.0118
G1 F2536.476
G1 X97.567 Y88.599 E.0315
G1 X97.572 Y90.6 E.03935
G1 X97.563 Y92.201 E.0315
G1 F2340
G1 X97.555 Y93.602 E.02755
G1 F2536.476
G1 X97.571 Y94.234 E.01243
G1 X97.555 Y97.199 E.05832
G1 X97.574 Y100.59 E.06671
G1 F1634.082
G1 X97.55 Y100.59 E.00048
G1 F1500
G1 X82.452 Y100.59 E.29695
G1 F1640.474
G1 X82.427 Y100.59 E.0005
G1 F2536.476
G1 X82.429 Y100.19 E.00787
G1 X82.446 Y97.197 E.05886
G1 X82.431 Y96.706 E.00966
G1 X82.446 Y93.6 E.0611
G1 F2340
G1 X82.442 Y93 E.0118
G1 F2536.476
G1 X82.438 Y92.287 E.01403
G1 X82.434 Y91.573 E.01403
G1 X82.425 Y90.26 E.02583
G1 X82.432 Y88.995 E.02488
G1 X82.436 Y88.33 E.01308
G1 F2340
G1 X82.446 Y86.4 E.03796
G1 F2536.476
G1 X82.431 Y83.294 E.0611
G1 X82.446 Y82.803 E.00966
G1 X82.427 Y79.444 E.06605
; WIPE_START
M204 S6000
G1 X84.427 Y79.44 E-.38
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




G1 X85.194 Y86.247
G1 Z2.24
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X85.194 Y87.944 E.03592
G1 X84.538 Y88.629 E.02009
G1 X84.082 Y89.011 E.01258
G1 X83.995 Y89.044 E.00198
G1 X83.995 Y91.938 E.06126
G1 X84.538 Y91.371 E.01661
G1 X84.993 Y90.989 E.01258
G1 X85.194 Y90.915 E.00454
G1 X85.194 Y95.227 E.09126
G1 X84.538 Y95.912 E.02009
G1 X84.082 Y96.294 E.01258
G1 X83.995 Y96.327 E.00197
G1 X83.995 Y99.221 E.06126
G1 X84.538 Y98.654 E.0166
G1 X84.993 Y98.272 E.01258
G1 X85.448 Y98.104 E.01027
G1 X85.903 Y98.081 E.00965
G1 X86.358 Y98.155 E.00976
G1 X86.814 Y98.32 E.01025
G1 X87.269 Y98.603 E.01134
G1 X88.026 Y99.394 E.02317
G1 X91.113 Y99.394 E.06534
G1 X91.821 Y98.654 E.02167
G1 X92.276 Y98.272 E.01258
G1 X92.731 Y98.104 E.01027
G1 X93.186 Y98.081 E.00965
G1 X93.642 Y98.155 E.00976
G1 X94.097 Y98.32 E.01025
G1 X94.552 Y98.603 E.01134
G1 X95.309 Y99.394 E.02317
G1 X96.005 Y99.394 E.01473
G1 X96.003 Y98.392 E.02119
; WIPE_START
G1 X96.005 Y99.394 E-.19024
G1 X95.309 Y99.394 E-.13219
G1 X95.1 Y99.175 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.027 Y96.305 Z2.64 F18000
G1 X87.784 Y96.206 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X89.481 Y96.206 E.03592
G1 X89.545 Y96.246 E.0016
G1 X90 Y96.412 E.01025
G1 X90.455 Y96.485 E.00976
G1 X90.91 Y96.462 E.00965
G1 X91.366 Y96.294 E.01027
G1 X91.471 Y96.206 E.0029
G1 X94.807 Y96.206 E.07061
G1 X94.807 Y94.557 E.03492
G1 X95.007 Y94.63 E.00452
G1 X95.462 Y95.013 E.01258
G1 X95.998 Y95.573 E.0164
G1 X95.994 Y92.681 E.0612
G1 X95.918 Y92.653 E.00173
G1 X95.462 Y92.271 E.01258
G1 X94.807 Y91.586 E.02007
G1 X94.807 Y87.273 E.09127
G1 X95.007 Y87.347 E.00452
G1 X95.462 Y87.73 E.01258
G1 X95.999 Y88.29 E.01641
G1 X96.002 Y85.401 E.06115
G1 X95.918 Y85.37 E.00189
G1 X95.462 Y84.987 E.01258
G1 X94.807 Y84.303 E.02007
G1 X94.807 Y83.794 E.01077
G1 X94.161 Y83.794 E.01367
G1 X94.097 Y83.754 E.00159
G1 X93.642 Y83.589 E.01025
G1 X93.186 Y83.515 E.00976
G1 X92.731 Y83.538 E.00965
G1 X92.276 Y83.706 E.01027
G1 X92.171 Y83.794 E.00289
G1 X86.877 Y83.794 E.11205
G1 X86.814 Y83.754 E.00159
G1 X86.358 Y83.589 E.01025
G1 X85.903 Y83.515 E.00976
G1 X85.448 Y83.538 E.00965
G1 X84.993 Y83.706 E.01027
G1 X84.538 Y84.088 E.01258
G1 X83.995 Y84.655 E.01662
G1 X83.994 Y81.761 E.06127
G1 X84.082 Y81.728 E.00199
G1 X84.538 Y81.346 E.01258
G1 X85.246 Y80.606 E.02167
G1 X88.332 Y80.606 E.06533
G1 X89.09 Y81.397 E.02318
G1 X89.545 Y81.68 E.01134
G1 X90 Y81.845 E.01025
G1 X90.455 Y81.919 E.00976
G1 X90.91 Y81.896 E.00965
G1 X91.366 Y81.728 E.01027
G1 X91.821 Y81.346 E.01258
G1 X92.529 Y80.606 E.02167
G1 X95.615 Y80.606 E.06533
G1 X96.006 Y81.014 E.01195
G1 X96.004 Y82.711 E.03592
; WIPE_START
G1 X96.006 Y81.014 E-.32243
G1 X95.796 Y80.795 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.372 Y80.609 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X96.369 Y99.332 E.31759
; WIPE_START
G1 X96.37 Y97.332 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.835 Y98.551 Z2.64 F18000
G1 X83.631 Y99.392 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X83.63 Y80.668 E.31762
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.63 Y82.668 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/74
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I-1.191 J.25 P1  F18000
G1 X86.39 Y95.843 Z2.64
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.563 Y85.612 Z2.76 F18000
G1 X83.202 Y80.243 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.804 Y80.243 E.2879
G1 X96.805 Y80.692 E.00949
G1 X96.787 Y82.804 E.04469
G1 X96.804 Y83.986 E.02502
G1 X96.804 Y85.828 E.03899
G1 X96.787 Y86.389 E.01188
G1 X96.805 Y88.203 E.03838
G1 X96.787 Y93.614 E.11455
G1 X96.804 Y94.172 E.01181
G1 X96.804 Y96.006 E.03882
G1 X96.787 Y96.575 E.01205
G1 X96.8 Y99.757 E.06734
G1 X83.202 Y99.757 E.2878
G1 X83.202 Y80.303 E.41174
M204 S10000
G1 X82.776 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.228 Y79.819 E.3059
G1 X97.229 Y80.694 E.01851
G1 X97.211 Y82.802 E.04463
G1 X97.229 Y83.983 E.02498
G1 X97.229 Y85.835 E.03921
G1 X97.211 Y86.394 E.01183
G1 X97.229 Y88.202 E.03827
G1 X97.211 Y93.609 E.11444
G1 X97.229 Y94.165 E.01179
G1 X97.229 Y96.013 E.03911
G1 X97.211 Y96.581 E.01203
G1 X97.226 Y100.181 E.0762
G1 X82.776 Y100.181 E.30584
G1 X82.79 Y97.192 E.06327
G1 X82.772 Y96.635 E.01179
G1 X82.772 Y94.787 E.03911
G1 X82.79 Y94.219 E.01204
G1 X82.773 Y91.27 E.06242
G1 X82.79 Y86.397 E.10315
G1 X82.772 Y85.218 E.02496
G1 X82.772 Y83.365 E.03921
G1 X82.79 Y82.808 E.01179
G1 X82.776 Y79.879 E.062
M204 S250
G1 X82.385 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.616 Y79.41 E.29958
G1 F1920
G1 X97.637 Y79.41 E.00042
M73 P48 R17
G1 F2536.476
G1 X97.638 Y79.81 E.00787
G1 X97.638 Y80.01 E.00393
G1 X97.638 Y80.695 E.01348
G1 X97.62 Y82.801 E.04142
G1 X97.638 Y83.98 E.02318
G1 X97.638 Y85.841 E.03662
G1 X97.62 Y86.398 E.01095
G1 F2340
G1 X97.626 Y86.998 E.0118
G1 F2536.476
G1 X97.632 Y87.601 E.01186
G1 X97.638 Y88.201 E.0118
G1 X97.636 Y88.801 E.0118
G1 X97.627 Y91.602 E.0551
G1 F2340
G1 X97.62 Y93.603 E.03935
G1 F2536.476
G1 X97.638 Y94.159 E.01094
G1 X97.638 Y96.019 E.03659
G1 X97.62 Y96.586 E.01116
G1 X97.623 Y97.186 E.0118
G1 X97.628 Y98.588 E.02757
G1 X97.635 Y100.19 E.03151
G1 X97.637 Y100.59 E.00787
G1 F1612.087
G1 X97.616 Y100.59 E.0004
G1 F1500
G1 X82.385 Y100.59 E.29957
G1 F1920
G1 X82.365 Y100.59 E.0004
G1 F2536.476
G1 X82.367 Y100.19 E.00787
G1 X82.378 Y97.797 E.04706
G1 X82.363 Y96.641 E.02274
G1 X82.363 Y94.781 E.03659
G1 X82.38 Y94.214 E.01117
G1 X82.377 Y93.614 E.0118
G1 X82.365 Y90.67 E.0579
G1 X82.37 Y89.446 E.02407
G1 F2340
G1 X82.38 Y86.399 E.05994
G1 F2536.476
G1 X82.363 Y85.221 E.02318
G1 X82.363 Y83.359 E.03662
G1 X82.378 Y82.203 E.02274
G1 X82.365 Y79.449 E.05416
; WIPE_START
M204 S6000
G1 X84.365 Y79.444 E-.38
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




G1 X83.565 Y87.583
G1 Z2.36
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.565 Y89.28 E.03592
G1 X83.627 Y89.282 E.00132
G1 X84.082 Y89.159 E.00998
G1 X84.538 Y88.789 E.01241
G1 X85.194 Y88.026 E.0213
G1 X85.194 Y90.787 E.05844
G1 X84.993 Y90.841 E.00441
G1 X84.538 Y91.211 E.01241
G1 X83.627 Y92.27 E.02955
G1 X83.565 Y92.314 E.00162
G1 X83.565 Y94.011 E.03592
; WIPE_START
G1 X83.565 Y92.314 E-.32243
G1 X83.627 Y92.27 E-.01453
G1 X83.775 Y92.098 E-.04304
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.789 Y95.107 Z2.76 F18000
G1 X93.352 Y96.206 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X91.655 Y96.206 E.03592
G1 X91.366 Y96.442 E.0079
G1 X90.91 Y96.565 E.00998
G1 X90.455 Y96.547 E.00964
G1 X90 Y96.438 E.00991
G1 X89.502 Y96.206 E.01162
G1 X85.194 Y96.206 E.09119
G1 X85.194 Y95.309 E.01899
G1 X84.538 Y96.072 E.0213
G1 X84.082 Y96.442 E.01241
G1 X83.627 Y96.565 E.00998
G1 X83.565 Y96.563 E.00132
G1 X83.565 Y99.394 E.05992
G1 X83.764 Y99.394 E.00422
G1 X84.538 Y98.495 E.0251
M73 P48 R16
G1 X84.993 Y98.125 E.01241
G1 X85.448 Y98.001 E.00998
G1 X85.903 Y98.019 E.00964
G1 X86.358 Y98.129 E.00991
G1 X86.814 Y98.33 E.01053
G1 X87.269 Y98.655 E.01184
G1 X87.904 Y99.394 E.02062
G1 X91.047 Y99.394 E.06653
G1 X91.821 Y98.495 E.0251
G1 X92.276 Y98.125 E.01241
G1 X92.731 Y98.001 E.00998
G1 X93.186 Y98.019 E.00964
G1 X93.642 Y98.129 E.00991
G1 X94.097 Y98.33 E.01053
G1 X94.552 Y98.655 E.01184
G1 X95.187 Y99.394 E.02062
G1 X96.435 Y99.394 E.02642
G1 X96.424 Y96.57 E.05976
G1 X96.442 Y95.96 E.01291
G1 X96.373 Y95.911 E.00179
G1 X95.462 Y94.853 E.02955
G1 X95.007 Y94.483 E.01241
G1 X94.807 Y94.429 E.0044
G1 X94.807 Y91.668 E.05843
G1 X95.462 Y92.43 E.02128
G1 X95.918 Y92.8 E.01241
G1 X96.373 Y92.924 E.00998
G1 X96.426 Y92.922 E.00113
G1 X96.432 Y91.225 E.03592
; WIPE_START
G1 X96.426 Y92.922 E-.32243
G1 X96.373 Y92.924 E-.01016
G1 X96.132 Y92.858 E-.04741
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.807 Y88.843 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X94.807 Y87.146 E.03592
G1 X95.007 Y87.2 E.0044
G1 X95.462 Y87.57 E.01241
G1 X96.373 Y88.628 E.02955
G1 X96.44 Y88.677 E.00176
G1 X96.442 Y88.204 E.01
G1 X96.424 Y86.385 E.03849
G1 X96.442 Y85.638 E.01583
G1 X96.373 Y85.641 E.00146
G1 X95.918 Y85.517 E.00998
G1 X95.462 Y85.147 E.01241
G1 X94.807 Y84.385 E.02128
G1 X94.807 Y83.794 E.01251
G1 X94.139 Y83.794 E.01413
G1 X93.642 Y83.562 E.01161
G1 X93.186 Y83.453 E.00991
G1 X92.731 Y83.435 E.00964
G1 X92.276 Y83.558 E.00998
G1 X91.986 Y83.794 E.0079
G1 X86.856 Y83.794 E.10859
G1 X86.358 Y83.562 E.01161
G1 X85.903 Y83.453 E.00991
G1 X85.448 Y83.435 E.00964
G1 X84.993 Y83.558 E.00998
G1 X84.538 Y83.928 E.01241
G1 X83.627 Y84.987 E.02955
G1 X83.565 Y85.031 E.00162
G1 X83.565 Y81.997 E.06423
G1 X83.627 Y81.999 E.00132
G1 X84.082 Y81.876 E.00998
G1 X84.538 Y81.506 E.01241
G1 X85.311 Y80.606 E.02511
G1 X88.454 Y80.606 E.06652
G1 X89.09 Y81.345 E.02062
G1 X89.545 Y81.671 E.01184
G1 X90 Y81.872 E.01053
G1 X90.455 Y81.981 E.00991
G1 X90.91 Y81.999 E.00964
G1 X91.366 Y81.876 E.00998
G1 X91.821 Y81.506 E.01241
G1 X92.594 Y80.606 E.02511
G1 X95.737 Y80.606 E.06652
G1 X96.373 Y81.345 E.02062
G1 X96.436 Y81.39 E.00164
G1 X96.428 Y83.087 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X96.436 Y81.39 E-.32242
G1 X96.373 Y81.345 E-.01475
G1 X96.226 Y81.174 E-.04283
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/74
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I-1.011 J-.678 P1  F18000
G1 X86.39 Y95.843 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.528 Y85.621 Z2.88 F18000
G1 X83.138 Y80.243 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.862 Y80.243 E.29049
G1 X96.851 Y84.07 E.08099
G1 X96.863 Y99.757 E.33202
G1 X83.139 Y99.757 E.29048
G1 X83.138 Y80.303 E.41174
M204 S10000
G1 X82.713 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.288 Y79.819 E.30848
G1 X97.275 Y84.07 E.08998
G1 X97.288 Y100.181 E.34099
G1 X82.714 Y100.181 E.30847
G1 X82.726 Y94.871 E.11239
G1 X82.713 Y79.879 E.31731
M204 S250
G1 X82.323 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.678 Y79.41 E.30203
G1 F1920
G1 X97.698 Y79.41 E.00038
G1 F2536.476
G1 X97.698 Y79.542 E.0026
G1 F2340
G1 X97.691 Y81.806 E.04453
G1 F2130
G1 X97.684 Y84.07 E.04453
G1 F1710
G1 X97.685 Y84.67 E.0118
G1 F1920
G1 X97.689 Y90.798 E.12053
G1 F2130
G1 X97.692 Y93.862 E.06026
G1 F2340
G1 X97.694 Y96.926 E.06026
G1 F2536.476
G1 X97.697 Y100.19 E.0642
G1 X97.697 Y100.59 E.00787
G1 F1602.643
G1 X97.678 Y100.59 E.00037
G1 F1500
G1 X82.323 Y100.59 E.30203
G1 F1920
G1 X82.304 Y100.59 E.00038
G1 F2340
G1 X82.307 Y99.086 E.02958
G1 F2130
G1 X82.309 Y98.182 E.01778
G1 F1920
M73 P49 R16
G1 X82.313 Y96.375 E.03556
G1 F1710
G1 X82.317 Y94.871 E.02958
G1 F2130
G1 X82.312 Y89.517 E.1053
G1 F2340
G1 X82.308 Y84.764 E.0935
G1 F2536.476
G1 X82.303 Y79.45 E.1045
; WIPE_START
M204 S6000
G1 X84.303 Y79.445 E-.38
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




G1 X83.501 Y87.672
G1 Z2.48
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.501 Y89.369 E.03592
G1 X83.627 Y89.398 E.00274
G1 X84.082 Y89.331 E.00974
G1 X84.538 Y88.983 E.01213
G1 X85.194 Y88.116 E.02302
G1 X85.194 Y90.639 E.05341
G1 X84.993 Y90.669 E.0043
G1 X84.538 Y91.017 E.01213
G1 X83.627 Y92.22 E.03194
G1 X83.501 Y92.323 E.00344
G1 X83.501 Y94.02 E.03592
; WIPE_START
G1 X83.501 Y92.323 E-.32243
G1 X83.627 Y92.22 E-.03092
G1 X83.712 Y92.109 E-.02665
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.759 Y95.04 Z2.88 F18000
G1 X93.563 Y96.206 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X91.866 Y96.206 E.03592
G1 X91.821 Y96.266 E.00159
G1 X91.366 Y96.615 E.01213
G1 X90.91 Y96.682 E.00974
G1 X90 Y96.472 E.01977
G1 X89.511 Y96.206 E.01178
G1 X85.194 Y96.206 E.09137
G1 X85.194 Y95.399 E.01709
G1 X84.538 Y96.266 E.02302
G1 X84.082 Y96.615 E.01213
G1 X83.627 Y96.682 E.00974
G1 X83.502 Y96.653 E.00273
G1 X83.502 Y99.394 E.05802
G1 X83.71 Y99.394 E.00441
G1 X84.538 Y98.3 E.02902
G1 X84.993 Y97.952 E.01213
G1 X85.448 Y97.885 E.00974
G1 X86.358 Y98.095 E.01977
G1 X86.814 Y98.332 E.01087
G1 X87.269 Y98.704 E.01245
G1 X87.854 Y99.394 E.01914
G1 X90.994 Y99.394 E.06644
G1 X91.821 Y98.3 E.02902
G1 X92.276 Y97.952 E.01213
G1 X92.731 Y97.885 E.00974
G1 X93.642 Y98.095 E.01977
G1 X94.097 Y98.332 E.01087
G1 X94.552 Y98.704 E.01245
G1 X95.138 Y99.394 E.01914
G1 X96.5 Y99.394 E.02883
G1 X96.497 Y95.964 E.0726
G1 X96.373 Y95.862 E.0034
G1 X95.462 Y94.659 E.03194
G1 X95.007 Y94.31 E.01213
G1 X94.807 Y94.281 E.00429
G1 X94.807 Y91.758 E.0534
G1 X95.462 Y92.625 E.023
G1 X95.918 Y92.973 E.01213
G1 X96.373 Y93.04 E.00974
G1 X96.495 Y93.012 E.00265
G1 X96.493 Y91.315 E.03592
; WIPE_START
G1 X96.495 Y93.012 E-.32243
G1 X96.373 Y93.04 E-.0238
G1 X96.197 Y93.014 E-.03377
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.807 Y88.695 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X94.807 Y86.998 E.03592
G1 X95.007 Y87.027 E.00429
G1 X95.462 Y87.376 E.01213
G1 X96.373 Y88.579 E.03194
G1 X96.491 Y88.676 E.00324
G1 X96.489 Y85.73 E.06235
G1 X96.373 Y85.757 E.00253
G1 X95.918 Y85.69 E.00974
G1 X95.462 Y85.341 E.01213
G1 X94.807 Y84.475 E.023
G1 X94.807 Y83.794 E.01442
G1 X94.131 Y83.794 E.01431
G1 X93.642 Y83.529 E.01177
G1 X92.731 Y83.319 E.01977
G1 X92.276 Y83.386 E.00974
G1 X91.821 Y83.734 E.01213
G1 X91.776 Y83.794 E.00158
G1 X86.848 Y83.794 E.10431
G1 X86.358 Y83.529 E.01177
G1 X85.448 Y83.319 E.01977
G1 X84.993 Y83.386 E.00974
G1 X84.538 Y83.734 E.01213
G1 X83.627 Y84.937 E.03194
G1 X83.501 Y85.041 E.00346
G1 X83.501 Y82.086 E.06254
G1 X83.627 Y82.115 E.00275
G1 X84.082 Y82.048 E.00974
G1 X84.538 Y81.7 E.01213
G1 X85.365 Y80.606 E.02902
G1 X88.568 Y80.606 E.06779
G1 X89.09 Y81.296 E.0183
G1 X89.545 Y81.668 E.01245
G1 X90 Y81.905 E.01087
G1 X90.91 Y82.115 E.01977
G1 X91.366 Y82.048 E.00974
G1 X91.821 Y81.7 E.01213
G1 X92.648 Y80.606 E.02903
G1 X95.851 Y80.606 E.06779
G1 X96.373 Y81.296 E.0183
G1 X96.496 Y81.396 E.00336
G1 X96.491 Y83.093 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X96.496 Y81.396 E-.32243
G1 X96.373 Y81.296 E-.03017
G1 X96.286 Y81.181 E-.0274
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 21/74
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-1.009 J-.681 P1  F18000
G1 X86.39 Y95.843 Z2.88
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.498 Y85.628 Z3 F18000
G1 X83.082 Y80.243 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.92 Y80.243 E.2929
G1 X96.92 Y80.511 E.00566
G1 X96.92 Y83.699 E.06749
G1 X96.898 Y84.108 E.00866
G1 X96.92 Y86.352 E.04749
G1 X96.92 Y93.648 E.15443
G1 X96.898 Y95.892 E.04749
G1 X96.92 Y96.301 E.00866
G1 X96.92 Y99.757 E.07315
G1 X83.082 Y99.757 E.29289
G1 X83.081 Y97.152 E.05513
G1 X83.102 Y94.908 E.04749
G1 X83.081 Y94.499 E.00866
G1 X83.081 Y85.501 E.19047
G1 X83.102 Y85.092 E.00866
G1 X83.081 Y82.848 E.04749
G1 X83.082 Y80.303 E.05386
M204 S10000
G1 X82.658 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.344 Y79.819 E.31085
G1 X97.345 Y80.511 E.01464
G1 X97.344 Y83.711 E.06773
G1 X97.323 Y84.117 E.00862
G1 X97.344 Y86.35 E.04727
G1 X97.344 Y93.65 E.1545
G1 X97.323 Y95.883 E.04727
G1 X97.344 Y96.289 E.00862
G1 X97.344 Y100.181 E.08237
G1 X82.658 Y100.181 E.31084
G1 X82.656 Y97.15 E.06415
G1 X82.678 Y94.917 E.04726
G1 X82.656 Y94.511 E.00862
G1 X82.656 Y85.489 E.19094
G1 X82.678 Y85.083 E.00862
G1 X82.656 Y82.85 E.04726
G1 X82.658 Y79.879 E.06288
M204 S250
G1 X82.262 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.739 Y79.41 E.3044
G1 F1710
G1 X97.753 Y79.41 E.00029
G1 F2340
G1 X97.753 Y79.81 E.00787
G1 X97.754 Y80.511 E.01379
G1 X97.754 Y81.111 E.0118
G1 F2536.476
G1 X97.754 Y81.781 E.01318
M73 P50 R16
G1 X97.754 Y82.451 E.01318
G1 X97.753 Y83.322 E.01712
G1 X97.753 Y83.722 E.00787
G1 F1920
G1 X97.732 Y84.126 E.00797
G1 F1500
G1 X97.738 Y84.726 E.0118
G1 F1920
G1 X97.748 Y85.748 E.0201
G1 F2130
G1 X97.753 Y86.348 E.0118
G1 F2536.476
G1 X97.753 Y93.652 E.14367
G1 F2130
G1 X97.748 Y94.252 E.0118
G1 F1920
G1 X97.738 Y95.274 E.0201
G1 F1500
G1 X97.732 Y95.874 E.0118
G1 F1920
G1 X97.753 Y96.278 E.00797
G1 F2536.476
G1 X97.753 Y96.678 E.00787
G1 X97.753 Y96.878 E.00393
G1 X97.753 Y97.501 E.01224
G1 X97.753 Y98.745 E.02448
G1 F2340
G1 X97.753 Y100.19 E.02841
G1 X97.753 Y100.59 E.00787
G1 F1579.65
G1 X97.738 Y100.59 E.00029
G1 F1500
G1 X82.262 Y100.59 E.3044
G1 F1710
G1 X82.249 Y100.59 E.00027
G1 F2130
G1 X82.248 Y99.99 E.0118
G1 F2340
G1 X82.248 Y99.243 E.0147
G1 F2536.476
G1 X82.248 Y98.495 E.0147
G1 X82.247 Y97.148 E.0265
G1 F2130
G1 X82.253 Y96.548 E.0118
G1 F1920
G1 X82.263 Y95.526 E.0201
G1 F1500
G1 X82.269 Y94.926 E.0118
G1 F2130
G1 X82.247 Y94.521 E.00797
G1 F2536.476
G1 X82.247 Y85.479 E.17787
G1 F2130
G1 X82.269 Y85.074 E.00797
G1 F1500
G1 X82.263 Y84.474 E.0118
G1 F1920
G1 X82.253 Y83.452 E.0201
G1 F2130
G1 X82.247 Y82.852 E.0118
G1 F2536.476
G1 X82.247 Y82.252 E.0118
G1 X82.248 Y81.505 E.0147
G1 F2340
G1 X82.248 Y80.757 E.0147
G1 F2130
G1 X82.249 Y79.456 E.02559
; WIPE_START
M204 S6000
G1 X84.249 Y79.45 E-.38
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




G1 X85.664 Y83.778
G1 Z2.6
G1 E.4 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F2941.177;_EXTRUDE_SET_SPEED
M204 S6000
G1 X94.656 Y83.778 E.15252
G1 X94.794 Y83.806 E.00239
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.415952
G1 F2562.788;_EXTRUDE_SET_SPEED
G1 X94.819 Y84.304 E.0097
; Slow Down End
M204 S10000
G1 X95.074 Y83.399 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X93.377 Y83.399 E.03592
G1 X92.731 Y83.187 E.01439
G1 X92.276 Y83.174 E.00964
G1 X91.93 Y83.399 E.00873
G1 X86.094 Y83.399 E.12354
G1 X85.448 Y83.187 E.01439
G1 X84.993 Y83.174 E.00964
G1 X84.538 Y83.471 E.0115
G1 X84.082 Y84.229 E.01871
G1 X83.627 Y84.89 E.017
G1 X83.465 Y85.042 E.0047
G1 X83.444 Y82.187 E.06043
G1 X83.627 Y82.247 E.00409
G1 X84.082 Y82.26 E.00964
G1 X84.538 Y81.963 E.0115
G1 X85.134 Y81.001 E.02396
G1 X88.919 Y81.001 E.08012
G1 X89.09 Y81.249 E.00637
G1 X89.545 Y81.673 E.01317
G1 X90 Y81.947 E.01125
G1 X90.91 Y82.247 E.02029
G1 X91.366 Y82.26 E.00964
G1 X91.821 Y81.963 E.0115
G1 X92.417 Y81.001 E.02396
G1 X95.424 Y81.001 E.06365
G1 X95.513 Y80.696 E.00672
G1 X95.374 Y80.606 E.00351
G1 X95.931 Y80.606 E.01179
G1 X96.373 Y81.249 E.0165
G1 X96.163 Y81.114 E.00528
G1 X96.163 Y82.087 E.02061
G1 X96.213 Y82.12 E.00127
G1 X96.21 Y83.743 E.03436
G1 X96.193 Y84.44 E.01476
G1 X96.144 Y84.421 E.00111
G1 X96.153 Y85.307 E.01875
G1 X96.549 Y85.466 E.00903
G1 X96.552 Y85.83 E.0077
G1 X96.373 Y85.889 E.00399
G1 X95.918 Y85.901 E.00964
G1 X95.462 Y85.605 E.0115
G1 X95.007 Y84.846 E.01873
G1 X94.807 Y84.766 E.00456
G1 X94.807 Y86.821 E.0435
G1 X95.007 Y86.816 E.00425
G1 X95.462 Y87.112 E.0115
G1 X95.918 Y87.87 E.01871
G1 X96.373 Y88.532 E.017
G1 X96.557 Y88.704 E.00533
G1 X96.557 Y93.111 E.09329
G1 X96.373 Y93.172 E.00411
G1 X95.918 Y93.185 E.00964
G1 X95.462 Y92.888 E.0115
G1 X95.007 Y92.13 E.01871
G1 X94.807 Y91.838 E.00749
G1 X94.807 Y94.104 E.04796
G1 X95.007 Y94.099 E.00425
G1 X95.462 Y94.395 E.0115
G1 X95.918 Y95.153 E.01871
G1 X96.145 Y95.484 E.00849
G1 X96.142 Y95.788 E.00644
G1 X96.189 Y95.789 E.001
G1 X96.21 Y96.257 E.00991
G1 X96.211 Y96.643 E.00818
G1 X96.163 Y96.684 E.00135
G1 X96.163 Y97.764 E.02286
G1 X96.557 Y97.425 E.01101
G1 X96.557 Y99.394 E.04166
G1 X95.245 Y99.394 E.02776
G1 X95.246 Y98.999 E.00835
G1 X94.723 Y98.999 E.01108
G1 X94.552 Y98.751 E.00637
G1 X94.097 Y98.327 E.01317
G1 X93.642 Y98.053 E.01125
G1 X92.731 Y97.753 E.02029
G1 X92.276 Y97.74 E.00964
G1 X91.821 Y98.037 E.0115
G1 X91.225 Y98.999 E.02396
G1 X87.439 Y98.999 E.08013
G1 X87.269 Y98.751 E.00637
G1 X86.814 Y98.327 E.01317
G1 X86.358 Y98.053 E.01125
G1 X85.448 Y97.753 E.02029
G1 X84.993 Y97.74 E.00964
G1 X84.538 Y98.037 E.0115
G1 X83.942 Y98.999 E.02396
G1 X83.838 Y98.999 E.00219
G1 X83.838 Y98.25 E.01586
G1 X83.814 Y98.215 E.00089
G1 X83.838 Y98.195 E.00067
G1 X83.838 Y97.115 E.02285
G1 X83.444 Y97.454 E.011
G1 X83.447 Y96.754 E.01481
G1 X83.627 Y96.814 E.00401
G1 X84.082 Y96.826 E.00964
G1 X84.538 Y96.529 E.0115
G1 X84.993 Y95.772 E.01871
G1 X85.194 Y95.479 E.00751
G1 X85.194 Y93.782 E.03592
; WIPE_START
G1 X85.194 Y95.479 E-.32243
G1 X85.022 Y95.729 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.444 Y94.042 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X83.444 Y92.345 E.03592
G1 X83.627 Y92.173 E.00532
G1 X84.082 Y91.512 E.017
G1 X84.538 Y90.754 E.01871
G1 X84.993 Y90.457 E.0115
G1 X85.194 Y90.463 E.00426
G1 X85.194 Y88.196 E.04798
G1 X84.993 Y88.488 E.00751
G1 X84.538 Y89.246 E.01871
G1 X84.082 Y89.543 E.0115
G1 X83.627 Y89.53 E.00964
G1 X83.444 Y89.47 E.00409
G1 X83.444 Y87.773 E.03592
; WIPE_START
G1 X83.444 Y89.47 E-.32243
G1 X83.627 Y89.53 E-.03676
G1 X83.737 Y89.533 E-.02082
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.044 Y95.835 Z3 F18000
G1 X88.567 Y96.601 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X90.264 Y96.601 E.03592
G1 X90.91 Y96.814 E.0144
G1 X91.366 Y96.826 E.00964
G1 X91.711 Y96.601 E.00874
G1 X93.408 Y96.601 E.03592
; WIPE_START
G1 X91.711 Y96.601 E-.32243
G1 X91.458 Y96.766 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.822 Y95.516 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.370068
G1 F2904.307;_EXTRUDE_SET_SPEED
M204 S6000
G1 X94.794 Y96.194 E.01165
G1 X94.656 Y96.222 E.00242
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.365752
G1 F2941.177;_EXTRUDE_SET_SPEED
G1 X85.518 Y96.222 E.155
; Slow Down End
; WIPE_START
G1 X87.518 Y96.222 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.46 Y98.474 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1200
M204 S6000
G1 X83.447 Y98.329 E.00247
G1 X83.458 Y97.999 E.0056
; WIPE_START
G1 X83.447 Y98.329 E-.26358
G1 X83.46 Y98.474 E-.11642
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.068 Y99.084 Z3 F18000
G1 X94.74 Y99.378 Z3
G1 Z2.6
G1 E.4 F1800
; Slow Down Start
G1 F2941.177;_EXTRUDE_SET_SPEED
M204 S6000
G1 X84.149 Y99.378 E.17964
; Slow Down End
; WIPE_START
G1 X86.149 Y99.378 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.264 Y96.615 Z3 F18000
G1 X96.529 Y95.347 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1200
M204 S6000
G1 X96.541 Y96.881 E.02602
; WIPE_START
G1 X96.529 Y95.347 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.529 Y87.715 Z3 F18000
G1 X96.529 Y85.05 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1200
M204 S6000
G1 X96.565 Y83.69 E.02307
G1 X96.567 Y82.004 E.0286
G1 X96.549 Y81.867 E.00235
; WIPE_START
G1 X96.567 Y82.004 E-.02633
G1 X96.565 Y83.69 E-.32031
G1 X96.56 Y83.866 E-.03336
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.699 Y80.622 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; Slow Down Start
G1 F2941.177;_EXTRUDE_SET_SPEED
M204 S6000
G1 X85.016 Y80.622 E.16426
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2941.177
G1 X87.016 Y80.622 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/74
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I-1.216 J-.05 P1  F18000
G1 X86.39 Y95.843 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.468 Y85.636 Z3.12 F18000
G1 X83.028 Y80.243 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.973 Y80.243 E.29517
G1 X96.973 Y80.718 E.01005
G1 X96.968 Y83.764 E.06446
G1 X96.946 Y84.17 E.00861
G1 X96.972 Y86.028 E.03933
G1 X96.972 Y93.972 E.16815
G1 X96.946 Y95.83 E.03933
G1 X96.968 Y96.236 E.0086
G1 X96.972 Y99.757 E.07452
G1 X83.028 Y99.757 E.29514
G1 X83.028 Y96.828 E.06199
G1 X83.054 Y94.973 E.03926
G1 X83.032 Y94.494 E.01015
G1 X83.032 Y85.506 E.19024
G1 X83.054 Y85.027 E.01015
G1 X83.028 Y83.172 E.03926
G1 X83.028 Y80.303 E.06072
M204 S10000
G1 X82.603 Y79.819 F18000
M73 P51 R16
G1 F1500
M204 S500
G1 X97.398 Y79.819 E.31313
G1 X97.398 Y80.719 E.01905
G1 X97.392 Y83.776 E.06469
G1 X97.371 Y84.178 E.00854
G1 X97.397 Y86.025 E.03908
G1 X97.397 Y93.975 E.16829
G1 X97.371 Y95.822 E.03908
G1 X97.392 Y96.224 E.00853
G1 X97.397 Y100.181 E.08374
G1 X82.603 Y100.181 E.31312
G1 X82.604 Y96.825 E.07104
G1 X82.63 Y94.98 E.03904
G1 X82.608 Y94.504 E.01009
G1 X82.608 Y85.496 E.19066
G1 X82.63 Y85.02 E.01009
G1 X82.604 Y83.175 E.03904
G1 X82.604 Y79.879 E.06977
M204 S250
G1 X82.208 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.794 Y79.41 E.30657
G1 F1710
G1 X97.807 Y79.41 E.00026
G1 F2130
G1 X97.807 Y80.72 E.02577
G1 X97.806 Y81.32 E.0118
G1 F1710
G1 X97.801 Y83.787 E.04852
G1 F1920
G1 X97.78 Y84.186 E.00787
G1 F1500
G1 X97.784 Y84.444 E.00507
G1 X97.787 Y84.674 E.00452
G1 F1710
G1 X97.795 Y85.274 E.0118
G1 F1920
G1 X97.797 Y85.422 E.0029
G1 F2130
G1 X97.797 Y94.579 E.18011
G1 F1920
G1 X97.795 Y94.726 E.0029
G1 F1710
G1 X97.787 Y95.326 E.0118
G1 F1500
G1 X97.784 Y95.556 E.00452
G1 X97.78 Y95.814 E.00507
G1 F1920
G1 X97.801 Y96.213 E.00787
G1 F1710
G1 X97.802 Y96.813 E.0118
G1 F1920
G1 X97.804 Y98.402 E.03124
G1 F2130
G1 X97.807 Y100.59 E.04304
G1 F1710
G1 X97.794 Y100.59 E.00025
G1 F1500
G1 X82.208 Y100.59 E.30657
G1 F1710
G1 X82.194 Y100.59 E.00026
G1 F2130
G1 X82.203 Y96.222 E.08592
G1 F1920
G1 X82.205 Y96.074 E.00291
G1 F1710
G1 X82.214 Y95.474 E.0118
G1 F1500
G1 X82.217 Y95.244 E.00452
G1 X82.221 Y94.987 E.00506
G1 F2130
G1 X82.198 Y94.514 E.00932
G1 F1920
G1 X82.198 Y85.486 E.17756
G1 F2130
G1 X82.221 Y85.013 E.00932
G1 F1500
G1 X82.217 Y84.756 E.00506
G1 X82.214 Y84.526 E.00452
G1 F1710
G1 X82.205 Y83.926 E.0118
G1 F1920
G1 X82.203 Y83.778 E.00291
G1 F2130
M73 P51 R15
G1 X82.194 Y79.457 E.08501
; WIPE_START
M204 S6000
G1 X84.194 Y79.451 E-.38
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




G1 X83.4 Y80.606
G1 Z2.72
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.391 Y82.295 E.03573
G1 X83.627 Y82.398 E.00546
G1 X84.082 Y82.539 E.01008
G1 X84.292 Y82.516 E.00447
G1 X84.567 Y82.858 E.00927
G1 X83.879 Y83.079 E.0153
G1 X84.354 Y83.385 E.01196
G1 X84.082 Y84.036 E.01493
G1 X83.627 Y84.845 E.01966
G1 X83.416 Y85.069 E.00652
G1 X83.395 Y85.515 E.00943
G1 X83.395 Y86.766 E.02649
; WIPE_START
G1 X83.395 Y85.515 E-.23776
G1 X83.416 Y85.069 E-.08467
G1 X83.624 Y84.849 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.194 Y86.618 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X85.194 Y88.315 E.03592
G1 X84.952 Y88.776 E.01102
G1 X84.538 Y89.773 E.02285
G1 X84.082 Y89.822 E.00969
G1 X83.627 Y89.681 E.01008
G1 X83.395 Y89.579 E.00538
G1 X83.395 Y92.375 E.05917
G1 X83.627 Y92.128 E.00717
G1 X84.082 Y91.319 E.01966
G1 X84.538 Y90.227 E.02504
G1 X84.952 Y90.168 E.00886
G1 X85.194 Y90.24 E.00535
G1 X85.194 Y95.598 E.11342
G1 X84.888 Y96.213 E.01452
G1 X83.911 Y97.052 E.02726
G1 X83.627 Y96.965 E.00629
G1 X83.391 Y96.861 E.00546
G1 X83.415 Y95.164 E.03592
; WIPE_START
G1 X83.391 Y96.861 E-.32243
G1 X83.627 Y96.965 E-.04901
G1 X83.67 Y96.978 E-.00856
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.796 Y96.017 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41185
; LAYER_HEIGHT: 0.4
G1 F900.769
M204 S6000
G1 X83.404 Y98.073 E.17471
G1 X83.404 Y98.294 E.01228
G1 X83.573 Y98.536 E.01635
G1 X86.269 Y96.219 E.1969
G1 X86.978 Y96.219 E.03925
G1 X83.839 Y98.917 E.22923
G1 X84.105 Y99.297 E.02571
G1 X87.687 Y96.219 E.26157
G1 X88.395 Y96.219 E.03925
G1 X84.716 Y99.381 E.26868
G1 X85.425 Y99.381 E.03925
G1 X89.104 Y96.219 E.26868
G1 X89.812 Y96.219 E.03925
G1 X86.133 Y99.381 E.26867
G1 X86.842 Y99.381 E.03925
G1 X90.521 Y96.219 E.26867
G1 X91.23 Y96.219 E.03925
G1 X87.551 Y99.381 E.26867
G1 X88.259 Y99.381 E.03925
G1 X91.938 Y96.219 E.26867
G1 X92.647 Y96.219 E.03925
G1 X88.968 Y99.381 E.26867
G1 X89.676 Y99.381 E.03925
G1 X93.356 Y96.219 E.26867
G1 X94.064 Y96.219 E.03925
G1 X90.385 Y99.381 E.26867
G1 X91.094 Y99.381 E.03925
G1 X96.088 Y95.089 E.36469
G1 X96.301 Y95.408 E.02125
G1 X96.424 Y95.41 E.0068
G1 X91.802 Y99.381 E.33748
G1 X92.511 Y99.381 E.03925
G1 X96.573 Y95.89 E.29664
G1 X96.592 Y96.483 E.03283
G1 X93.22 Y99.381 E.24629
G1 X93.928 Y99.381 E.03925
G1 X94.81 Y98.624 E.06435
G1 X94.808 Y99.234 E.0338
G1 X94.401 Y99.583 E.02971
; WIPE_START
G1 X94.808 Y99.234 E-.10191
G1 X94.81 Y98.624 E-.11594
G1 X94.162 Y99.18 E-.16215
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.238 Y94.946 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S6000
G1 X94.807 Y95.115 E.0098
G1 X94.807 Y93.882 E.02611
G1 X95.007 Y93.82 E.00444
G1 X95.462 Y93.869 E.00969
G1 X95.816 Y94.719 E.01949
G1 X96.252 Y94.548 E.00991
G1 X96.536 Y94.974 E.01084
G1 X96.595 Y94.974 E.00125
G1 X96.609 Y93.224 E.03705
G1 X96.209 Y93.378 E.00909
G1 X95.835 Y93.484 E.00821
G1 X95.462 Y93.415 E.00803
G1 X95.007 Y92.323 E.02504
G1 X94.807 Y91.966 E.00866
G1 X94.807 Y90.269 E.03592
; WIPE_START
G1 X94.807 Y91.966 E-.32243
G1 X94.955 Y92.23 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.609 Y90.459 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X96.609 Y88.762 E.03592
G1 X96.209 Y88.243 E.01388
G1 X95.835 Y87.484 E.01791
G1 X95.462 Y86.585 E.02059
G1 X95.007 Y86.536 E.00969
G1 X94.807 Y86.598 E.00444
G1 X94.807 Y84.766 E.03879
G1 X94.867 Y84.79 E.00137
G1 X95.007 Y85.04 E.00607
G1 X95.462 Y86.132 E.02504
G1 X95.835 Y86.201 E.00803
G1 X96.209 Y86.095 E.00821
G1 X96.608 Y85.941 E.00906
G1 X96.609 Y87.638 E.03592
; WIPE_START
G1 X96.608 Y85.941 E-.32243
M73 P52 R15
G1 X96.325 Y86.05 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.247 Y80.606 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X96.611 Y80.606 E.00769
G1 X96.609 Y81.401 E.01682
G1 X96.477 Y81.316 E.00332
G1 X96.209 Y80.96 E.00944
G1 X96.035 Y80.606 E.00834
G1 X95.374 Y80.606 E.01398
G1 X96.246 Y81.167 E.02194
; WIPE_START
G1 X95.374 Y80.606 E-.19693
G1 X96.035 Y80.606 E-.1255
G1 X96.168 Y80.878 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.798 Y82.05 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41324
; LAYER_HEIGHT: 0.4
G1 F894.719
M204 S6000
G1 X94.574 Y80.619 E.14745
G1 X93.718 Y80.619 E.04774
G1 X96.594 Y82.47 E.19073
G1 X96.593 Y83.02 E.03068
G1 X92.862 Y80.619 E.24743
G1 X92.006 Y80.619 E.04774
G1 X96.592 Y83.57 E.30413
G1 X96.573 Y84.109 E.03005
G1 X91.149 Y80.619 E.35962
G1 X90.293 Y80.619 E.04774
G1 X96.577 Y84.662 E.41666
G1 X96.582 Y85.008 E.01928
G1 X95.719 Y84.661 E.05185
G1 X89.437 Y80.619 E.41655
G1 X88.581 Y80.619 E.04774
G1 X93.495 Y83.781 E.32581
G1 X92.639 Y83.781 E.04774
G1 X87.725 Y80.619 E.32581
G1 X86.869 Y80.619 E.04774
G1 X91.783 Y83.781 E.32581
G1 X90.926 Y83.781 E.04774
G1 X86.013 Y80.619 E.32581
G1 X85.157 Y80.619 E.04774
G1 X90.07 Y83.781 E.32581
G1 X89.214 Y83.781 E.04774
G1 X84.916 Y81.015 E.28501
G1 X84.668 Y81.406 E.02583
G1 X88.358 Y83.781 E.24468
G1 X87.502 Y83.781 E.04774
G1 X84.4 Y81.785 E.20565
G1 X84.329 Y81.864 E.00595
G1 X85.039 Y82.747 E.06314
G1 X86.646 Y83.781 E.10657
G1 X85.79 Y83.781 E.04774
G1 X84.681 Y83.067 E.07352
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F894.719
G1 X85.79 Y83.781 E-.25052
G1 X86.471 Y83.781 E-.12948
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/74
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-1.217 J-.008 P1  F18000
G1 X86.39 Y95.843 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.442 Y85.643 Z3.24 F18000
G1 X82.978 Y80.243 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.023 Y80.243 E.29726
G1 X97.013 Y83.882 E.07701
G1 X96.994 Y84.234 E.00748
G1 X97.023 Y85.537 E.02757
G1 X97.005 Y86.529 E.021
G1 X97.024 Y90 E.07348
G1 X97.005 Y93.471 E.07348
G1 X97.023 Y94.463 E.021
G1 X96.994 Y95.766 E.02757
G1 X97.013 Y96.118 E.00747
G1 X97.021 Y99.757 E.07701
G1 X82.978 Y99.757 E.29724
G1 X82.98 Y95.847 E.08274
G1 X83.007 Y95.047 E.01695
G1 X82.986 Y94.521 E.01114
G1 X82.986 Y85.479 E.19139
G1 X83.007 Y84.953 E.01114
G1 X82.98 Y84.153 E.01695
G1 X82.978 Y80.303 E.08147
M204 S10000
G1 X82.554 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.448 Y79.819 E.31525
G1 X97.437 Y83.893 E.08623
G1 X97.418 Y84.241 E.00736
G1 X97.447 Y85.536 E.02742
G1 X97.429 Y86.531 E.02107
G1 X97.448 Y90 E.07342
G1 X97.429 Y93.469 E.07342
G1 X97.447 Y94.464 E.02107
G1 X97.418 Y95.759 E.02742
G1 X97.437 Y96.106 E.00736
G1 X97.446 Y100.181 E.08624
G1 X82.554 Y100.181 E.31522
G1 X82.555 Y95.84 E.09187
G1 X82.582 Y95.048 E.01677
G1 X82.561 Y94.53 E.01098
G1 X82.561 Y85.47 E.19176
G1 X82.582 Y84.952 E.01098
G1 X82.555 Y84.16 E.01677
G1 X82.554 Y79.879 E.0906
M204 S250
G1 X82.154 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.848 Y79.41 E.30868
G1 F1710
G1 X97.857 Y79.41 E.00018
G1 F1920
G1 X97.857 Y79.832 E.0083
G1 X97.855 Y80.432 E.0118
G1 F1710
G1 X97.846 Y83.905 E.06831
G1 F1920
G1 X97.828 Y84.247 E.00674
G1 F1500
G1 X97.838 Y84.683 E.00858
G1 X97.841 Y84.839 E.00306
G1 F1920
G1 X97.857 Y85.535 E.0137
G1 F1500
G1 X97.839 Y86.501 E.019
G1 X97.841 Y87.056 E.0109
G1 X97.844 Y87.656 E.0118
G1 F1710
G1 X97.849 Y88.528 E.01716
G1 F1920
G1 X97.854 Y90.6 E.04076
G1 F1710
G1 X97.849 Y91.472 E.01716
G1 F1500
G1 X97.841 Y92.945 E.02896
G1 X97.839 Y93.499 E.0109
G1 X97.857 Y94.465 E.019
G1 F1920
G1 X97.841 Y95.161 E.0137
G1 F1500
G1 X97.838 Y95.317 E.00306
G1 X97.828 Y95.753 E.00858
G1 F1920
G1 X97.846 Y96.095 E.00674
G1 F1710
G1 X97.855 Y99.99 E.07661
M73 P53 R15
G1 F1920
G1 X97.857 Y100.59 E.0118
G1 F1710
G1 X97.848 Y100.59 E.00017
G1 F1500
G1 X82.154 Y100.59 E.30868
G1 F1710
G1 X82.144 Y100.59 E.0002
G1 F2130
G1 X82.146 Y95.833 E.09356
G1 F1710
G1 X82.173 Y95.05 E.01542
G1 F2130
G1 X82.152 Y94.538 E.01007
G1 F1710
G1 X82.152 Y85.462 E.17852
G1 F2130
G1 X82.173 Y84.95 E.01007
G1 F1710
G1 X82.146 Y84.167 E.01542
G1 F2130
G1 X82.144 Y79.46 E.09257
; WIPE_START
M204 S6000
G1 X84.144 Y79.454 E-.38
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




G1 X83.341 Y80.729
G1 Z2.84
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.342 Y82.426 E.03592
G1 X83.847 Y82.717 E.01235
G1 X84.126 Y83.172 E.0113
G1 X84.095 Y83.627 E.00966
G1 X83.777 Y84.538 E.02041
G1 X83.495 Y84.993 E.01133
G1 X83.363 Y85.132 E.00406
G1 X83.348 Y85.486 E.00751
G1 X83.348 Y89.713 E.08946
G1 X83.847 Y90 E.01219
G1 X84.126 Y90.455 E.0113
G1 X84.095 Y90.91 E.00966
G1 X83.777 Y91.821 E.02041
G1 X83.495 Y92.276 E.01133
G1 X83.348 Y92.43 E.0045
G1 X83.348 Y94.514 E.04411
G1 X83.37 Y95.046 E.01127
G1 X83.343 Y95.854 E.01711
G1 X83.342 Y96.992 E.02409
G1 X83.847 Y97.283 E.01234
G1 X84.126 Y97.738 E.0113
G1 X84.095 Y98.194 E.00966
G1 X83.777 Y99.104 E.02041
G1 X83.598 Y99.394 E.00721
G1 X84.476 Y99.394 E.01859
G1 X84.478 Y92.59 E.144
G1 X84.729 Y92.339 E.00753
G1 X85.194 Y92.339 E.00983
G1 X85.194 Y89.945 E.05067
G1 X84.949 Y89.545 E.00992
G1 X84.981 Y89.09 E.00966
G1 X85.194 Y88.479 E.01369
G1 X85.194 Y87.661 E.0173
G1 X84.729 Y87.661 E.00983
G1 X84.478 Y87.41 E.00753
G1 X84.478 Y87.351 E.00125
; WIPE_START
G1 X84.478 Y87.41 E-.01121
G1 X84.729 Y87.661 E-.0676
G1 X85.194 Y87.661 E-.08828
G1 X85.194 Y88.479 E-.15533
G1 X85.094 Y88.765 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.345 Y83.747 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.656 Y83.747 E.18314
; LINE_WIDTH: 0.40335
G1 X94.738 Y83.846 E.00241
; LINE_WIDTH: 0.353861
G1 X94.82 Y83.944 E.0021
G1 X94.82 Y87.285 E.05469
G1 X95.132 Y87.27 E.00512
G1 X95.148 Y87.121 E.00244
G1 X95.147 Y83.944 E.052
; LINE_WIDTH: 0.370065
G1 X95.131 Y83.617 E.00564
; LINE_WIDTH: 0.419647
G1 X95.114 Y83.289 E.00645
G1 X95.114 Y80.653 E.05181
G1 X84.885 Y80.653 E.20101
G1 X84.886 Y83.288 E.0518
; LINE_WIDTH: 0.403417
G1 X84.869 Y83.616 E.00619
; LINE_WIDTH: 0.354218
G1 X84.853 Y83.944 E.00538
G1 X84.853 Y87.122 E.05207
G1 X84.885 Y87.286 E.00273
G1 X85.181 Y87.286 E.00485
G1 X85.181 Y83.944 E.05475
; LINE_WIDTH: 0.370267
G1 X85.244 Y83.869 E.00169
; LINE_WIDTH: 0.403417
G1 X85.306 Y83.793 E.00185
; WIPE_START
G1 X85.244 Y83.869 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.76 Y82.545 Z3.24 F18000
G1 X94.72 Y82.2 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.719 Y81.047 E.02268
G1 X85.279 Y81.047 E.18567
G1 X85.28 Y83.418 E.04663
G1 X85.345 Y83.353 E.0018
G1 X94.656 Y83.353 E.18314
G1 X94.72 Y83.417 E.00178
G1 X94.72 Y82.26 E.02276
M204 S10000
G1 X94.325 Y82.2 F18000
G1 F1200
M204 S6000
G1 X94.325 Y81.441 E.01492
G1 X85.674 Y81.441 E.17016
G1 X85.674 Y82.959 E.02985
G1 X94.325 Y82.959 E.17016
G1 X94.325 Y82.26 E.01375
M204 S10000
G1 X93.931 Y82.2 F18000
G1 F1200
M204 S6000
G1 X93.931 Y81.835 E.00717
G1 X86.068 Y81.835 E.15465
G1 X86.068 Y82.565 E.01434
G1 X93.931 Y82.565 E.15465
G1 X93.931 Y82.26 E.00599
; WIPE_START
G1 X93.931 Y82.565 E-.05788
G1 X92.236 Y82.565 E-.32212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y82.2 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1200
M204 S6000
G1 X93.507 Y82.2 E.11818
; WIPE_START
G1 X91.507 Y82.2 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.523 Y81.704 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.523 Y80.606 E.02323
G1 X96.122 Y80.606 E.01268
G1 X96.223 Y80.896 E.0065
G1 X96.505 Y81.351 E.01133
G1 X96.656 Y81.51 E.00464
G1 X96.65 Y83.872 E.04998
G1 X96.631 Y84.229 E.00757
G1 X96.66 Y85.537 E.02771
G1 X96.65 Y86.072 E.01131
G1 X96.153 Y86.359 E.01216
G1 X95.874 Y86.814 E.0113
G1 X95.905 Y87.269 E.00966
G1 X96.223 Y88.179 E.02041
G1 X96.505 Y88.635 E.01133
G1 X96.654 Y88.791 E.00458
G1 X96.642 Y93.359 E.09669
G1 X96.153 Y93.642 E.01197
G1 X95.874 Y94.097 E.0113
G1 X95.905 Y94.552 E.00966
G1 X96.223 Y95.462 E.02041
G1 X96.505 Y95.918 E.01133
G1 X96.646 Y96.066 E.00434
G1 X96.654 Y97.763 E.03592
; WIPE_START
G1 X96.646 Y96.066 E-.32241
G1 X96.505 Y95.918 E-.03899
G1 X96.453 Y95.834 E-.0186
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.82 Y96.056 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.370065
G1 F1200
M204 S6000
G1 X94.738 Y96.154 E.0022
; LINE_WIDTH: 0.419766
G1 X94.656 Y96.253 E.00252
G1 X85.345 Y96.253 E.18303
; LINE_WIDTH: 0.403417
G1 X85.263 Y96.154 E.00242
; LINE_WIDTH: 0.353767
G1 X85.181 Y96.056 E.0021
G1 X85.181 Y92.715 E.05468
G1 X84.869 Y92.73 E.00511
G1 X84.853 Y92.878 E.00244
G1 X84.853 Y96.056 E.052
; LINE_WIDTH: 0.370267
G1 X84.869 Y96.384 E.00564
; LINE_WIDTH: 0.419648
G1 X84.886 Y96.712 E.00645
G1 X84.885 Y99.347 E.0518
G1 X95.114 Y99.347 E.20101
G1 X95.114 Y96.711 E.05181
; LINE_WIDTH: 0.40397
G1 X95.13 Y96.412 E.00565
; LINE_WIDTH: 0.354327
G1 X95.147 Y96.056 E.00585
G1 X95.148 Y92.768 E.05389
G1 X95.094 Y92.715 E.00124
G1 X94.82 Y92.715 E.0045
G1 X94.82 Y95.996 E.05378
M204 S10000
G1 X94.72 Y96.593 F18000
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.656 Y96.647 E.00164
G1 X85.345 Y96.647 E.18314
G1 X85.28 Y96.593 E.00166
G1 X85.279 Y98.953 E.04643
G1 X94.719 Y98.953 E.18567
G1 X94.72 Y96.653 E.04523
M204 S10000
G1 X94.325 Y97.041 F18000
G1 F1200
M204 S6000
G1 X85.674 Y97.041 E.17016
G1 X85.674 Y98.559 E.02985
G1 X94.325 Y98.559 E.17016
G1 X94.325 Y97.101 E.02867
M204 S10000
G1 X93.931 Y97.435 F18000
G1 F1200
M204 S6000
G1 X86.068 Y97.435 E.15465
G1 X86.068 Y98.165 E.01434
G1 X93.931 Y98.165 E.15465
G1 X93.931 Y97.495 E.01316
; WIPE_START
G1 X93.931 Y98.165 E-.12713
G1 X92.6 Y98.165 E-.25287
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y97.8 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1200
M204 S6000
G1 X93.507 Y97.8 E.11818
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X91.507 Y97.8 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 24/74
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I.435 J-1.137 P1  F18000
G1 X86.39 Y95.843 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.42 Y85.649 Z3.36 F18000
G1 X82.938 Y80.243 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.066 Y80.243 E.29902
G1 X97.045 Y82.593 E.04972
G1 X97.057 Y83.36 E.01624
G1 X97.041 Y83.774 E.00878
G1 X97.056 Y84.031 E.00544
G1 X97.042 Y84.3 E.00571
G1 X97.071 Y85.172 E.01846
G1 X97.045 Y86.606 E.03035
G1 X97.072 Y90 E.07184
G1 X97.045 Y93.394 E.07184
G1 X97.071 Y94.835 E.03049
M73 P54 R15
G1 X97.042 Y96.244 E.02985
G1 X97.057 Y96.646 E.00852
G1 X97.061 Y99.757 E.06583
G1 X82.938 Y99.757 E.29892
G1 X82.929 Y95.979 E.07996
G1 X82.959 Y95.11 E.01841
G1 X82.939 Y94.547 E.01193
G1 X82.93 Y90.003 E.09617
G1 X82.939 Y85.453 E.09629
G1 X82.959 Y84.89 E.01193
G1 X82.929 Y84.021 E.01841
G1 X82.938 Y80.303 E.07869
M204 S10000
G1 X82.511 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.493 Y79.819 E.31712
G1 X97.492 Y79.962 E.00303
G1 X97.47 Y82.591 E.05564
G1 X97.481 Y83.364 E.01638
G1 X97.466 Y83.77 E.00859
G1 X97.495 Y85.169 E.02961
G1 X97.47 Y86.608 E.03047
G1 X97.497 Y90 E.0718
G1 X97.47 Y93.392 E.0718
G1 X97.496 Y94.835 E.03055
G1 X97.466 Y96.241 E.02976
G1 X97.482 Y96.639 E.00844
G1 X97.474 Y98.82 E.04615
G1 X97.49 Y100.181 E.02881
G1 X82.511 Y100.181 E.31705
G1 X82.505 Y95.973 E.08906
G1 X82.534 Y95.11 E.01827
G1 X82.515 Y94.555 E.01176
G1 X82.506 Y90.002 E.09636
G1 X82.515 Y85.445 E.09644
G1 X82.534 Y84.89 E.01176
G1 X82.505 Y84.027 E.01827
G1 X82.51 Y79.879 E.08779
M204 S250
G1 X82.104 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.898 Y79.41 E.31065
G1 X97.905 Y79.41 E.00013
G1 F1710
G1 X97.902 Y79.966 E.01094
G1 F1500
G1 X97.88 Y82.451 E.04889
G1 X97.879 Y82.627 E.00345
G1 X97.88 Y82.688 E.00121
G1 X97.887 Y83.12 E.00848
G1 X97.887 Y83.47 E.00689
G1 X97.885 Y83.937 E.00919
G1 F1710
G1 X97.891 Y84.029 E.00182
G1 F1920
G1 X97.876 Y84.308 E.0055
G1 F1710
G1 X97.905 Y85.165 E.01687
G1 F1500
G1 X97.897 Y85.622 E.00898
G1 X97.881 Y86.505 E.01737
G1 X97.879 Y86.578 E.00143
G1 X97.88 Y86.763 E.00364
G1 X97.885 Y87.363 E.0118
G1 F1710
G1 X97.89 Y88.042 E.01336
G1 F1920
G1 X97.896 Y88.721 E.01336
G1 F2130
G1 X97.901 Y90.6 E.03696
G1 F1920
G1 X97.896 Y91.279 E.01336
G1 F1710
G1 X97.89 Y91.958 E.01336
G1 F1500
G1 X97.88 Y93.237 E.02516
G1 X97.879 Y93.422 E.00364
G1 X97.881 Y93.495 E.00143
G1 X97.897 Y94.377 E.01735
G1 X97.905 Y94.836 E.00902
G1 F2130
G1 X97.897 Y95.236 E.00787
G1 X97.889 Y95.583 E.00684
G1 X97.881 Y95.983 E.00787
G1 F1500
M73 P54 R14
G1 X97.887 Y96.53 E.01076
G1 X97.884 Y98.685 E.04238
G1 X97.885 Y98.938 E.00498
G1 X97.89 Y99.4 E.00908
G1 X97.896 Y99.887 E.00958
G1 X97.898 Y100.59 E.01383
G1 X82.104 Y100.59 E.31064
G1 X82.098 Y100.59 E.00013
G1 F1710
G1 X82.111 Y99 E.03127
G1 X82.096 Y95.967 E.05966
G1 X82.125 Y95.11 E.01686
G1 F2130
G1 X82.106 Y94.562 E.01079
G1 F1710
G1 X82.098 Y90.601 E.07792
G1 F1920
G1 X82.098 Y89.401 E.0236
G1 F1710
G1 X82.106 Y85.438 E.07794
G1 F2130
G1 X82.125 Y84.89 E.01079
G1 F1710
G1 X82.096 Y84.033 E.01686
G1 X82.111 Y80.999 E.05967
G1 X82.099 Y79.464 E.03021
; WIPE_START
M204 S6000
G1 X84.099 Y79.457 E-.38
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




G1 X83.3 Y80.733
G1 Z2.96
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.296 Y82.43 E.03592
G1 X83.563 Y82.717 E.0083
G1 X83.905 Y83.172 E.01205
G1 X83.959 Y83.627 E.0097
G1 X83.733 Y84.538 E.01985
G1 X83.489 Y84.993 E.01093
G1 X83.311 Y85.205 E.00587
G1 X83.302 Y85.46 E.0054
G1 X83.293 Y89.71 E.08995
G1 X83.563 Y90 E.00838
G1 X83.905 Y90.455 E.01205
G1 X83.959 Y90.91 E.0097
G1 X83.733 Y91.821 E.01985
G1 X83.489 Y92.276 E.01093
G1 X83.298 Y92.504 E.0063
G1 X83.302 Y94.54 E.04308
G1 X83.322 Y95.11 E.01207
G1 X83.292 Y95.985 E.01854
G1 X83.295 Y96.995 E.02137
G1 X83.563 Y97.283 E.00834
G1 X83.905 Y97.738 E.01205
G1 X83.959 Y98.194 E.0097
G1 X83.733 Y99.104 E.01985
G1 X83.578 Y99.394 E.00696
G1 X84.476 Y99.394 E.01901
G1 X84.478 Y92.59 E.144
G1 X84.729 Y92.339 E.00753
G1 X85.194 Y92.339 E.00983
G1 X85.194 Y89.576 E.05847
G1 X85.17 Y89.545 E.00083
G1 X85.116 Y89.09 E.0097
G1 X85.194 Y88.776 E.00684
G1 X85.194 Y87.661 E.02359
G1 X84.729 Y87.661 E.00983
G1 X84.646 Y87.578 E.00249
; WIPE_START
G1 X84.729 Y87.661 E-.02235
G1 X85.194 Y87.661 E-.08828
G1 X85.194 Y88.776 E-.2118
G1 X85.121 Y89.07 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.282 Y91.711 Z3.36 F18000
G1 X95.148 Y92.768 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.35357
G1 F1200
M204 S6000
G1 X95.094 Y92.715 E.00124
G1 X94.82 Y92.715 E.00449
G1 X94.82 Y96.056 E.05464
; LINE_WIDTH: 0.370065
G1 X94.738 Y96.154 E.0022
; LINE_WIDTH: 0.419766
G1 X94.656 Y96.253 E.00252
G1 X85.345 Y96.253 E.18303
; LINE_WIDTH: 0.403417
G1 X85.263 Y96.154 E.00242
; LINE_WIDTH: 0.353767
G1 X85.181 Y96.056 E.0021
G1 X85.181 Y92.715 E.05468
G1 X84.869 Y92.73 E.00511
G1 X84.853 Y92.878 E.00244
G1 X84.853 Y96.056 E.052
; LINE_WIDTH: 0.370267
G1 X84.869 Y96.384 E.00564
; LINE_WIDTH: 0.419648
G1 X84.886 Y96.712 E.00645
G1 X84.885 Y99.347 E.0518
G1 X95.114 Y99.347 E.20101
G1 X95.114 Y96.711 E.05181
; LINE_WIDTH: 0.40397
G1 X95.13 Y96.412 E.00565
; LINE_WIDTH: 0.355105
G1 X95.147 Y96.056 E.00586
G1 X95.148 Y92.828 E.05303
; WIPE_START
G1 X95.148 Y94.828 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.72 Y96.593 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.656 Y96.647 E.00164
G1 X85.345 Y96.647 E.18314
M73 P55 R14
G1 X85.28 Y96.593 E.00166
G1 X85.279 Y98.953 E.04643
G1 X94.719 Y98.953 E.18567
G1 X94.72 Y96.653 E.04523
M204 S10000
G1 X94.325 Y97.041 F18000
G1 F1200
M204 S6000
G1 X85.674 Y97.041 E.17016
G1 X85.674 Y98.559 E.02985
G1 X94.325 Y98.559 E.17016
G1 X94.325 Y97.101 E.02867
M204 S10000
G1 X93.931 Y97.435 F18000
G1 F1200
M204 S6000
G1 X86.068 Y97.435 E.15465
G1 X86.068 Y98.165 E.01434
G1 X93.931 Y98.165 E.15465
G1 X93.931 Y97.495 E.01316
; WIPE_START
G1 X93.931 Y98.165 E-.12713
G1 X92.6 Y98.165 E-.25287
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y97.8 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1200
M204 S6000
G1 X93.507 Y97.8 E.11818
; WIPE_START
G1 X91.507 Y97.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.696 Y97.818 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.682 Y96.121 E.03591
G1 X96.511 Y95.918 E.00562
G1 X96.267 Y95.462 E.01093
G1 X96.041 Y94.552 E.01985
G1 X96.095 Y94.097 E.0097
G1 X96.437 Y93.642 E.01205
G1 X96.684 Y93.208 E.01056
G1 X96.71 Y90 E.0679
G1 X96.7 Y88.861 E.02412
G1 X96.511 Y88.635 E.00624
G1 X96.267 Y88.179 E.01093
G1 X96.041 Y87.269 E.01985
G1 X96.095 Y86.814 E.0097
G1 X96.437 Y86.359 E.01205
G1 X96.695 Y85.905 E.01103
G1 X96.708 Y85.175 E.01546
G1 X96.678 Y84.297 E.0186
G1 X96.692 Y84.031 E.00563
G1 X96.678 Y83.778 E.00538
G1 X96.694 Y83.356 E.00894
G1 X96.691 Y81.567 E.03787
G1 X96.511 Y81.351 E.00594
G1 X96.267 Y80.896 E.01093
G1 X96.195 Y80.606 E.00632
G1 X95.523 Y80.606 E.01423
G1 X95.523 Y81.631 E.02169
M204 S10000
G1 X95.114 Y82.2 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X95.114 Y80.653 E.03043
G1 X84.885 Y80.653 E.20118
G1 X84.886 Y83.288 E.05184
; LINE_WIDTH: 0.403417
G1 X84.869 Y83.616 E.00619
; LINE_WIDTH: 0.354218
G1 X84.853 Y83.944 E.00538
G1 X84.853 Y87.122 E.05207
G1 X84.885 Y87.286 E.00273
G1 X85.181 Y87.286 E.00485
G1 X85.181 Y83.944 E.05475
; LINE_WIDTH: 0.370267
G1 X85.263 Y83.846 E.0022
; LINE_WIDTH: 0.419767
G1 X85.345 Y83.747 E.00252
G1 X94.656 Y83.747 E.18303
; LINE_WIDTH: 0.40335
G1 X94.738 Y83.846 E.00241
; LINE_WIDTH: 0.353861
G1 X94.82 Y83.944 E.0021
G1 X94.82 Y87.285 E.05469
G1 X95.132 Y87.27 E.00512
G1 X95.148 Y87.121 E.00244
G1 X95.147 Y83.944 E.052
; LINE_WIDTH: 0.370065
G1 X95.131 Y83.617 E.00564
; LINE_WIDTH: 0.41597
G1 X95.114 Y83.289 E.00639
G1 X95.114 Y82.26 E.02004
M204 S10000
G1 X94.72 Y82.2 F18000
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.719 Y81.047 E.02268
G1 X85.279 Y81.047 E.18567
G1 X85.28 Y83.418 E.04663
G1 X85.345 Y83.353 E.0018
G1 X94.656 Y83.353 E.18314
G1 X94.72 Y83.417 E.00178
G1 X94.72 Y82.26 E.02276
M204 S10000
G1 X94.325 Y82.2 F18000
G1 F1200
M204 S6000
G1 X94.325 Y81.441 E.01492
G1 X85.674 Y81.441 E.17016
G1 X85.674 Y82.959 E.02985
G1 X94.325 Y82.959 E.17016
G1 X94.325 Y82.26 E.01375
M204 S10000
G1 X93.931 Y82.2 F18000
G1 F1200
M204 S6000
G1 X93.931 Y81.835 E.00717
G1 X86.068 Y81.835 E.15465
G1 X86.068 Y82.565 E.01434
G1 X93.931 Y82.565 E.15465
G1 X93.931 Y82.26 E.00599
; WIPE_START
G1 X93.931 Y82.565 E-.05788
G1 X92.236 Y82.565 E-.32212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y82.2 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1200
M204 S6000
G1 X93.507 Y82.2 E.11818
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X91.507 Y82.2 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/74
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I-1.139 J-.427 P1  F18000
G1 X86.39 Y95.843 Z3.36
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.557 Y95.843 E.01764
G1 X85.557 Y84.157 E.24736
G1 X94.444 Y84.157 E.1881
G1 X94.444 Y95.843 E.24736
G1 X86.45 Y95.843 E.16919
M204 S10000
G1 X86.39 Y95.419 F18000
G1 F1500
M204 S500
G1 X85.981 Y95.419 E.00866
G1 X85.981 Y84.581 E.22941
G1 X94.02 Y84.581 E.17014
G1 X94.02 Y95.419 E.22941
G1 X86.45 Y95.419 E.16021
M204 S250
G1 X86.39 Y95.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.39 Y84.99 E.19708
G1 X93.61 Y84.99 E.14201
G1 X93.61 Y95.01 E.19708
G1 X86.45 Y95.01 E.14083
; WIPE_START
M204 S6000
G1 X86.438 Y93.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.395 Y85.656 Z3.48 F18000
G1 X82.892 Y80.243 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.105 Y80.243 E.30084
G1 X97.09 Y81.258 E.02147
G1 X97.102 Y83.237 E.04189
G1 X97.082 Y83.781 E.01153
G1 X97.113 Y85.051 E.0269
G1 X97.086 Y86.684 E.03455
G1 X97.118 Y89.999 E.07019
G1 X97.086 Y93.316 E.07021
G1 X97.113 Y94.949 E.03455
G1 X97.082 Y96.219 E.0269
G1 X97.102 Y96.763 E.01153
G1 X97.09 Y98.742 E.04188
G1 X97.104 Y99.757 E.02148
G1 X82.892 Y99.757 E.30081
G1 X82.887 Y95.863 E.08242
G1 X82.911 Y95.172 E.01462
G1 X82.893 Y94.573 E.01268
G1 X82.882 Y90.001 E.09678
G1 X82.893 Y85.427 E.09681
G1 X82.911 Y84.828 E.01268
G1 X82.887 Y84.137 E.01462
G1 X82.892 Y80.303 E.08115
M204 S10000
G1 X82.464 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.536 Y79.819 E.31901
G1 X97.514 Y81.259 E.03048
G1 X97.526 Y83.243 E.04199
G1 X97.506 Y83.784 E.01145
G1 X97.538 Y85.05 E.0268
G1 X97.51 Y86.685 E.03462
G1 X97.542 Y89.999 E.07016
G1 X97.51 Y93.315 E.07018
G1 X97.538 Y94.95 E.03462
G1 X97.506 Y96.216 E.0268
G1 X97.526 Y96.757 E.01145
G1 X97.514 Y98.74 E.04198
G1 X97.534 Y100.181 E.03049
G1 X82.464 Y100.181 E.31897
G1 X82.463 Y95.856 E.09153
G1 X82.486 Y95.171 E.01451
G1 X82.469 Y94.58 E.01252
G1 X82.458 Y90.001 E.09693
G1 X82.469 Y85.42 E.09696
G1 X82.486 Y84.829 E.01252
G1 X82.463 Y84.144 E.01451
G1 X82.464 Y79.879 E.09026
M204 S250
G1 X82.057 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.946 Y79.41 E.31252
G1 X97.95 Y79.41 E.00009
G1 F1710
G1 X97.95 Y79.52 E.00216
G1 F1500
G1 X97.925 Y81.168 E.03243
G1 X97.924 Y81.367 E.0039
G1 X97.932 Y83.352 E.03905
G1 X97.915 Y83.786 E.00855
G1 X97.925 Y84.16 E.00735
G1 F1920
G1 X97.947 Y85.048 E.01748
G1 F1500
G1 X97.945 Y85.146 E.00193
G1 X97.921 Y86.584 E.02829
G1 X97.92 Y86.651 E.00132
G1 X97.92 Y86.801 E.00294
G1 X97.926 Y87.401 E.0118
G1 F1710
G1 X97.933 Y88.067 E.01311
G1 F1920
M73 P56 R14
G1 X97.939 Y88.733 E.01311
G1 F2130
G1 X97.946 Y90.6 E.03671
G1 F1920
G1 X97.939 Y91.266 E.01311
G1 F1710
G1 X97.933 Y91.933 E.01311
G1 F1500
G1 X97.92 Y93.199 E.02491
G1 X97.92 Y93.349 E.00294
G1 X97.921 Y93.416 E.00132
G1 X97.945 Y94.854 E.02829
G1 X97.947 Y94.952 E.00193
G1 F1920
G1 X97.925 Y95.84 E.01748
G1 F1500
G1 X97.915 Y96.214 E.00735
G1 X97.932 Y96.648 E.00855
G1 X97.924 Y98.665 E.03968
G1 X97.925 Y98.809 E.00283
G1 F1710
G1 X97.936 Y99.649 E.01653
G1 F1500
G1 X97.944 Y100.247 E.01176
G1 X97.946 Y100.59 E.00674
G1 X82.057 Y100.59 E.31252
G1 X82.051 Y100.59 E.00012
G1 F1710
G1 X82.065 Y99 E.03127
G1 X82.056 Y96.45 E.05016
G1 F1500
G1 X82.054 Y95.85 E.0118
G1 F1710
G1 X82.077 Y95.171 E.01337
G1 F1920
G1 X82.059 Y94.586 E.0115
G1 X82.049 Y90.001 E.0902
G1 X82.059 Y85.414 E.09023
G1 X82.077 Y84.829 E.0115
G1 F1710
G1 X82.054 Y84.15 E.01337
G1 F1500
G1 X82.056 Y83.55 E.0118
G1 F1710
G1 X82.065 Y80.999 E.05017
G1 X82.051 Y79.464 E.0302
; WIPE_START
M204 S6000
G1 X84.051 Y79.457 E-.38
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




G1 X83.254 Y80.868
G1 Z3.08
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.252 Y82.565 E.03592
G1 X83.726 Y83.172 E.01631
G1 X83.84 Y83.627 E.00993
G1 X83.814 Y84.083 E.00965
G1 X83.698 Y84.538 E.00994
G1 X83.49 Y84.993 E.01059
G1 X83.259 Y85.308 E.00826
G1 X83.256 Y85.433 E.00265
G1 X83.246 Y89.839 E.09326
G1 X83.726 Y90.455 E.01655
G1 X83.84 Y90.91 E.00993
G1 X83.814 Y91.366 E.00965
G1 X83.698 Y91.821 E.00994
G1 X83.49 Y92.276 E.01059
G1 X83.251 Y92.602 E.00856
G1 X83.256 Y94.567 E.0416
G1 X83.274 Y95.173 E.01283
G1 X83.25 Y95.869 E.01473
G1 X83.252 Y97.13 E.0267
G1 X83.726 Y97.738 E.01633
G1 X83.84 Y98.194 E.00993
G1 X83.814 Y98.649 E.00965
G1 X83.698 Y99.104 E.00994
G1 X83.566 Y99.394 E.00674
G1 X84.476 Y99.394 E.01926
G1 X84.476 Y98.607 E.01665
; WIPE_START
G1 X84.476 Y99.394 E-.1495
G1 X83.566 Y99.394 E-.17293
G1 X83.692 Y99.118 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.367 Y95.418 Z3.48 F18000
G1 X95.148 Y92.768 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.35357
G1 F1200
M204 S6000
G1 X95.094 Y92.715 E.00124
G1 X94.82 Y92.715 E.00449
G1 X94.82 Y96.056 E.05464
; LINE_WIDTH: 0.370065
G1 X94.738 Y96.154 E.0022
; LINE_WIDTH: 0.419766
G1 X94.656 Y96.253 E.00252
G1 X85.345 Y96.253 E.18303
; LINE_WIDTH: 0.403417
G1 X85.263 Y96.154 E.00242
; LINE_WIDTH: 0.353767
G1 X85.181 Y96.056 E.0021
G1 X85.181 Y92.715 E.05468
G1 X84.869 Y92.73 E.00511
G1 X84.853 Y92.878 E.00244
G1 X84.853 Y96.056 E.052
; LINE_WIDTH: 0.370267
G1 X84.869 Y96.384 E.00564
; LINE_WIDTH: 0.419648
G1 X84.886 Y96.712 E.00645
G1 X84.885 Y99.347 E.0518
G1 X95.114 Y99.347 E.20101
G1 X95.114 Y96.711 E.05181
; LINE_WIDTH: 0.40397
G1 X95.13 Y96.412 E.00565
; LINE_WIDTH: 0.355105
G1 X95.147 Y96.056 E.00586
G1 X95.148 Y92.828 E.05303
; WIPE_START
G1 X95.148 Y94.828 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.72 Y96.593 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.656 Y96.647 E.00164
G1 X85.345 Y96.647 E.18314
G1 X85.28 Y96.593 E.00166
G1 X85.279 Y98.953 E.04643
G1 X94.719 Y98.953 E.18567
G1 X94.72 Y96.653 E.04523
M204 S10000
G1 X94.325 Y97.041 F18000
G1 F1200
M204 S6000
G1 X85.674 Y97.041 E.17016
G1 X85.674 Y98.559 E.02985
G1 X94.325 Y98.559 E.17016
G1 X94.325 Y97.101 E.02867
M204 S10000
G1 X93.931 Y97.435 F18000
G1 F1200
M204 S6000
G1 X86.068 Y97.435 E.15465
G1 X86.068 Y98.165 E.01434
G1 X93.931 Y98.165 E.15465
G1 X93.931 Y97.495 E.01316
; WIPE_START
G1 X93.931 Y98.165 E-.12713
G1 X92.6 Y98.165 E-.25287
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y97.8 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1200
M204 S6000
G1 X93.507 Y97.8 E.11818
; WIPE_START
G1 X91.507 Y97.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.732 Y97.899 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.739 Y96.769 E.02392
G1 X96.719 Y96.203 E.01199
G1 X96.51 Y95.918 E.00749
G1 X96.302 Y95.462 E.01059
G1 X96.186 Y95.007 E.00994
G1 X96.16 Y94.552 E.00965
G1 X96.274 Y94.097 E.00993
G1 X96.641 Y93.642 E.01237
G1 X96.724 Y93.399 E.00543
G1 X96.755 Y89.999 E.07196
G1 X96.745 Y88.955 E.02211
G1 X96.51 Y88.635 E.00841
G1 X96.302 Y88.179 E.01059
G1 X96.186 Y87.724 E.00994
G1 X96.16 Y87.269 E.00965
G1 X96.274 Y86.814 E.00993
G1 X96.641 Y86.359 E.01237
G1 X96.733 Y86.091 E.00598
G1 X96.75 Y85.053 E.02198
G1 X96.718 Y83.779 E.02698
G1 X96.739 Y83.231 E.0116
G1 X96.73 Y81.651 E.03343
G1 X96.51 Y81.351 E.00787
G1 X96.302 Y80.896 E.01059
G1 X96.228 Y80.606 E.00633
G1 X95.523 Y80.606 E.01493
G1 X95.523 Y81.598 E.02099
M204 S10000
G1 X95.114 Y82.2 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X95.114 Y80.653 E.03043
G1 X84.885 Y80.653 E.20118
G1 X84.886 Y83.288 E.05184
; LINE_WIDTH: 0.403417
G1 X84.869 Y83.616 E.00619
; LINE_WIDTH: 0.354218
G1 X84.853 Y83.944 E.00538
G1 X84.853 Y87.122 E.05207
G1 X84.885 Y87.286 E.00273
G1 X85.181 Y87.286 E.00485
G1 X85.181 Y83.944 E.05475
; LINE_WIDTH: 0.370267
G1 X85.263 Y83.846 E.0022
; LINE_WIDTH: 0.419767
G1 X85.345 Y83.747 E.00252
G1 X94.656 Y83.747 E.18303
; LINE_WIDTH: 0.40335
G1 X94.738 Y83.846 E.00241
; LINE_WIDTH: 0.353861
G1 X94.82 Y83.944 E.0021
G1 X94.82 Y87.285 E.05469
G1 X95.132 Y87.27 E.00512
G1 X95.148 Y87.121 E.00244
G1 X95.147 Y83.944 E.052
; LINE_WIDTH: 0.370065
G1 X95.131 Y83.617 E.00564
; LINE_WIDTH: 0.41597
G1 X95.114 Y83.289 E.00639
G1 X95.114 Y82.26 E.02004
M204 S10000
G1 X94.72 Y82.2 F18000
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X94.719 Y81.047 E.02268
G1 X85.279 Y81.047 E.18567
G1 X85.28 Y83.418 E.04663
G1 X85.345 Y83.353 E.0018
G1 X94.656 Y83.353 E.18314
G1 X94.72 Y83.417 E.00178
G1 X94.72 Y82.26 E.02276
M204 S10000
G1 X94.325 Y82.2 F18000
G1 F1200
M204 S6000
G1 X94.325 Y81.441 E.01492
G1 X85.674 Y81.441 E.17016
G1 X85.674 Y82.959 E.02985
G1 X94.325 Y82.959 E.17016
G1 X94.325 Y82.26 E.01375
M204 S10000
G1 X93.931 Y82.2 F18000
G1 F1200
M204 S6000
G1 X93.931 Y81.835 E.00717
G1 X86.068 Y81.835 E.15465
G1 X86.068 Y82.565 E.01434
G1 X93.931 Y82.565 E.15465
G1 X93.931 Y82.26 E.00599
; WIPE_START
G1 X93.931 Y82.565 E-.05788
G1 X92.236 Y82.565 E-.32212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y82.2 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1200
M204 S6000
G1 X93.507 Y82.2 E.11818
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X91.507 Y82.2 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/74
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I-1.135 J-.44 P1  F18000
G1 X86.544 Y95.01 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.544 Y94.969 E.00081
G1 F1560
G1 X86.544 Y85.031 E.19547
G1 F1500
G1 X86.544 Y84.99 E.00081
G1 X89.394 Y84.99 E.05606
G1 X89.398 Y84.868 E.00241
G1 X89.825 Y84.868 E.00838
G1 X90.078 Y84.99 E.00553
G1 X93.455 Y84.99 E.06643
G1 X93.455 Y85.031 E.00081
G1 F1560
G1 X93.457 Y94.969 E.19547
G1 F1500
G1 X93.457 Y95.01 E.00081
G1 X90.078 Y95.01 E.06646
G1 X89.825 Y95.132 E.00553
G1 X89.398 Y95.132 E.00838
G1 X89.394 Y95.01 E.00241
G1 X86.604 Y95.01 E.05488
; WIPE_START
M204 S6000
G1 X86.544 Y94.969 E-.01381
G1 X86.544 Y93.042 E-.36619
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.423 Y85.71 Z3.6 F18000
G1 X82.841 Y80.243 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P57 R14
G1 F1500
M204 S500
G1 X85.99 Y80.243 E.06665
G1 X86.043 Y80.621 E.00808
G1 X86.043 Y83.861 E.06857
G1 X85.997 Y84.157 E.00633
G1 X85.71 Y84.157 E.00607
G1 X85.71 Y86.003 E.03907
G1 X85.522 Y87.216 E.02598
G1 X85.71 Y87.216 E.00399
G1 X85.71 Y92.784 E.11787
G1 X85.522 Y92.784 E.00399
G1 X85.71 Y93.997 E.02598
G1 X85.71 Y95.843 E.03907
G1 X85.997 Y95.843 E.00607
G1 X86.043 Y96.139 E.00633
G1 X86.043 Y99.379 E.06858
G1 X85.99 Y99.757 E.00807
G1 X82.841 Y99.757 E.06665
G1 X82.845 Y95.749 E.08483
G1 X82.863 Y95.235 E.01088
G1 X82.847 Y94.6 E.01345
G1 X82.84 Y90.444 E.08795
G1 X82.847 Y85.4 E.10676
G1 X82.863 Y84.765 E.01344
G1 X82.845 Y84.251 E.01088
G1 X82.841 Y80.303 E.08356
M204 S10000
G1 X82.416 Y79.819 F18000
G1 F1500
M204 S500
G1 X86.359 Y79.819 E.08345
G1 X86.467 Y80.592 E.01651
G1 X86.467 Y83.894 E.06988
G1 X86.36 Y84.581 E.01472
G1 X86.135 Y84.581 E.00478
G1 X86.135 Y86.035 E.03079
G1 X86.017 Y86.791 E.01619
G1 X86.135 Y86.791 E.00248
G1 X86.135 Y93.209 E.13583
G1 X86.017 Y93.209 E.00248
G1 X86.135 Y93.965 E.01619
G1 X86.135 Y95.419 E.03079
G1 X86.36 Y95.419 E.00478
G1 X86.467 Y96.106 E.01472
G1 X86.467 Y99.408 E.06989
G1 X86.36 Y100.181 E.0165
G1 X82.416 Y100.181 E.08346
G1 X82.421 Y95.741 E.09397
G1 X82.438 Y95.233 E.01077
G1 X82.422 Y94.605 E.01329
G1 X82.416 Y90.443 E.08808
G1 X82.422 Y85.395 E.10686
G1 X82.438 Y84.767 E.01329
G1 X82.421 Y84.259 E.01077
G1 X82.416 Y79.879 E.0927
; WIPE_START
M204 S6000
G1 X84.416 Y79.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.023 Y80.476 Z3.6 F18000
G1 X93.958 Y80.635 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.019 Y80.243 E.00839
G1 X97.146 Y80.243 E.0662
G1 X97.13 Y81.332 E.02304
G1 X97.126 Y82.451 E.02368
G1 X97.147 Y83.131 E.01439
G1 X97.121 Y83.807 E.01432
G1 X97.155 Y84.944 E.02407
G1 X97.147 Y86.367 E.03013
G1 X97.126 Y86.739 E.00788
G1 X97.162 Y90 E.06902
G1 X97.126 Y93.261 E.06903
G1 X97.147 Y93.633 E.00788
G1 X97.155 Y95.056 E.03013
G1 X97.121 Y96.193 E.02407
G1 X97.147 Y96.869 E.01432
G1 X97.126 Y97.549 E.01439
G1 X97.146 Y99.757 E.04672
G1 X94.019 Y99.757 E.0662
G1 X93.958 Y99.365 E.00838
G1 X93.958 Y96.16 E.06783
G1 X94.015 Y95.843 E.00681
G1 X94.29 Y95.843 E.00584
G1 X94.29 Y94.308 E.03251
G1 X94.563 Y92.784 E.03275
G1 X94.29 Y92.784 E.00579
G1 X94.289 Y87.216 E.11787
G1 X94.563 Y87.216 E.00581
G1 X94.289 Y85.684 E.03293
G1 X94.288 Y84.157 E.03233
G1 X94.015 Y84.157 E.0058
G1 X93.958 Y83.84 E.00681
G1 X93.958 Y80.695 E.06656
M204 S10000
G1 X93.534 Y80.602 F18000
G1 F1500
M204 S500
G1 X93.655 Y79.819 E.01677
G1 X97.577 Y79.819 E.08301
G1 X97.555 Y81.336 E.0321
G1 X97.551 Y82.445 E.02348
G1 X97.571 Y83.132 E.01455
G1 X97.545 Y83.808 E.01432
G1 X97.58 Y84.938 E.02393
G1 X97.571 Y86.381 E.03053
G1 X97.551 Y86.749 E.0078
G1 X97.586 Y90 E.06881
G1 X97.551 Y93.251 E.06882
G1 X97.571 Y93.619 E.0078
G1 X97.58 Y95.062 E.03053
G1 X97.545 Y96.192 E.02393
G1 X97.571 Y96.868 E.01432
G1 X97.551 Y97.555 E.01455
G1 X97.577 Y100.181 E.05558
G1 X93.655 Y100.181 E.08301
G1 X93.534 Y99.398 E.01677
G1 X93.534 Y96.122 E.06933
G1 X93.66 Y95.419 E.01512
G1 X93.866 Y95.419 E.00437
G1 X93.866 Y94.27 E.02433
G1 X94.056 Y93.209 E.02282
G1 X93.866 Y93.209 E.00403
G1 X93.865 Y86.791 E.13583
G1 X94.056 Y86.791 E.00406
G1 X93.865 Y85.722 E.02299
G1 X93.864 Y84.581 E.02415
G1 X93.66 Y84.581 E.00433
G1 X93.534 Y83.878 E.01512
G1 X93.534 Y80.662 E.06806
; WIPE_START
M204 S6000
G1 X93.655 Y79.819 E-.16182
G1 X94.803 Y79.819 E-.21818
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.175 Y79.575 Z3.6 F18000
G1 X82.01 Y79.41 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.354 Y79.41 E.14445
G1 X89.356 Y79.48 E.00139
G1 X89.679 Y79.48 E.00635
G1 X90.105 Y79.41 E.0085
G1 X97.991 Y79.41 E.15512
G1 X97.965 Y81.278 E.03675
G1 X97.961 Y82.461 E.02326
G1 X97.964 Y82.586 E.00247
G1 X97.977 Y83.006 E.00827
G1 X97.977 Y83.234 E.00447
G1 X97.955 Y83.81 E.01134
G1 X97.969 Y84.285 E.00934
G1 F1710
G1 X97.989 Y84.933 E.01276
G1 F1500
G1 X97.988 Y85.108 E.00344
G1 X97.984 Y85.828 E.01417
G1 X97.981 Y86.393 E.01111
G1 F1710
G1 X97.961 Y86.746 E.00695
G1 F1500
G1 X97.961 Y86.856 E.00216
M73 P57 R13
G1 X97.968 Y87.456 E.0118
G1 F1710
G1 X97.982 Y88.752 E.02549
G1 F1920
G1 X97.989 Y90.6 E.03635
G1 F1710
G1 X97.975 Y91.896 E.0255
G1 F1500
G1 X97.961 Y93.144 E.02455
G1 X97.961 Y93.254 E.00216
G1 F1710
G1 X97.981 Y93.607 E.00695
G1 F1500
G1 X97.984 Y94.172 E.01111
G1 X97.988 Y94.892 E.01417
G1 X97.989 Y95.067 E.00344
G1 F1710
G1 X97.969 Y95.715 E.01276
G1 F1500
G1 X97.955 Y96.19 E.00934
G1 X97.977 Y96.766 E.01134
G1 X97.977 Y96.994 E.00447
G1 X97.964 Y97.414 E.00827
G1 X97.961 Y97.539 E.00247
G1 X97.965 Y98.722 E.02326
G1 X97.99 Y100.59 E.03675
G1 X90.105 Y100.59 E.15509
G1 X89.679 Y100.52 E.0085
G1 X89.356 Y100.52 E.00635
G1 X89.354 Y100.59 E.00139
G1 X82.01 Y100.59 E.14445
G1 X82.007 Y100.59 E.00006
G1 F1710
G1 X82.007 Y99.99 E.0118
G1 F1500
G1 X82.012 Y95.734 E.08371
G1 F1710
G1 X82.029 Y95.231 E.0099
G1 F1920
G1 X82.013 Y94.611 E.01221
G1 X82.008 Y91.043 E.07018
G1 F1710
G1 X82.007 Y90.443 E.0118
G1 F1500
G1 X82.008 Y89.843 E.0118
G1 F1710
G1 X82.01 Y87.916 E.0379
G1 F1920
G1 X82.029 Y84.769 E.0619
G1 F1710
G1 X82.012 Y84.266 E.0099
G1 F1500
G1 X82.011 Y83.666 E.0118
G1 F1710
G1 X82.007 Y79.467 E.08259
; WIPE_START
M204 S6000
G1 X84.007 Y79.451 E-.38
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




G1 X83.205 Y81.034
G1 Z3.2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.207 Y82.731 E.03592
G1 X83.575 Y83.172 E.01216
G1 X83.735 Y83.627 E.01021
G1 X83.751 Y84.083 E.00964
G1 X83.67 Y84.538 E.00978
G1 X83.498 Y84.993 E.0103
G1 X83.209 Y85.446 E.01137
G1 X83.204 Y90.011 E.09662
G1 X83.575 Y90.455 E.01225
G1 X83.735 Y90.91 E.01021
G1 X83.751 Y91.366 E.00964
G1 X83.67 Y91.821 E.00978
G1 X83.498 Y92.276 E.0103
G1 X83.207 Y92.734 E.01149
G1 X83.226 Y95.236 E.05296
G1 X83.208 Y95.755 E.01099
G1 X83.207 Y97.298 E.03265
G1 X83.575 Y97.738 E.01216
G1 X83.735 Y98.194 E.01021
G1 X83.751 Y98.649 E.00964
G1 X83.67 Y99.104 E.00978
G1 X83.561 Y99.394 E.00655
G1 X84.359 Y99.394 E.01689
G1 X84.349 Y99.37 E.00053
G1 X84.476 Y99.244 E.0038
G1 X84.478 Y92.59 E.14082
G1 X84.729 Y92.339 E.00753
G1 X85.347 Y92.339 E.01308
G1 X85.347 Y89.109 E.06835
G1 X85.325 Y88.635 E.01006
G1 X85.347 Y88.505 E.00277
G1 X85.347 Y87.661 E.01787
G1 X84.729 Y87.661 E.01308
G1 X84.563 Y87.495 E.00497
; WIPE_START
G1 X84.729 Y87.661 E-.04459
G1 X85.347 Y87.661 E-.11744
G1 X85.347 Y88.505 E-.1604
G1 X85.325 Y88.635 E-.02489
G1 X85.333 Y88.806 E-.03268
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.614 Y81.179 Z3.6 F18000
G1 X85.634 Y80.653 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.423851
G1 F1200
M204 S6000
G1 X84.869 Y80.653 E.01519
G1 X84.885 Y81.027 E.00744
G1 X84.892 Y85.955 E.09788
; LINE_WIDTH: 0.407342
G1 X84.869 Y86.546 E.01125
; LINE_WIDTH: 0.35073
G1 X84.846 Y87.136 E.00958
G1 X84.864 Y87.275 E.00227
G1 X85.137 Y87.293 E.00443
G1 X85.158 Y87.16 E.00217
; LINE_WIDTH: 0.361702
G1 X85.226 Y86.573 E.00991
; LINE_WIDTH: 0.422397
G1 X85.296 Y85.955 E.01231
G1 X85.296 Y83.944 E.03979
G1 X85.416 Y83.765 E.00427
G1 X85.634 Y83.747 E.00432
G1 X85.634 Y80.713 E.06005
; WIPE_START
G1 X85.634 Y82.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.26 Y83.426 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.379502
G1 F1200
M204 S6000
G1 X85.259 Y81.087 E.04128
; WIPE_START
G1 X85.26 Y83.087 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.828 Y84.077 Z3.6 F18000
G1 X93.346 Y84.145 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X92.718 Y84.773 E.01747
G1 X92.16 Y84.773
G1 X93.302 Y83.632 E.03175
G1 X93.302 Y83.074
M73 P58 R13
G1 X91.603 Y84.773 E.04726
G1 X91.045 Y84.773
G1 X93.302 Y82.517 E.06277
G1 X93.302 Y81.959
G1 X90.488 Y84.773 E.07828
G1 X89.994 Y84.709
G1 X93.302 Y81.402 E.092
G1 X93.302 Y80.844
G1 X89.495 Y84.651 E.10589
G1 X88.815 Y84.773
G1 X93.356 Y80.232 E.12632
G1 X93.404 Y79.627
G1 X88.258 Y84.773 E.14315
G1 X87.7 Y84.773
G1 X92.846 Y79.627 E.14315
G1 X92.289 Y79.627
G1 X87.142 Y84.773 E.14315
G1 X86.585 Y84.773
G1 X91.731 Y79.627 E.14315
G1 X91.174 Y79.627
G1 X86.664 Y84.137 E.12544
G1 X86.699 Y83.544
G1 X90.616 Y79.627 E.10896
G1 X90.046 Y79.639
G1 X86.699 Y82.987 E.0931
G1 X86.699 Y82.429
G1 X89.431 Y79.697 E.07599
G1 X88.944 Y79.627
G1 X86.699 Y81.871 E.06244
G1 X86.699 Y81.314
G1 X88.386 Y79.627 E.04693
G1 X87.828 Y79.627
G1 X86.699 Y80.756 E.03142
G1 X86.653 Y80.245
G1 X87.271 Y79.627 E.0172
; WIPE_START
M204 S6000
G1 X86.653 Y80.245 E-.16611
G1 X86.699 Y80.756 E-.09755
G1 X87.132 Y80.323 E-.11634
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.758 Y80.637 Z3.6 F18000
G1 X95.13 Y80.653 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.425524
G1 F1200
M204 S6000
G1 X94.369 Y80.653 E.01517
G1 X94.367 Y83.747 E.06172
G1 X94.583 Y83.766 E.00433
G1 X94.703 Y83.944 E.00429
G1 X94.704 Y85.647 E.03396
G1 X94.99 Y87.247 E.03241
G1 X95.109 Y87.232 E.00239
G1 X95.114 Y80.71 E.13007
; WIPE_START
G1 X95.112 Y82.71 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.741 Y83.427 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.378262
G1 F1200
M204 S6000
G1 X94.74 Y81.086 E.04117
M204 S10000
G1 X95.523 Y81.61 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.523 Y80.756 E.01808
G1 X95.65 Y80.629 E.0038
G1 X95.64 Y80.606 E.00053
G1 X96.279 Y80.606 E.01351
G1 X96.33 Y80.896 E.00623
G1 X96.502 Y81.351 E.0103
G1 X96.766 Y81.766 E.0104
G1 X96.784 Y83.129 E.02886
G1 X96.758 Y83.806 E.01433
G1 X96.792 Y84.948 E.0242
G1 X96.783 Y86.386 E.03042
G1 X96.425 Y86.814 E.01181
G1 X96.265 Y87.269 E.01021
G1 X96.249 Y87.724 E.00964
G1 X96.33 Y88.179 E.00978
G1 X96.502 Y88.635 E.0103
G1 X96.789 Y89.085 E.01131
G1 X96.799 Y90 E.01936
G1 X96.763 Y93.269 E.06921
G1 X96.785 Y93.667 E.00842
G1 X96.425 Y94.097 E.01187
G1 X96.265 Y94.552 E.01021
G1 X96.249 Y95.007 E.00964
G1 X96.33 Y95.462 E.00978
G1 X96.502 Y95.918 E.0103
G1 X96.763 Y96.327 E.01028
G1 X96.784 Y96.871 E.01152
G1 X96.768 Y98.023 E.0244
; WIPE_START
G1 X96.784 Y96.871 E-.21901
G1 X96.763 Y96.327 E-.10338
G1 X96.6 Y96.072 E-.05761
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.13 Y99.347 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.425111
G1 F1200
M204 S6000
G1 X95.114 Y98.974 E.00744
G1 X95.11 Y92.762 E.12377
G1 X94.99 Y92.753 E.00239
G1 X94.705 Y94.344 E.03221
G1 X94.705 Y96.056 E.0341
G1 X94.585 Y96.235 E.0043
G1 X94.367 Y96.253 E.00435
G1 X94.367 Y99.334 E.06138
G1 X95.07 Y99.347 E.01401
; WIPE_START
G1 X94.367 Y99.334 E-.13359
G1 X94.367 Y98.037 E-.24641
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.741 Y96.574 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.378262
G1 F1200
M204 S6000
G1 X94.74 Y98.914 E.04115
; WIPE_START
G1 X94.741 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.353 Y99.749 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X92.729 Y100.373 E.01737
G1 X92.171 Y100.373
G1 X93.302 Y99.243 E.03144
G1 X93.302 Y98.685
G1 X91.614 Y100.373 E.04695
G1 X91.056 Y100.373
G1 X93.302 Y98.128 E.06246
G1 X93.302 Y97.57
G1 X90.499 Y100.373 E.07797
G1 X89.967 Y100.347
G1 X93.302 Y97.013 E.09276
G1 X93.302 Y96.455
G1 X89.454 Y100.303 E.10703
G1 X88.826 Y100.373
G1 X93.346 Y95.853 E.12573
G1 X93.415 Y95.227
G1 X88.269 Y100.373 E.14315
G1 X87.711 Y100.373
G1 X92.857 Y95.227 E.14315
G1 X92.3 Y95.227
G1 X87.154 Y100.373 E.14315
G1 X86.596 Y100.373
G1 X91.742 Y95.227 E.14315
G1 X91.185 Y95.227
G1 X86.652 Y99.759 E.12608
G1 X86.699 Y99.155
G1 X90.627 Y95.227 E.10927
G1 X90.016 Y95.281
G1 X86.699 Y98.598 E.09226
G1 X86.699 Y98.04
G1 X89.39 Y95.349 E.07485
G1 X88.955 Y95.227
G1 X86.699 Y97.483 E.06275
G1 X86.699 Y96.925
G1 X88.397 Y95.227 E.04724
G1 X87.84 Y95.227
G1 X86.699 Y96.367 E.03173
G1 X86.661 Y95.847
G1 X87.282 Y95.227 E.01726
; WIPE_START
M204 S6000
G1 X86.661 Y95.847 E-.16674
G1 X86.699 Y96.367 E-.09907
G1 X87.124 Y95.943 E-.11419
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.634 Y96.253 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.428939
G1 F1200
M204 S6000
G1 X85.416 Y96.235 E.00439
G1 X85.296 Y96.056 E.00434
G1 X85.294 Y94.014 E.04107
; LINE_WIDTH: 0.407342
G1 X85.226 Y93.427 E.01125
; LINE_WIDTH: 0.35073
G1 X85.137 Y92.707 E.01176
G1 X84.864 Y92.725 E.00443
G1 X84.846 Y92.864 E.00227
; LINE_WIDTH: 0.361702
G1 X84.869 Y93.454 E.00991
; LINE_WIDTH: 0.421636
G1 X84.892 Y94.045 E.01167
G1 X84.885 Y99.296 E.10371
G1 X84.869 Y99.347 E.00107
G1 X85.634 Y99.347 E.01511
G1 X85.634 Y96.313 E.05993
; WIPE_START
G1 X85.634 Y98.313 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.259 Y98.973 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.379502
G1 F1200
M204 S6000
G1 X85.26 Y96.634 E.04128
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X85.259 Y98.634 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/74
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I.447 J1.132 P1  F18000
G1 X95.078 Y94.754 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.078 Y92.784 E.04168
G1 X94.327 Y92.784 E.0159
G1 X94.32 Y87.216 E.11787
G1 X95.078 Y87.216 E.01604
G1 X95.077 Y80.243 E.14757
G1 X97.175 Y80.243 E.04442
G1 X97.167 Y82.379 E.0452
G1 X97.191 Y83.017 E.01352
G1 X97.16 Y83.834 E.0173
G1 X97.197 Y84.831 E.02113
G1 X97.192 Y86.369 E.03254
G1 X97.167 Y86.815 E.00946
G1 X97.203 Y90 E.06741
G1 X97.167 Y93.185 E.06742
G1 X97.192 Y93.631 E.00946
G1 X97.197 Y95.169 E.03254
G1 X97.16 Y96.166 E.02113
G1 X97.191 Y96.983 E.0173
G1 X97.167 Y97.621 E.01352
G1 X97.175 Y99.757 E.0452
G1 X95.077 Y99.757 E.04442
G1 X95.078 Y94.814 E.10462
M204 S10000
G1 X94.654 Y94.75 F18000
G1 F1500
M204 S500
G1 X94.654 Y93.209 E.03262
G1 X93.903 Y93.209 E.01588
G1 X93.896 Y86.791 E.13583
G1 X94.654 Y86.791 E.01605
G1 X94.653 Y79.819 E.14757
G1 X97.609 Y79.819 E.06257
G1 X97.6 Y80.056 E.00501
G1 X97.591 Y82.372 E.04902
G1 X97.616 Y83.017 E.01367
G1 X97.585 Y83.834 E.0173
G1 X97.622 Y84.824 E.02098
G1 X97.616 Y86.381 E.03296
G1 X97.591 Y86.825 E.0094
G1 X97.627 Y90 E.0672
G1 X97.591 Y93.175 E.06722
G1 X97.616 Y93.619 E.0094
G1 X97.622 Y95.176 E.03296
G1 X97.585 Y96.166 E.02098
G1 X97.616 Y96.983 E.0173
G1 X97.591 Y97.628 E.01367
G1 X97.608 Y100.181 E.05402
G1 X94.653 Y100.181 E.06255
G1 X94.653 Y94.81 E.11368
; WIPE_START
M204 S6000
G1 X94.654 Y93.209 E-.30419
G1 X94.255 Y93.209 E-.07581
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.496 Y94.739 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X93.484 Y84.99 E.19175
G1 X92.564 Y84.99 E.0181
G1 X92.392 Y83.979 E.02017
G1 X92.392 Y80.513 E.06817
G1 X92.554 Y79.41 E.02193
G1 X98.033 Y79.421 E.10776
G1 X98.01 Y80.064 E.01265
G1 X98.001 Y82.381 E.04558
G1 X98.009 Y82.575 E.00381
G1 X98.022 Y82.918 E.00676
G1 X98.022 Y83.116 E.00388
G1 X97.994 Y83.834 E.01414
G1 X98.015 Y84.388 E.0109
G1 F1710
G1 X98.031 Y84.817 E.00846
G1 F1500
G1 X98.03 Y85.109 E.00574
G1 X98.027 Y85.969 E.01691
G1 X98.026 Y86.394 E.00835
G1 F1710
G1 X98.001 Y86.822 E.00844
G1 F1500
G1 X98.002 Y86.927 E.00207
G1 X98.022 Y88.712 E.0351
G1 X98.022 Y88.735 E.00045
G1 X98.036 Y89.986 E.02462
G1 X98.036 Y90.013 E.00053
G1 X98.022 Y91.265 E.02463
G1 X98.022 Y91.289 E.00046
G1 X98.002 Y93.073 E.03509
G1 X98.001 Y93.178 E.00207
G1 F1710
G1 X98.026 Y93.606 E.00844
G1 F1500
G1 X98.027 Y94.031 E.00835
G1 X98.03 Y94.891 E.01691
G1 X98.031 Y95.183 E.00574
G1 F1710
G1 X98.015 Y95.612 E.00846
G1 F1500
G1 X97.994 Y96.166 E.0109
G1 X98.022 Y96.884 E.01414
G1 X98.022 Y97.082 E.00388
G1 X98.009 Y97.425 E.00676
G1 X98.001 Y97.619 E.00381
G1 X98.01 Y99.936 E.04557
G1 X98.03 Y100.59 E.01287
G1 X92.554 Y100.59 E.1077
G1 X92.392 Y99.487 E.02193
G1 X92.392 Y96.021 E.06817
G1 X92.564 Y95.01 E.02017
G1 X93.456 Y95.01 E.01753
G1 X93.487 Y94.798 E.00422
; WIPE_START
M204 S6000
G1 X93.487 Y92.798 E-.38
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
M73 P59 R13
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




G1 X93.749 Y93.478
G1 Z3.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X94.276 Y93.518 E.00897
M204 S10000
G1 X94.422 Y94.143 F18000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X93.837 Y93.558 E.01627
G1 X93.712 Y93.991
G1 X94.422 Y94.7 E.01974
G1 X94.422 Y95.258
G1 X93.712 Y94.549 E.01972
G1 X93.667 Y95.061
G1 X94.421 Y95.815 E.02098
G1 X94.421 Y96.373
G1 X93.275 Y95.227 E.03188
G1 X92.749 Y95.258
G1 X94.421 Y96.93 E.0465
G1 X94.421 Y97.488
G1 X92.665 Y95.731 E.04886
G1 X92.609 Y96.233
G1 X94.421 Y98.045 E.0504
G1 X94.421 Y98.603
G1 X92.609 Y96.791 E.05039
G1 X92.609 Y97.348
G1 X94.421 Y99.16 E.05039
G1 X94.421 Y99.717
G1 X92.609 Y97.906 E.05039
G1 X92.609 Y98.464
G1 X94.421 Y100.275 E.05039
G1 X93.961 Y100.373
G1 X92.609 Y99.021 E.03761
G1 X92.628 Y99.597
G1 X93.404 Y100.373 E.02159
; WIPE_START
M204 S6000
G1 X92.628 Y99.597 E-.20855
G1 X92.609 Y99.021 E-.10949
G1 X92.84 Y99.252 E-.06196
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.441 Y93.746 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0866815
G1 F1500
M204 S6000
G1 X94.2 Y93.619 E.00083
M204 S10000
G1 X94.441 Y93.771 F18000
; LINE_WIDTH: 0.153156
G1 F1500
M204 S6000
G1 X94.208 Y93.605 E.00182
; WIPE_START
G1 X94.441 Y93.771 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.807 Y98.223 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.804 Y97.615 E.01288
G1 X96.828 Y96.983 E.01339
G1 X96.811 Y96.527 E.00966
G1 X96.487 Y95.918 E.0146
G1 X96.35 Y95.462 E.01006
G1 X96.305 Y95.007 E.00968
G1 X96.359 Y94.552 E.0097
G1 X96.558 Y94.097 E.01051
G1 X96.83 Y93.78 E.00884
G1 X96.804 Y93.193 E.01243
G1 X96.84 Y90 E.06759
G1 X96.832 Y89.288 E.01508
G1 X96.487 Y88.635 E.01563
G1 X96.35 Y88.179 E.01006
G1 X96.305 Y87.724 E.00968
G1 X96.359 Y87.269 E.0097
G1 X96.558 Y86.814 E.01051
G1 X96.821 Y86.507 E.00855
G1 X96.834 Y84.838 E.03534
G1 X96.797 Y83.834 E.02126
G1 X96.828 Y83.017 E.0173
G1 X96.806 Y81.95 E.02259
G1 X96.487 Y81.351 E.01436
G1 X96.35 Y80.896 E.01006
G1 X96.321 Y80.606 E.00617
G1 X95.44 Y80.606 E.01866
G1 X95.44 Y81.422 E.01726
; WIPE_START
G1 X95.44 Y80.606 E-.15495
G1 X96.321 Y80.606 E-.16748
G1 X96.35 Y80.896 E-.05534
G1 X96.354 Y80.907 E-.00223
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.844 Y79.627 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X94.421 Y80.204 E.01604
G1 X94.421 Y80.761
G1 X93.286 Y79.627 E.03155
G1 X92.74 Y79.638
G1 X94.421 Y81.319 E.04676
G1 X94.421 Y81.876
G1 X92.669 Y80.124 E.04875
G1 X92.609 Y80.622
G1 X94.421 Y82.434 E.0504
G1 X94.421 Y82.992
G1 X92.609 Y81.18 E.0504
G1 X92.609 Y81.737
G1 X94.421 Y83.549 E.0504
G1 X94.421 Y84.107
G1 X92.609 Y82.295 E.05041
G1 X92.609 Y82.852
G1 X94.421 Y84.665 E.05041
G1 X94.422 Y85.222
G1 X92.609 Y83.41 E.05041
G1 X92.611 Y83.969
G1 X93.415 Y84.773 E.02236
G1 X93.701 Y85.059
G1 X94.422 Y85.78 E.02004
G1 X94.407 Y86.323
G1 X93.702 Y85.618 E.01961
M204 S10000
G1 X93.841 Y86.529 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X94.28 Y86.484 E.00749
; WIPE_START
G1 X93.841 Y86.529 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.784 Y92.246 Z3.72 F18000
G1 X84.922 Y96.611 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.922 Y99.757 E.06657
G1 X82.802 Y99.757 E.04487
G1 X82.814 Y95.28 E.09474
G1 X82.8 Y94.626 E.01385
G1 X82.8 Y85.374 E.19582
G1 X82.814 Y84.72 E.01385
G1 X82.802 Y80.243 E.09474
G1 X84.922 Y80.243 E.04487
G1 X84.923 Y87.216 E.14757
G1 X85.671 Y87.216 E.01583
G1 X85.671 Y92.784 E.11787
G1 X84.923 Y92.784 E.01583
G1 X84.922 Y96.551 E.07973
M204 S10000
G1 X85.347 Y96.192 F18000
G1 F1500
M204 S500
G1 X85.346 Y100.181 E.08442
G1 X82.376 Y100.181 E.06285
G1 X82.39 Y95.284 E.10364
G1 X82.376 Y94.63 E.01385
G1 X82.376 Y85.37 E.19601
G1 X82.39 Y84.716 E.01385
G1 X82.376 Y79.819 E.10364
G1 X85.346 Y79.819 E.06285
G1 X85.348 Y86.791 E.14757
G1 X86.096 Y86.791 E.01583
G1 X86.096 Y93.209 E.13583
G1 X85.348 Y93.209 E.01583
G1 X85.347 Y96.132 E.06188
; WIPE_START
M204 S6000
G1 X85.346 Y98.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.545 Y95.01 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.452 Y95.01 E.01783
G1 X87.608 Y96.018 E.02007
G1 X87.608 Y99.488 E.06824
G1 X87.455 Y100.59 E.02189
G1 X81.966 Y100.59 E.10796
G1 X81.967 Y100.225 E.00718
G1 X81.974 Y97.565 E.05231
G1 F1710
G1 X81.976 Y96.965 E.0118
G1 F1500
G1 X81.98 Y95.452 E.02976
G1 X81.981 Y95.288 E.00323
G1 F1920
G1 X81.967 Y94.035 E.02465
G1 F1710
G1 X81.967 Y92.591 E.0284
G1 F1500
G1 X81.967 Y90.547 E.0402
G1 X81.967 Y89.453 E.02152
G1 X81.967 Y88.853 E.0118
G1 F1710
G1 X81.967 Y87.409 E.0284
G1 F1920
G1 X81.981 Y84.712 E.05305
G1 F1500
G1 X81.98 Y84.548 E.00323
G1 X81.976 Y83.035 E.02976
G1 F1710
G1 X81.974 Y82.435 E.0118
G1 F1500
G1 X81.967 Y79.775 E.05232
G1 X81.966 Y79.41 E.00717
G1 X87.454 Y79.41 E.10795
G1 X87.608 Y80.512 E.0219
G1 X87.608 Y83.982 E.06824
G1 X87.452 Y84.99 E.02007
G1 X86.545 Y84.99 E.01783
G1 X86.505 Y85.261 E.0054
G1 X86.505 Y94.739 E.18641
G1 X86.536 Y94.951 E.00421
M204 S10000
G1 X86.288 Y94.372 F18000
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X85.585 Y93.669 E.01956
G1 X85.579 Y94.221
G1 X86.318 Y94.96 E.02056
G1 X86.585 Y95.227
G1 X87.391 Y96.033 E.02242
G1 X87.391 Y96.591
G1 X85.579 Y94.779 E.05041
G1 X85.579 Y95.336
G1 X87.391 Y97.148 E.05041
G1 X87.391 Y97.706
G1 X85.579 Y95.893 E.05042
G1 X85.579 Y96.451
G1 X87.391 Y98.263 E.05042
G1 X87.391 Y98.821
G1 X85.579 Y97.008 E.05043
G1 X85.578 Y97.566
G1 X87.391 Y99.379 E.05043
G1 X87.335 Y99.879
G1 X85.578 Y98.123 E.04886
G1 X85.578 Y98.68
G1 X87.267 Y100.369 E.04697
G1 X86.713 Y100.373
G1 X85.578 Y99.238 E.03158
G1 X85.578 Y99.795
G1 X86.156 Y100.373 E.01608
; WIPE_START
M204 S6000
G1 X85.578 Y99.795 E-.15533
G1 X85.578 Y99.238 E-.10591
G1 X86.02 Y99.68 E-.11877
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.559 Y98.693 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.559 Y99.394 E.01483
G1 X83.563 Y99.394 E.02109
G1 X83.65 Y99.104 E.0064
G1 X83.695 Y98.649 E.00968
G1 X83.641 Y98.194 E.0097
G1 X83.442 Y97.738 E.01051
G1 X83.171 Y97.423 E.00881
G1 X83.163 Y92.847 E.09685
G1 X83.263 Y92.731 E.00323
G1 X83.513 Y92.276 E.01099
G1 X83.65 Y91.821 E.01006
G1 X83.695 Y91.366 E.00968
G1 X83.641 Y90.91 E.0097
G1 X83.442 Y90.455 E.01051
G1 X83.163 Y90.13 E.00907
G1 X83.163 Y85.564 E.09665
G1 X83.263 Y85.448 E.00323
G1 X83.513 Y84.993 E.01099
G1 X83.65 Y84.538 E.01006
G1 X83.695 Y84.083 E.00968
G1 X83.641 Y83.627 E.0097
G1 X83.442 Y83.172 E.01051
G1 X83.172 Y82.857 E.00878
G1 X83.167 Y81.16 E.03592
; WIPE_START
G1 X83.172 Y82.857 E-.32243
G1 X83.369 Y83.087 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.596 Y79.627 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X87.374 Y80.405 E.02165
G1 X87.391 Y80.98
G1 X86.038 Y79.627 E.03763
G1 X85.578 Y79.724
G1 X87.391 Y81.537 E.05045
G1 X87.391 Y82.095
G1 X85.578 Y80.281 E.05045
G1 X85.578 Y80.839
G1 X87.391 Y82.652 E.05044
G1 X87.391 Y83.21
G1 X85.578 Y81.397 E.05044
G1 X85.578 Y81.954
G1 X87.391 Y83.767 E.05043
G1 X87.343 Y84.277
G1 X85.578 Y82.512 E.04908
G1 X85.579 Y83.07
G1 X87.268 Y84.759 E.047
G1 X86.724 Y84.773
G1 X85.579 Y83.627 E.03187
G1 X85.579 Y84.185
G1 X86.333 Y84.939 E.02099
G1 X86.288 Y85.452
G1 X85.579 Y84.743 E.01972
G1 X85.579 Y85.3
G1 X86.288 Y86.009 E.01972
G1 X86.163 Y86.442
G1 X85.579 Y85.858 E.01625
M204 S10000
G1 X85.792 Y86.395 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.152628
G1 F1500
M204 S6000
G1 X85.56 Y86.23 E.00181
M204 S10000
G1 X85.8 Y86.381 F18000
; LINE_WIDTH: 0.0863527
G1 F1500
M204 S6000
G1 X85.56 Y86.254 E.00082
M204 S10000
G1 X85.666 Y86.473 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X86.191 Y86.519 E.00894
; WIPE_START
G1 X85.666 Y86.473 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.656 Y93.517 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X85.881 Y93.481 E.00387
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X85.656 Y93.517 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/74
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I1.018 J.667 P1  F18000
G1 X94.346 Y80.243 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.225 Y80.243 E.06093
G1 X97.207 Y82.306 E.04365
G1 X97.236 Y82.904 E.01267
G1 X97.2 Y83.862 E.02028
G1 X97.239 Y84.72 E.0182
G1 X97.237 Y86.37 E.03491
G1 X97.207 Y86.891 E.01106
G1 X97.243 Y89.844 E.06251
G1 X97.207 Y93.109 E.06911
G1 X97.237 Y93.63 E.01105
G1 X97.239 Y95.28 E.03491
G1 X97.2 Y96.138 E.0182
G1 X97.236 Y97.096 E.02028
G1 X97.208 Y97.692 E.01262
G1 X97.216 Y99.757 E.0437
G1 X94.345 Y99.757 E.06076
G1 X94.346 Y94.885 E.10311
G1 X94.369 Y94.736 E.00319
G1 X94.346 Y80.303 E.30547
M204 S10000
G1 X93.922 Y79.819 F18000
G1 F1500
M204 S500
G1 X97.653 Y79.819 E.07898
G1 X97.632 Y82.297 E.05246
G1 X97.661 Y82.902 E.01281
G1 X97.624 Y83.86 E.02029
G1 X97.664 Y84.711 E.01804
G1 X97.661 Y86.382 E.03537
G1 X97.632 Y86.901 E.011
M73 P60 R13
G1 X97.667 Y89.844 E.06231
G1 X97.632 Y93.099 E.0689
G1 X97.661 Y93.618 E.011
G1 X97.664 Y95.289 E.03537
G1 X97.624 Y96.14 E.01804
G1 X97.661 Y97.098 E.02029
G1 X97.632 Y97.701 E.01278
G1 X97.642 Y100.181 E.05248
G1 X93.921 Y100.181 E.07876
G1 X93.922 Y94.853 E.11278
G1 X93.944 Y94.704 E.00318
G1 X93.922 Y79.879 E.31378
M204 S250
G1 X93.512 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.07 Y79.41 E.08966
G1 X98.064 Y79.602 E.00379
G1 X98.062 Y79.807 E.00402
G1 F1920
G1 X98.057 Y80.407 E.0118
G1 F1710
G1 X98.048 Y81.526 E.02202
G1 F1500
G1 X98.042 Y82.126 E.0118
G1 X98.042 Y82.304 E.0035
G1 X98.061 Y82.715 E.00809
G1 X98.067 Y82.822 E.00212
G1 X98.067 Y82.998 E.00345
G1 X98.034 Y83.858 E.01694
G1 X98.062 Y84.466 E.01197
G1 X98.072 Y85.4 E.01837
G1 X98.071 Y86.044 E.01267
G1 X98.07 Y86.394 E.00688
G1 F1710
G1 X98.042 Y86.898 E.00993
G1 F1500
G1 X98.042 Y86.998 E.00197
G1 X98.062 Y88.635 E.03221
G1 X98.066 Y88.987 E.00693
G1 X98.073 Y89.592 E.01189
G1 X98.069 Y90.562 E.01907
G1 X98.066 Y90.787 E.00443
G1 X98.057 Y91.585 E.0157
G1 X98.042 Y92.99 E.02765
G1 X98.042 Y93.102 E.00221
G1 F1710
G1 X98.07 Y93.606 E.00993
G1 F1500
G1 X98.071 Y93.956 E.00688
G1 X98.072 Y94.6 E.01267
G1 X98.062 Y95.534 E.01837
G1 X98.034 Y96.142 E.01197
G1 X98.067 Y97.002 E.01694
G1 X98.067 Y97.178 E.00345
G1 X98.061 Y97.286 E.00212
G1 X98.042 Y97.696 E.00808
G1 X98.051 Y100.112 E.04752
G1 X98.068 Y100.59 E.00941
G1 X93.511 Y100.59 E.08963
G1 X93.512 Y94.821 E.11346
G1 X93.535 Y94.673 E.00295
G1 X93.512 Y79.47 E.29903
; WIPE_START
M204 S6000
G1 X95.512 Y79.444 E-.38
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




G1 X95.142 Y80.643
G1 Z3.44
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.3993
G1 F1200
M204 S6000
G1 X94.747 Y80.643 E.00737
G1 X94.755 Y87.264 E.12338
G1 X95.126 Y87.245 E.00693
G1 X95.123 Y80.831 E.11953
G1 X95.136 Y80.703 E.0024
M204 S10000
G1 X95.523 Y81.532 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.523 Y80.756 E.01642
G1 X95.65 Y80.629 E.0038
G1 X95.64 Y80.606 E.00053
G1 X96.357 Y80.606 E.01517
G1 X96.364 Y80.896 E.00614
G1 X96.467 Y81.351 E.00988
G1 X96.679 Y81.807 E.01063
G1 X96.846 Y82.083 E.00685
G1 X96.873 Y82.906 E.01742
G1 X96.836 Y83.863 E.02028
G1 X96.876 Y84.729 E.01834
G1 X96.866 Y86.505 E.03759
G1 X96.678 Y86.814 E.00766
G1 X96.444 Y87.269 E.01083
G1 X96.353 Y87.724 E.00983
G1 X96.364 Y88.179 E.00964
G1 X96.467 Y88.635 E.00988
G1 X96.679 Y89.09 E.01063
G1 X96.875 Y89.413 E.008
G1 X96.844 Y93.117 E.07842
G1 X96.874 Y93.774 E.01391
G1 X96.678 Y94.097 E.008
G1 X96.444 Y94.552 E.01083
G1 X96.353 Y95.007 E.00983
G1 X96.364 Y95.462 E.00964
G1 X96.467 Y95.918 E.00988
G1 X96.679 Y96.373 E.01063
G1 X96.857 Y96.666 E.00726
G1 X96.873 Y97.094 E.00907
G1 X96.845 Y97.684 E.01249
G1 X96.847 Y98.362 E.01436
; WIPE_START
G1 X96.845 Y97.684 E-.12888
G1 X96.873 Y97.094 E-.11212
G1 X96.857 Y96.666 E-.08143
G1 X96.699 Y96.407 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.142 Y99.356 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.399099
G1 F1200
M204 S6000
G1 X95.122 Y99.168 E.00353
G1 X95.128 Y92.918 E.11641
G1 X95.108 Y92.734 E.00344
G1 X94.761 Y92.734 E.00647
G1 X94.746 Y99.356 E.12334
G1 X95.082 Y99.356 E.00626
; WIPE_START
G1 X94.746 Y99.356 E-.06386
G1 X94.749 Y97.692 E-.31615
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.352 Y95.813 Z3.84 F18000
G1 X85.655 Y95.383 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.66 Y99.757 E.09258
G1 X82.758 Y99.757 E.06142
G1 X82.758 Y80.243 E.41301
G1 X85.654 Y80.243 E.06129
G1 X85.655 Y85.115 E.10312
G1 X85.632 Y85.264 E.00317
G1 X85.634 Y89.238 E.08411
G1 X85.649 Y90 E.01614
G1 X85.634 Y90.762 E.01614
G1 X85.632 Y94.736 E.08411
G1 X85.655 Y94.885 E.00319
G1 X85.655 Y95.323 E.00926
M204 S10000
G1 X86.08 Y95.382 F18000
G1 F1500
M204 S500
G1 X86.085 Y100.181 E.10157
G1 X82.334 Y100.181 E.07939
G1 X82.334 Y79.819 E.43097
G1 X86.078 Y79.819 E.07925
G1 X86.079 Y85.148 E.11278
G1 X86.056 Y85.296 E.00317
G1 X86.059 Y89.234 E.08335
G1 X86.073 Y90 E.01623
G1 X86.059 Y90.767 E.01623
G1 X86.056 Y94.704 E.08335
G1 X86.079 Y94.853 E.00318
G1 X86.08 Y95.322 E.00994
M204 S250
G1 X86.489 Y95.382 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.494 Y100.59 E.10244
G1 X81.925 Y100.59 E.08988
G1 X81.925 Y79.41 E.41659
G1 X86.487 Y79.41 E.08975
G1 X86.487 Y79.429 E.00038
G1 X86.488 Y85.179 E.11308
G1 X86.466 Y85.327 E.00295
G1 X86.468 Y89.23 E.07677
G1 X86.483 Y90 E.01515
G1 X86.468 Y90.77 E.01516
G1 X86.466 Y94.673 E.07677
G1 X86.488 Y94.822 E.00295
G1 X86.489 Y95.322 E.00984
; WIPE_START
M204 S6000
G1 X86.491 Y97.322 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.254 Y94.93 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.399892
G1 F1200
M204 S6000
G1 X85.237 Y94.752 E.00333
G1 X85.238 Y92.734 E.03768
G1 X84.873 Y92.754 E.00684
G1 X84.878 Y99.165 E.11967
G1 X84.859 Y99.355 E.00356
G1 X85.258 Y99.355 E.00744
G1 X85.254 Y94.99 E.08147
; WIPE_START
G1 X85.256 Y96.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.476 Y98.539 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.476 Y99.244 E.01491
G1 X84.349 Y99.37 E.0038
G1 X84.359 Y99.394 E.00053
G1 X83.571 Y99.394 E.01668
G1 X83.636 Y99.104 E.00629
G1 X83.647 Y98.649 E.00964
G1 X83.556 Y98.194 E.00983
G1 X83.323 Y97.738 E.01083
G1 X83.121 Y97.509 E.00646
G1 X83.121 Y92.992 E.09562
G1 X83.322 Y92.731 E.00696
G1 X83.533 Y92.276 E.01063
G1 X83.636 Y91.821 E.00988
G1 X83.647 Y91.366 E.00964
G1 X83.556 Y90.91 E.00983
G1 X83.323 Y90.455 E.01083
G1 X83.121 Y90.226 E.00646
G1 X83.121 Y85.709 E.09562
G1 X83.322 Y85.448 E.00696
G1 X83.533 Y84.993 E.01063
G1 X83.636 Y84.538 E.00988
G1 X83.647 Y84.083 E.00964
G1 X83.556 Y83.627 E.00983
G1 X83.323 Y83.172 E.01083
G1 X83.121 Y82.943 E.00646
M73 P60 R12
G1 X83.121 Y81.246 E.03592
; WIPE_START
G1 X83.121 Y82.943 E-.32243
G1 X83.321 Y83.17 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.253 Y80.832 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.398869
G1 F1200
M204 S6000
G1 X85.253 Y80.644 E.00351
G1 X84.857 Y80.644 E.00737
G1 X84.876 Y80.832 E.00353
G1 X84.873 Y87.246 E.11939
G1 X85.238 Y87.266 E.00682
G1 X85.253 Y80.892 E.11865
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X85.249 Y82.892 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 29/74
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I.31 J1.177 P1  F18000
G1 X94.39 Y80.483 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.018 Y80.483 E.0133
G1 X95.019 Y80.243 E.00508
G1 X97.256 Y80.243 E.04736
G1 X97.248 Y82.233 E.04212
G1 X97.279 Y82.844 E.01295
G1 X97.239 Y83.89 E.02215
G1 X97.28 Y84.611 E.01528
G1 X97.28 Y86.406 E.03799
G1 X97.248 Y86.969 E.01193
G1 X97.28 Y89.184 E.0469
G1 X97.28 Y90.861 E.0355
G1 X97.248 Y93.031 E.04594
G1 X97.28 Y93.594 E.01194
G1 X97.28 Y95.389 E.03799
G1 X97.239 Y96.11 E.01528
G1 X97.279 Y97.156 E.02215
G1 X97.248 Y97.767 E.01295
G1 X97.256 Y99.757 E.04212
G1 X95.019 Y99.757 E.04736
G1 X95.018 Y99.517 E.00508
G1 X94.389 Y99.517 E.01332
G1 X94.393 Y94.771 E.10043
G1 X94.408 Y94.654 E.00251
G1 X94.388 Y90.006 E.09838
G1 X94.405 Y88.877 E.02388
G1 X94.39 Y80.543 E.17639
M204 S10000
G1 X93.965 Y80.059 F18000
G1 F1500
M204 S500
G1 X94.595 Y80.059 E.01333
G1 X94.595 Y79.819 E.00508
G1 X97.682 Y79.819 E.06534
M73 P61 R12
G1 X97.672 Y82.224 E.05089
G1 X97.703 Y82.842 E.0131
G1 X97.664 Y83.886 E.02213
G1 X97.704 Y84.599 E.01511
G1 X97.704 Y86.418 E.0385
G1 X97.672 Y86.978 E.01187
G1 X97.705 Y89.181 E.04665
G1 X97.704 Y90.865 E.03563
G1 X97.672 Y93.022 E.04568
G1 X97.704 Y93.582 E.01187
G1 X97.704 Y95.401 E.0385
G1 X97.664 Y96.114 E.01511
G1 X97.703 Y97.159 E.02213
G1 X97.672 Y97.776 E.0131
G1 X97.682 Y100.181 E.05089
G1 X94.595 Y100.181 E.06534
G1 X94.595 Y99.941 E.00508
G1 X93.964 Y99.941 E.01334
G1 X93.969 Y94.745 E.10997
G1 X93.983 Y94.628 E.00249
G1 X93.964 Y90.003 E.0979
G1 X93.98 Y88.875 E.02388
G1 X93.965 Y80.119 E.18532
M204 S250
G1 X93.555 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.186 Y79.65 E.01241
G1 X94.186 Y79.41 E.00472
G1 X98.106 Y79.41 E.0771
G1 X98.092 Y79.712 E.00594
G1 X98.082 Y82.228 E.04949
G1 X98.11 Y82.779 E.01086
G1 X98.111 Y82.808 E.00058
G1 X98.111 Y82.879 E.00139
G1 X98.073 Y83.882 E.01974
G1 X98.11 Y84.528 E.01272
G1 X98.113 Y84.68 E.003
G1 X98.113 Y85.146 E.00917
G1 X98.113 Y86.429 E.02524
G1 F1710
G1 X98.082 Y86.974 E.01073
G1 F1500
G1 X98.083 Y87.053 E.00156
G1 X98.114 Y89.414 E.04643
G1 X98.114 Y90.649 E.02429
G1 X98.083 Y92.948 E.04522
G1 X98.082 Y93.026 E.00154
G1 F1710
G1 X98.113 Y93.571 E.01073
G1 F1500
G1 X98.113 Y94.854 E.02524
G1 X98.113 Y95.32 E.00917
G1 X98.11 Y95.472 E.003
G1 X98.073 Y96.118 E.01272
G1 X98.111 Y97.121 E.01974
G1 X98.111 Y97.192 E.00139
G1 X98.11 Y97.221 E.00058
G1 X98.082 Y97.772 E.01086
G1 X98.104 Y100.59 E.05542
G1 X94.186 Y100.59 E.07706
G1 X94.186 Y100.35 E.00472
G1 X93.555 Y100.35 E.01242
G1 X93.56 Y94.72 E.11074
G1 X93.574 Y94.604 E.00229
G1 X93.554 Y90.001 E.09054
G1 X93.571 Y88.872 E.0222
G1 X93.555 Y79.71 E.18022
; WIPE_START
M204 S6000
G1 X94.186 Y79.65 E-.12045
G1 X94.186 Y79.41 E-.0456
G1 X95.312 Y79.41 E-.21395
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




G1 X95.134 Y80.873
G1 Z3.56
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.377283
G1 F1200
M204 S6000
G1 X94.78 Y80.873 E.00621
G1 X94.788 Y87.275 E.11228
G1 X95.137 Y87.25 E.00613
G1 X95.134 Y80.933 E.11079
M204 S10000
G1 X95.523 Y81.44 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.523 Y80.606 E.01765
G1 X96.386 Y80.606 E.01827
G1 X96.371 Y80.896 E.00614
G1 X96.44 Y81.351 E.00974
G1 X96.615 Y81.807 E.01033
G1 X96.885 Y82.198 E.01007
G1 X96.915 Y82.846 E.01373
G1 X96.876 Y83.893 E.02218
G1 X96.917 Y84.621 E.01543
G1 X96.912 Y86.474 E.03922
G1 X96.788 Y86.814 E.00765
G1 X96.521 Y87.269 E.01117
G1 X96.394 Y87.724 E.01
G1 X96.371 Y88.179 E.00965
G1 X96.44 Y88.635 E.00974
G1 X96.615 Y89.09 E.01032
G1 X96.917 Y89.528 E.01126
G1 X96.917 Y90.858 E.02816
G1 X96.885 Y93.039 E.04616
G1 X96.917 Y93.745 E.01496
G1 X96.788 Y94.097 E.00793
G1 X96.521 Y94.552 E.01117
G1 X96.394 Y95.007 E.01
G1 X96.371 Y95.462 E.00965
G1 X96.44 Y95.918 E.00974
G1 X96.615 Y96.373 E.01033
G1 X96.902 Y96.788 E.01068
G1 X96.915 Y97.154 E.00774
G1 X96.885 Y97.758 E.01281
G1 X96.888 Y98.484 E.01536
; WIPE_START
G1 X96.885 Y97.758 E-.13791
G1 X96.915 Y97.154 E-.11502
G1 X96.902 Y96.788 E-.06949
G1 X96.73 Y96.539 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.137 Y92.768 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.377773
G1 F1200
M204 S6000
G1 X95.094 Y92.726 E.00106
G1 X94.786 Y92.726 E.00541
G1 X94.779 Y99.127 E.11243
G1 X95.133 Y99.127 E.00623
G1 X95.137 Y92.828 E.11062
; WIPE_START
G1 X95.136 Y94.828 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.914 Y88.47 Z3.96 F18000
G1 X85.612 Y80.483 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.607 Y85.229 E.10043
G1 X85.593 Y85.346 E.00251
G1 X85.613 Y90 E.0985
G1 X85.593 Y94.654 E.0985
G1 X85.607 Y94.771 E.00251
G1 X85.612 Y99.517 E.10043
G1 X85.036 Y99.517 E.01218
G1 X85.023 Y99.757 E.00509
G1 X82.722 Y99.757 E.0487
G1 X82.722 Y80.243 E.41301
G1 X85.076 Y80.243 E.04983
G1 X85.107 Y80.483 E.00512
G1 X85.552 Y80.483 E.0094
M204 S10000
G1 X86.036 Y80.059 F18000
G1 F1500
M204 S500
G1 X86.032 Y85.255 E.10997
G1 X86.017 Y85.372 E.00249
G1 X86.037 Y90 E.09796
G1 X86.017 Y94.628 E.09796
G1 X86.032 Y94.745 E.00249
G1 X86.036 Y99.941 E.10997
G1 X85.438 Y99.941 E.01267
G1 X85.425 Y100.181 E.00509
G1 X82.298 Y100.181 E.06618
G1 X82.298 Y79.819 E.43097
G1 X85.449 Y79.819 E.0667
G1 X85.48 Y80.059 E.00512
G1 X85.976 Y80.059 E.0105
M204 S250
G1 X86.446 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.441 Y85.28 E.11074
G1 X86.427 Y85.396 E.00229
G1 X86.446 Y90 E.09056
G1 X86.427 Y94.604 E.09056
G1 X86.441 Y94.72 E.00229
G1 X86.446 Y100.35 E.11074
G1 X85.825 Y100.35 E.0122
G1 X85.812 Y100.59 E.00473
G1 X81.889 Y100.59 E.07717
G1 X81.889 Y97.495 E.06088
G1 X81.889 Y96.863 E.01243
G1 X81.889 Y95.443 E.02794
G1 X81.889 Y95.192 E.00494
G1 X81.889 Y93.746 E.02843
G1 X81.889 Y93.396 E.00688
G1 X81.889 Y86.604 E.13361
G1 X81.889 Y86.254 E.00688
G1 X81.889 Y84.808 E.02843
G1 X81.889 Y84.557 E.00494
G1 X81.889 Y83.137 E.02794
G1 X81.889 Y82.505 E.01243
G1 X81.889 Y79.41 E.06088
G1 X85.809 Y79.41 E.0771
G1 X85.84 Y79.65 E.00476
G1 X86.386 Y79.65 E.01074
; WIPE_START
M204 S6000
G1 X86.405 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.221 Y81.051 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.377661
G1 F1200
M204 S6000
G1 X85.222 Y80.873 E.00312
G1 X84.921 Y80.85 E.00529
G1 X84.805 Y80.716 E.0031
G1 X84.866 Y81.051 E.00598
G1 X84.864 Y87.1 E.1062
G1 X84.889 Y87.275 E.0031
G1 X85.214 Y87.275 E.0057
G1 X85.221 Y81.111 E.10821
; WIPE_START
G1 X85.219 Y83.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.085 Y81.335 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.085 Y83.032 E.03592
G1 X83.212 Y83.172 E.004
G1 X83.479 Y83.627 E.01117
G1 X83.606 Y84.083 E.01
G1 X83.629 Y84.538 E.00965
G1 X83.56 Y84.993 E.00974
G1 X83.385 Y85.448 E.01033
G1 X83.085 Y85.883 E.01117
G1 X83.085 Y90.315 E.09382
G1 X83.212 Y90.455 E.004
G1 X83.479 Y90.91 E.01117
G1 X83.606 Y91.366 E.01
G1 X83.629 Y91.821 E.00965
G1 X83.56 Y92.276 E.00974
G1 X83.385 Y92.731 E.01033
G1 X83.085 Y93.166 E.01117
G1 X83.085 Y97.599 E.09382
G1 X83.212 Y97.738 E.004
G1 X83.479 Y98.194 E.01117
G1 X83.606 Y98.649 E.01
G1 X83.629 Y99.104 E.00965
G1 X83.585 Y99.394 E.0062
G1 X84.476 Y99.394 E.01886
G1 X84.476 Y98.588 E.01706
; WIPE_START
G1 X84.476 Y99.394 E-.15314
G1 X83.585 Y99.394 E-.16929
G1 X83.629 Y99.104 E-.05566
G1 X83.628 Y99.094 E-.00191
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.219 Y94.806 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.377993
G1 F1200
M204 S6000
G1 X85.214 Y92.725 E.03657
G1 X84.864 Y92.751 E.00617
G1 X84.866 Y99.127 E.11205
G1 X85.222 Y99.127 E.00625
G1 X85.219 Y94.866 E.07487
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X85.22 Y96.866 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/74
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I1.061 J.596 P1  F18000
G1 X94.428 Y80.483 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.582 Y80.483 E.02443
G1 X95.584 Y80.243 E.00508
G1 X97.297 Y80.243 E.03624
G1 X97.289 Y82.161 E.04059
G1 X97.313 Y82.581 E.0089
G1 X97.279 Y83.913 E.0282
G1 X97.312 Y84.498 E.01241
G1 X97.313 Y86.618 E.04487
G1 X97.288 Y87.045 E.00904
G1 X97.313 Y88.706 E.03517
G1 X97.313 Y91.294 E.05478
G1 X97.288 Y92.955 E.03517
G1 X97.313 Y93.382 E.00904
G1 X97.312 Y95.502 E.04487
G1 X97.279 Y96.087 E.01241
G1 X97.312 Y96.958 E.01844
G1 X97.313 Y97.419 E.00976
G1 X97.289 Y97.839 E.0089
G1 X97.297 Y99.757 E.04059
G1 X95.584 Y99.757 E.03624
M73 P62 R12
G1 X95.582 Y99.517 E.00508
G1 X94.429 Y99.517 E.02441
G1 X94.446 Y94.524 E.10567
G1 X94.426 Y90 E.09576
G1 X94.443 Y86.686 E.07016
G1 X94.428 Y80.543 E.13
M204 S10000
G1 X94.003 Y80.059 F18000
G1 F1500
M204 S500
G1 X95.162 Y80.059 E.02453
G1 X95.164 Y79.819 E.00508
G1 X97.723 Y79.819 E.05416
G1 X97.713 Y82.15 E.04933
G1 X97.737 Y82.569 E.0089
G1 X97.703 Y83.909 E.02837
G1 X97.736 Y84.486 E.01223
G1 X97.737 Y86.63 E.04538
G1 X97.713 Y87.054 E.00898
G1 X97.738 Y88.703 E.03491
G1 X97.738 Y91.297 E.05492
G1 X97.713 Y92.946 E.03491
G1 X97.737 Y93.37 E.00898
G1 X97.736 Y95.514 E.04538
G1 X97.703 Y96.091 E.01223
G1 X97.736 Y96.949 E.01819
G1 X97.737 Y97.431 E.01019
G1 X97.713 Y97.85 E.0089
G1 X97.723 Y100.181 E.04933
G1 X95.164 Y100.181 E.05416
G1 X95.162 Y99.941 E.00508
G1 X94.004 Y99.941 E.02451
G1 X94.022 Y94.525 E.11463
G1 X94.002 Y90 E.09577
G1 X94.018 Y86.686 E.07016
G1 X94.003 Y80.119 E.13898
M204 S250
G1 X93.593 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.756 Y79.65 E.02288
G1 X94.758 Y79.41 E.00472
G1 X98.139 Y79.41 E.06651
G1 X98.133 Y79.536 E.00249
G1 X98.123 Y82.151 E.05143
G1 F1710
G1 X98.146 Y82.558 E.00803
G1 F1500
G1 X98.146 Y82.623 E.00128
G1 X98.113 Y83.905 E.02523
G1 X98.145 Y84.475 E.01121
G1 X98.146 Y86.575 E.04131
G1 X98.146 Y86.642 E.00131
G1 F1710
G1 X98.123 Y87.05 E.00804
G1 F1500
G1 X98.123 Y87.128 E.00153
G1 X98.147 Y88.769 E.03228
G1 X98.147 Y91.256 E.04892
G1 X98.123 Y92.872 E.03179
G1 X98.123 Y92.95 E.00153
G1 F1710
G1 X98.146 Y93.359 E.00804
G1 F1500
G1 X98.146 Y93.425 E.00131
G1 X98.145 Y95.525 E.04131
G1 X98.113 Y96.095 E.01121
G1 X98.146 Y97.377 E.02523
G1 X98.146 Y97.442 E.00128
G1 F1710
G1 X98.123 Y97.849 E.00803
G1 F1500
G1 X98.139 Y100.59 E.05391
G1 X94.758 Y100.59 E.06651
G1 X94.756 Y100.35 E.00472
G1 X93.593 Y100.35 E.02287
G1 X93.613 Y94.526 E.11456
G1 X93.593 Y90 E.08901
G1 X93.609 Y86.685 E.0652
G1 X93.593 Y79.71 E.1372
; WIPE_START
M204 S6000
G1 X94.756 Y79.65 E-.22124
G1 X94.758 Y79.41 E-.0456
G1 X95.353 Y79.41 E-.11316
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




G1 X95.143 Y81.03
G1 Z3.68
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.358488
G1 F1200
M204 S6000
G1 X95.143 Y80.863 E.00278
G1 X94.808 Y80.863 E.00556
G1 X94.816 Y87.284 E.10659
G1 X95.131 Y87.269 E.00524
G1 X95.146 Y87.119 E.0025
G1 X95.143 Y81.09 E.10007
M204 S10000
G1 X95.523 Y81.42 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.523 Y80.846 E.01213
G1 X95.942 Y80.846 E.00888
G1 X95.944 Y80.606 E.00508
G1 X96.408 Y80.606 E.00983
G1 X96.372 Y80.896 E.00618
G1 X96.407 Y81.351 E.00966
G1 X96.547 Y81.807 E.01008
G1 X96.826 Y82.262 E.0113
G1 X96.947 Y82.689 E.00939
G1 X96.915 Y83.919 E.02605
G1 X96.949 Y84.509 E.01251
G1 X96.95 Y86.397 E.03996
G1 X96.892 Y86.814 E.00891
G1 X96.592 Y87.269 E.01155
G1 X96.429 Y87.724 E.01023
G1 X96.372 Y88.179 E.00971
G1 X96.407 Y88.635 E.00966
G1 X96.547 Y89.09 E.01008
G1 X96.826 Y89.545 E.0113
G1 X96.951 Y89.985 E.00968
G1 X96.925 Y92.963 E.06304
G1 X96.95 Y93.68 E.01519
G1 X96.892 Y94.097 E.0089
G1 X96.592 Y94.552 E.01155
G1 X96.429 Y95.007 E.01023
G1 X96.372 Y95.462 E.00971
G1 X96.407 Y95.918 E.00966
G1 X96.547 Y96.373 E.01008
G1 X96.826 Y96.828 E.0113
G1 X96.949 Y97.264 E.00958
G1 X96.926 Y97.829 E.01198
G1 X96.93 Y98.96 E.02393
; WIPE_START
G1 X96.926 Y97.829 E-.21482
G1 X96.949 Y97.264 E-.10757
G1 X96.867 Y96.972 E-.05761
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.147 Y92.768 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.355623
G1 F1200
M204 S6000
G1 X95.094 Y92.716 E.00122
G1 X94.816 Y92.716 E.00459
G1 X94.81 Y99.138 E.10568
G1 X95.144 Y99.138 E.0055
G1 X95.147 Y92.828 E.10383
; WIPE_START
G1 X95.146 Y94.828 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.909 Y88.48 Z4.08 F18000
G1 X85.571 Y80.483 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.554 Y85.476 E.10567
G1 X85.574 Y90 E.09576
G1 X85.554 Y94.526 E.0958
G1 X85.571 Y99.517 E.10562
G1 X84.403 Y99.517 E.02474
G1 X84.404 Y99.757 E.00508
G1 X82.687 Y99.757 E.03634
G1 X82.687 Y80.243 E.41301
G1 X84.415 Y80.243 E.03656
G1 X84.417 Y80.483 E.00508
G1 X85.511 Y80.483 E.02317
M204 S10000
G1 X85.997 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.978 Y85.475 E.11463
G1 X85.999 Y90 E.09577
G1 X85.978 Y94.526 E.0958
G1 X85.997 Y99.941 E.11461
G1 X84.829 Y99.941 E.02472
G1 X84.831 Y100.181 E.00508
G1 X82.263 Y100.181 E.05435
G1 X82.263 Y79.819 E.43097
G1 X84.836 Y79.819 E.05445
G1 X84.837 Y80.059 E.00508
G1 X85.937 Y80.059 E.02327
M204 S250
G1 X86.408 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.388 Y85.474 E.11456
G1 X86.408 Y90 E.08901
G1 X86.388 Y94.526 E.08902
G1 X86.408 Y100.35 E.11456
G1 X85.241 Y100.35 E.02295
G1 X85.242 Y100.59 E.00472
G1 X81.854 Y100.59 E.06665
G1 X81.854 Y79.41 E.41659
G1 X85.242 Y79.41 E.06664
G1 X85.244 Y79.65 E.00472
G1 X86.348 Y79.65 E.02172
; WIPE_START
M204 S6000
G1 X86.361 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.19 Y81.031 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.355875
G1 F1200
M204 S6000
G1 X85.191 Y80.863 E.00277
G1 X84.855 Y80.863 E.00552
G1 X84.855 Y87.119 E.10304
G1 X84.885 Y87.284 E.00276
G1 X85.185 Y87.284 E.00494
G1 X85.19 Y81.091 E.10201
; WIPE_START
G1 X85.188 Y83.091 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.05 Y81.408 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.05 Y83.105 E.03592
G1 X83.408 Y83.627 E.0134
G1 X83.571 Y84.083 E.01023
G1 X83.628 Y84.538 E.00971
G1 X83.593 Y84.993 E.00966
G1 X83.453 Y85.448 E.01008
G1 X83.174 Y85.903 E.0113
G1 X83.05 Y86.038 E.00387
G1 X83.05 Y90.388 E.09208
G1 X83.408 Y90.91 E.0134
G1 X83.571 Y91.366 E.01023
G1 X83.628 Y91.821 E.00971
G1 X83.593 Y92.276 E.00966
G1 X83.453 Y92.731 E.01008
G1 X83.174 Y93.186 E.0113
G1 X83.05 Y93.321 E.00387
G1 X83.05 Y97.671 E.09208
G1 X83.408 Y98.194 E.0134
G1 X83.571 Y98.649 E.01023
G1 X83.628 Y99.104 E.00971
G1 X83.605 Y99.394 E.00615
G1 X84.039 Y99.394 E.00918
G1 X84.038 Y99.154 E.00508
G1 X84.476 Y99.154 E.00927
G1 X84.476 Y98.569 E.01238
; WIPE_START
G1 X84.476 Y99.154 E-.11115
G1 X84.038 Y99.154 E-.08324
G1 X84.039 Y99.394 E-.0456
G1 X83.605 Y99.394 E-.08244
G1 X83.628 Y99.104 E-.0552
G1 X83.626 Y99.092 E-.00237
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.184 Y92.881 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.355887
G1 F1200
M204 S6000
G1 X85.185 Y92.716 E.00273
G1 X84.87 Y92.731 E.0052
G1 X84.855 Y92.881 E.00248
G1 X84.855 Y99.137 E.10305
G1 X85.191 Y99.137 E.00552
G1 X85.184 Y92.941 E.10205
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X85.186 Y94.941 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/74
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I1.024 J.658 P1  F18000
G1 X94.48 Y80.483 Z4.08
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.917 Y80.483 E.03041
G1 X95.917 Y80.243 E.00508
G1 X97.337 Y80.243 E.03005
G1 X97.329 Y82.085 E.03898
G1 X97.344 Y82.347 E.00555
G1 X97.324 Y82.796 E.00952
G1 X97.343 Y83.288 E.01041
G1 X97.318 Y83.936 E.01373
G1 X97.342 Y84.366 E.00911
G1 X97.325 Y84.822 E.00965
G1 X97.325 Y86.423 E.03389
G1 X97.344 Y86.853 E.00911
G1 X97.329 Y87.121 E.00567
G1 X97.346 Y88.238 E.02367
G1 X97.329 Y88.929 E.01462
G1 X97.348 Y90 E.02267
G1 X97.329 Y91.071 E.02268
M73 P63 R12
G1 X97.346 Y91.762 E.01462
G1 X97.329 Y92.879 E.02367
G1 X97.344 Y93.147 E.00567
G1 X97.325 Y93.577 E.00911
G1 X97.325 Y95.178 E.03389
G1 X97.342 Y95.634 E.00965
G1 X97.318 Y96.064 E.00911
G1 X97.343 Y96.712 E.01373
G1 X97.324 Y97.203 E.01041
G1 X97.344 Y97.653 E.00952
G1 X97.329 Y97.916 E.00558
G1 X97.341 Y99.757 E.03895
G1 X95.917 Y99.757 E.03015
G1 X95.917 Y99.517 E.00508
G1 X94.472 Y99.517 E.03059
G1 X94.48 Y80.543 E.40158
M204 S10000
G1 X94.052 Y80.059 F18000
G1 F1500
M204 S500
G1 X95.493 Y80.059 E.03051
G1 X95.493 Y79.819 E.00508
G1 X97.763 Y79.819 E.04804
G1 X97.754 Y82.074 E.04772
G1 X97.769 Y82.344 E.00573
G1 X97.749 Y82.798 E.00961
G1 X97.767 Y83.288 E.01038
G1 X97.743 Y83.932 E.01365
G1 X97.767 Y84.362 E.0091
G1 X97.749 Y84.829 E.0099
G1 X97.749 Y86.414 E.03353
G1 X97.769 Y86.856 E.00937
G1 X97.753 Y87.13 E.00581
G1 X97.77 Y88.24 E.02351
G1 X97.754 Y88.93 E.01461
G1 X97.773 Y90 E.02264
G1 X97.754 Y91.07 E.02265
G1 X97.77 Y91.76 E.01461
G1 X97.753 Y92.87 E.02351
G1 X97.769 Y93.144 E.00581
G1 X97.749 Y93.586 E.00937
G1 X97.749 Y95.171 E.03353
G1 X97.767 Y95.638 E.0099
G1 X97.743 Y96.068 E.0091
G1 X97.767 Y96.712 E.01365
G1 X97.749 Y97.202 E.01038
G1 X97.769 Y97.656 E.00961
G1 X97.753 Y97.927 E.00575
G1 X97.769 Y100.181 E.04771
G1 X95.493 Y100.181 E.04816
G1 X95.493 Y99.941 E.00508
G1 X94.046 Y99.941 E.03062
G1 X94.061 Y94.459 E.11602
G1 X94.045 Y89.999 E.09441
G1 X94.052 Y80.119 E.2091
M204 S250
G1 X93.638 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.084 Y79.65 E.02844
G1 X95.084 Y79.41 E.00472
G1 X98.174 Y79.41 E.06078
G1 X98.163 Y82.063 E.05218
G1 X98.163 Y82.075 E.00024
G1 F1710
G1 X98.179 Y82.342 E.00525
G1 F1500
G1 X98.177 Y82.379 E.00074
G1 X98.159 Y82.799 E.00826
G1 X98.177 Y83.288 E.00962
G1 X98.152 Y83.929 E.01261
G1 X98.177 Y84.358 E.00846
G1 X98.159 Y84.837 E.00943
G1 X98.159 Y86.405 E.03083
G1 X98.177 Y86.821 E.00819
G1 X98.179 Y86.858 E.00074
G1 F1710
G1 X98.163 Y87.125 E.00526
G1 F1500
G1 X98.164 Y87.204 E.00155
G1 X98.179 Y88.256 E.0207
G1 X98.163 Y88.932 E.01329
G1 X98.182 Y90 E.02101
G1 X98.163 Y91.068 E.02102
G1 X98.179 Y91.744 E.01329
G1 X98.164 Y92.796 E.0207
G1 X98.163 Y92.875 E.00155
G1 F1710
G1 X98.179 Y93.142 E.00526
G1 F1500
G1 X98.177 Y93.179 E.00074
G1 X98.159 Y93.595 E.00819
G1 X98.159 Y95.163 E.03083
G1 X98.177 Y95.642 E.00943
G1 X98.152 Y96.071 E.00846
G1 X98.177 Y96.712 E.01261
G1 X98.159 Y97.201 E.00962
G1 X98.177 Y97.621 E.00826
G1 X98.179 Y97.658 E.00074
G1 F1710
G1 X98.163 Y97.925 E.00525
G1 F1500
G1 X98.165 Y98.236 E.00611
G1 X98.177 Y99.99 E.03451
G1 F1710
G1 X98.181 Y100.59 E.0118
G1 F1500
G1 X98.18 Y100.59 E.00001
G1 X95.084 Y100.59 E.06089
G1 X95.084 Y100.35 E.00472
G1 X93.636 Y100.35 E.02848
G1 X93.652 Y94.46 E.11586
G1 X93.635 Y90 E.08771
G1 X93.65 Y80.737 E.1822
G1 X93.639 Y79.71 E.02021
; WIPE_START
M204 S6000
G1 X95.084 Y79.65 E-.27486
G1 X95.084 Y79.41 E-.0456
G1 X95.397 Y79.41 E-.05954
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




G1 X95.523 Y81.401
G1 Z3.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.523 Y80.846 E.01175
G1 X96.28 Y80.846 E.01602
G1 X96.28 Y80.606 E.00508
G1 X96.425 Y80.606 E.00307
G1 X96.367 Y80.896 E.00625
G1 X96.369 Y81.351 E.00963
G1 X96.473 Y81.807 E.00988
G1 X96.718 Y82.262 E.01095
G1 X96.972 Y82.547 E.00809
G1 X96.961 Y82.795 E.00526
G1 X96.98 Y83.288 E.01043
G1 X96.955 Y83.94 E.01381
G1 X96.979 Y84.369 E.00911
G1 X96.962 Y84.815 E.00943
G1 X96.962 Y86.431 E.0342
G1 X96.98 Y86.832 E.0085
G1 X96.656 Y87.269 E.01151
G1 X96.458 Y87.724 E.01051
G1 X96.367 Y88.179 E.00982
G1 X96.369 Y88.635 E.00963
G1 X96.473 Y89.09 E.00988
G1 X96.718 Y89.545 E.01095
G1 X96.983 Y89.842 E.00842
G1 X96.966 Y91.072 E.02604
G1 X96.983 Y91.763 E.01463
G1 X96.966 Y92.887 E.0238
G1 X96.981 Y93.149 E.00556
G1 X96.962 Y94.139 E.02095
G1 X96.656 Y94.552 E.01088
G1 X96.458 Y95.007 E.01051
G1 X96.367 Y95.462 E.00982
G1 X96.369 Y95.918 E.00963
G1 X96.473 Y96.373 E.00988
G1 X96.718 Y96.828 E.01095
G1 X96.965 Y97.105 E.00786
G1 X96.981 Y97.651 E.01154
G1 X96.966 Y97.907 E.00544
G1 X96.972 Y98.801 E.01893
; WIPE_START
G1 X96.966 Y97.907 E-.16994
G1 X96.981 Y97.651 E-.0488
G1 X96.965 Y97.105 E-.10364
G1 X96.763 Y96.879 E-.05763
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.998 Y98.991 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.651402
G1 F1200
M204 S6000
G1 X94.999 Y92.923 E.18941
; WIPE_START
G1 X94.999 Y94.923 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.001 Y87.291 Z4.2 F18000
G1 X95.001 Y87.151 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.646072
G1 F1200
M204 S6000
G1 X95.002 Y81.065 E.18834
; WIPE_START
G1 X95.001 Y83.065 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.637 Y81.058 Z4.2 F18000
G1 X85.529 Y80.483 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.515 Y85.54 E.10702
G1 X85.53 Y99.517 E.29583
G1 X84.083 Y99.517 E.03065
G1 X84.083 Y99.757 E.00508
G1 X82.659 Y99.757 E.03013
G1 X82.675 Y95.622 E.08752
G1 X82.657 Y95.136 E.01027
G1 X82.657 Y94.108 E.02178
G1 X82.676 Y93.616 E.01041
G1 X82.652 Y90.252 E.0712
G1 X82.675 Y82.799 E.15774
G1 X82.659 Y80.243 E.0541
G1 X84.088 Y80.243 E.03024
G1 X84.089 Y80.483 E.00508
G1 X85.469 Y80.483 E.02919
M204 S10000
G1 X85.954 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.939 Y85.54 E.116
G1 X85.955 Y99.941 E.30481
G1 X84.507 Y99.941 E.03065
G1 X84.507 Y100.181 E.00508
G1 X82.232 Y100.181 E.04815
G1 X82.251 Y97.202 E.06306
G1 X82.233 Y94.1 E.06565
G1 X82.251 Y93.609 E.01039
G1 X82.228 Y90.253 E.07105
G1 X82.251 Y82.8 E.15776
G1 X82.232 Y79.819 E.06308
G1 X84.51 Y79.819 E.04821
G1 X84.511 Y80.059 E.00508
G1 X85.894 Y80.059 E.02927
M204 S250
G1 X86.364 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.349 Y85.54 E.11585
G1 X86.365 Y100.35 E.2913
G1 X84.916 Y100.35 E.02849
G1 X84.917 Y100.59 E.00472
G1 X81.82 Y100.59 E.0609
G1 X81.842 Y97.201 E.06667
G1 X81.824 Y94.092 E.06114
G1 X81.842 Y93.603 E.00963
G1 X81.819 Y90.254 E.06588
G1 X81.842 Y82.8 E.14662
G1 X81.82 Y79.41 E.06667
G1 X84.916 Y79.41 E.0609
G1 X84.918 Y79.65 E.00472
G1 X86.304 Y79.65 E.02727
; WIPE_START
M204 S6000
G1 X86.319 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.03 Y81.516 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.037 Y83.213 E.03592
G1 X83.344 Y83.627 E.0109
G1 X83.542 Y84.083 E.01051
G1 X83.633 Y84.538 E.00982
G1 X83.632 Y84.993 E.00963
G1 X83.527 Y85.448 E.00988
G1 X83.282 Y85.903 E.01095
G1 X83.028 Y86.189 E.00809
G1 X83.017 Y90.469 E.09059
G1 X83.344 Y90.91 E.01163
G1 X83.542 Y91.366 E.01051
M73 P63 R11
G1 X83.633 Y91.821 E.00982
G1 X83.632 Y92.276 E.00963
G1 X83.527 Y92.731 E.00988
G1 X83.282 Y93.186 E.01095
G1 X83.037 Y93.461 E.00779
G1 X83.02 Y94.114 E.01383
G1 X83.02 Y95.129 E.02148
G1 X83.038 Y95.615 E.01029
G1 X83.03 Y97.77 E.0456
G1 X83.344 Y98.194 E.01116
G1 X83.542 Y98.649 E.01051
G1 X83.633 Y99.104 E.00982
G1 X83.632 Y99.394 E.00613
G1 X83.72 Y99.394 E.00186
G1 X83.72 Y99.154 E.00508
G1 X84.476 Y99.154 E.01601
G1 X84.476 Y98.541 E.01297
M204 S10000
G1 X85.003 Y98.99 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.651252
G1 F1200
M204 S6000
G1 X85 Y92.909 E.18975
; WIPE_START
G1 X85.001 Y94.909 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.998 Y87.277 Z4.2 F18000
G1 X84.998 Y87.141 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.647442
G1 F1200
M204 S6000
G1 X85.002 Y81.069 E.18833
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X85 Y83.069 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 32/74
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I.319 J1.174 P1  F18000
G1 X94.522 Y80.483 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.151 Y80.483 E.03448
G1 X96.151 Y80.243 E.00508
G1 X97.38 Y80.243 E.02602
G1 X97.378 Y82.105 E.03939
G1 X97.348 Y82.796 E.01466
G1 X97.375 Y83.513 E.01518
G1 X97.358 Y83.96 E.00945
G1 X97.374 Y84.253 E.00623
G1 X97.349 Y84.933 E.01439
G1 X97.349 Y86.423 E.03154
G1 X97.378 Y87.087 E.01408
G1 X97.353 Y88.849 E.03729
G1 X97.381 Y90 E.02437
G1 X97.353 Y91.151 E.02437
G1 X97.378 Y92.913 E.03729
G1 X97.349 Y93.577 E.01408
G1 X97.349 Y95.067 E.03154
G1 X97.374 Y95.747 E.01439
G1 X97.358 Y96.04 E.00623
G1 X97.375 Y96.487 E.00945
G1 X97.348 Y97.203 E.01518
G1 X97.378 Y97.895 E.01466
G1 X97.38 Y99.757 E.03939
G1 X96.151 Y99.757 E.02601
G1 X96.151 Y99.517 E.00508
G1 X94.522 Y99.517 E.03448
G1 X94.522 Y80.543 E.40158
M204 S10000
M73 P64 R11
G1 X94.094 Y80.059 F18000
G1 F1500
M204 S500
G1 X95.727 Y80.059 E.03455
G1 X95.727 Y79.819 E.00508
G1 X97.805 Y79.819 E.04399
G1 X97.802 Y82.114 E.04857
G1 X97.772 Y82.798 E.01448
G1 X97.799 Y83.513 E.01515
G1 X97.782 Y83.956 E.00937
G1 X97.799 Y84.249 E.00622
G1 X97.773 Y84.941 E.01465
G1 X97.773 Y86.414 E.03118
G1 X97.802 Y87.081 E.01414
G1 X97.777 Y88.847 E.03737
G1 X97.805 Y90 E.02442
G1 X97.777 Y91.154 E.02442
G1 X97.802 Y92.919 E.03737
G1 X97.773 Y93.586 E.01414
G1 X97.773 Y95.059 E.03118
G1 X97.799 Y95.751 E.01465
G1 X97.782 Y96.044 E.00622
G1 X97.799 Y96.487 E.00937
G1 X97.772 Y97.202 E.01515
G1 X97.802 Y97.886 E.01449
G1 X97.805 Y100.181 E.04857
G1 X95.727 Y100.181 E.04398
G1 X95.727 Y99.941 E.00508
G1 X94.094 Y99.941 E.03455
G1 X94.094 Y80.119 E.41954
M204 S250
G1 X93.682 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.317 Y79.65 E.03217
G1 X95.317 Y79.41 E.00472
G1 X98.215 Y79.41 E.05698
G1 X98.214 Y79.524 E.00224
G1 X98.214 Y80.124 E.0118
G1 F1710
G1 X98.212 Y82.123 E.03933
G1 F1500
G1 X98.21 Y82.167 E.00087
G1 X98.182 Y82.799 E.01244
G1 X98.209 Y83.513 E.01406
G1 X98.192 Y83.952 E.00863
G1 X98.209 Y84.245 E.00578
G1 X98.182 Y84.948 E.01384
G1 X98.182 Y86.405 E.02864
G1 X98.21 Y87.033 E.01236
G1 X98.212 Y87.075 E.00084
G1 F1710
G1 X98.206 Y87.502 E.00839
G1 F1500
G1 X98.187 Y88.844 E.02641
G1 X98.215 Y90 E.02274
G1 X98.187 Y91.156 E.02274
G1 X98.206 Y92.498 E.02641
G1 F1710
G1 X98.212 Y92.925 E.00839
G1 F1500
G1 X98.21 Y92.967 E.00084
G1 X98.182 Y93.595 E.01236
G1 X98.182 Y95.052 E.02864
G1 X98.209 Y95.755 E.01384
G1 X98.192 Y96.048 E.00578
G1 X98.209 Y96.487 E.00863
G1 X98.182 Y97.201 E.01406
G1 X98.21 Y97.833 E.01244
G1 X98.212 Y97.877 E.00087
G1 F1710
G1 X98.213 Y99.153 E.0251
G1 F1500
G1 X98.214 Y100.429 E.0251
G1 X98.214 Y100.59 E.00318
G1 X95.317 Y100.59 E.05698
G1 X95.317 Y100.35 E.00472
G1 X93.682 Y100.35 E.03217
G1 X93.694 Y98.829 E.02992
G1 X93.68 Y91.088 E.15226
G1 X93.694 Y81.171 E.19506
G1 X93.682 Y79.71 E.02874
; WIPE_START
M204 S6000
G1 X95.317 Y79.65 E-.3109
G1 X95.317 Y79.41 E-.0456
G1 X95.441 Y79.41 E-.0235
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




G1 X94.885 Y81.058
G1 Z3.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X94.885 Y80.846 E.00449
G1 X96.37 Y80.846 E.03143
G1 X96.323 Y81.351 E.01074
G1 X96.391 Y81.807 E.00974
G1 X96.602 Y82.262 E.01062
G1 X96.989 Y82.708 E.0125
G1 X97.012 Y83.513 E.01704
G1 X96.994 Y83.963 E.00953
G1 X97.011 Y84.257 E.00623
G1 X96.986 Y84.926 E.01418
G1 X96.986 Y86.431 E.03185
G1 X97.007 Y86.918 E.01033
G1 X96.717 Y87.269 E.00964
G1 X96.481 Y87.724 E.01085
G1 X96.356 Y88.179 E.00999
G1 X96.323 Y88.635 E.00966
G1 X96.391 Y89.09 E.00974
G1 X96.602 Y89.545 E.01062
G1 X97.017 Y90.02 E.01336
G1 X96.99 Y91.149 E.02391
G1 X97.015 Y92.907 E.03721
G1 X96.986 Y93.569 E.01403
G1 X96.986 Y94.227 E.01392
G1 X96.717 Y94.552 E.00894
G1 X96.481 Y95.007 E.01085
G1 X96.356 Y95.462 E.00999
G1 X96.323 Y95.918 E.00966
G1 X96.391 Y96.373 E.00974
G1 X96.602 Y96.828 E.01062
G1 X96.988 Y97.273 E.01247
G1 X97.016 Y97.904 E.01335
G1 X97.017 Y98.97 E.02257
; WIPE_START
G1 X97.016 Y97.904 E-.20259
G1 X96.988 Y97.273 E-.11984
G1 X96.79 Y97.044 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.485 Y90.742 Z4.32 F18000
G1 X85.479 Y80.483 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.486 Y99.517 E.40285
G1 X83.854 Y99.517 E.03454
G1 X83.854 Y99.757 E.00508
G1 X82.625 Y99.757 E.02601
G1 X82.631 Y97.961 E.03801
G1 X82.652 Y97.215 E.0158
G1 X82.652 Y95.733 E.03136
G1 X82.625 Y95.024 E.01501
G1 X82.625 Y94.333 E.01463
G1 X82.652 Y93.605 E.01542
G1 X82.631 Y92.839 E.01621
G1 X82.621 Y90 E.0601
G1 X82.631 Y87.161 E.0601
G1 X82.652 Y86.395 E.01621
G1 X82.625 Y85.667 E.01542
G1 X82.625 Y84.976 E.01463
G1 X82.652 Y84.267 E.01501
G1 X82.652 Y82.785 E.03136
G1 X82.631 Y82.039 E.0158
G1 X82.625 Y80.243 E.03801
G1 X83.855 Y80.243 E.02604
G1 X83.856 Y80.483 E.00508
G1 X85.419 Y80.483 E.03307
M204 S10000
G1 X85.906 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.911 Y99.941 E.42081
G1 X84.277 Y99.941 E.03458
G1 X84.276 Y100.181 E.00508
G1 X82.199 Y100.181 E.04397
G1 X82.207 Y97.954 E.04713
G1 X82.228 Y97.209 E.01579
G1 X82.228 Y95.741 E.03107
G1 X82.201 Y95.032 E.01502
G1 X82.201 Y94.325 E.01496
G1 X82.228 Y93.603 E.01529
G1 X82.207 Y92.846 E.01603
G1 X82.197 Y90 E.06023
G1 X82.207 Y87.154 E.06024
G1 X82.228 Y86.397 E.01603
G1 X82.201 Y85.675 E.01529
G1 X82.201 Y84.968 E.01496
G1 X82.228 Y84.259 E.01502
G1 X82.228 Y82.791 E.03107
G1 X82.207 Y82.046 E.01579
G1 X82.199 Y79.819 E.04713
G1 X84.277 Y79.819 E.04398
G1 X84.278 Y80.059 E.00508
G1 X85.846 Y80.059 E.03319
M204 S250
G1 X86.319 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.307 Y81.171 E.02992
G1 X86.32 Y100.35 E.37724
G1 X84.685 Y100.35 E.03217
G1 X84.684 Y100.59 E.00472
G1 X81.788 Y100.59 E.05696
G1 X81.798 Y97.948 E.05197
G1 X81.818 Y97.203 E.01466
G1 X81.818 Y95.748 E.02861
G1 X81.792 Y95.039 E.01396
G1 X81.792 Y94.317 E.0142
G1 X81.819 Y93.601 E.0141
G1 X81.798 Y92.852 E.01473
G1 X81.787 Y90 E.0561
G1 X81.798 Y87.148 E.0561
G1 X81.819 Y86.399 E.01473
G1 X81.792 Y85.683 E.0141
G1 X81.792 Y84.961 E.0142
G1 X81.818 Y84.252 E.01396
G1 X81.818 Y82.797 E.02861
G1 X81.798 Y82.052 E.01466
G1 X81.788 Y79.41 E.05197
G1 X84.684 Y79.41 E.05695
G1 X84.685 Y79.65 E.00472
G1 X86.259 Y79.65 E.03095
; WIPE_START
M204 S6000
G1 X86.307 Y81.171 E-.28912
G1 X86.307 Y81.649 E-.09088
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.993 Y81.606 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.015 Y83.303 E.03592
G1 X83.283 Y83.627 E.00892
G1 X83.52 Y84.083 E.01085
G1 X83.644 Y84.538 E.00999
G1 X83.677 Y84.993 E.00966
G1 X83.609 Y85.448 E.00974
G1 X83.398 Y85.903 E.01062
G1 X83.014 Y86.347 E.01242
G1 X82.994 Y87.166 E.01734
G1 X82.986 Y90.551 E.07165
G1 X83.283 Y90.91 E.00987
G1 X83.52 Y91.366 E.01085
G1 X83.644 Y91.821 E.00999
G1 X83.677 Y92.276 E.00966
G1 X83.609 Y92.731 E.00974
G1 X83.398 Y93.186 E.01062
G1 X83.015 Y93.629 E.01239
G1 X82.988 Y94.34 E.01505
G1 X82.988 Y95.017 E.01434
G1 X83.015 Y95.726 E.01502
G1 X83.015 Y97.219 E.03161
G1 X82.997 Y97.849 E.01332
G1 X83.283 Y98.194 E.00949
G1 X83.52 Y98.649 E.01085
G1 X83.648 Y99.154 E.01103
G1 X85.123 Y99.154 E.03123
G1 X85.123 Y98.932 E.00469
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X85.123 Y99.154 E-.04207
G1 X83.648 Y99.154 E-.28036
G1 X83.573 Y98.86 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/74
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I1.044 J.625 P1  F18000
G1 X94.564 Y80.483 Z4.32
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X96.332 Y80.483 E.03744
G1 X96.333 Y80.243 E.00508
G1 X97.411 Y80.243 E.02281
G1 X97.411 Y81.703 E.0309
G1 X97.372 Y82.801 E.02324
G1 X97.407 Y83.744 E.01999
G1 X97.372 Y85.05 E.02765
G1 X97.372 Y86.423 E.02906
G1 X97.41 Y87.295 E.01848
G1 X97.377 Y88.756 E.03094
G1 X97.41 Y90 E.02633
G1 X97.377 Y91.243 E.02633
G1 X97.41 Y92.705 E.03095
G1 X97.372 Y93.577 E.01848
G1 X97.372 Y94.95 E.02906
G1 X97.407 Y96.256 E.02765
G1 X97.371 Y97.203 E.02008
G1 X97.411 Y98.107 E.01914
G1 X97.411 Y99.757 E.03491
G1 X96.333 Y99.757 E.02281
G1 X96.332 Y99.517 E.00508
G1 X94.564 Y99.517 E.03744
G1 X94.564 Y80.543 E.40158
M204 S10000
G1 X94.139 Y80.059 F18000
G1 F1500
M204 S500
G1 X95.909 Y80.059 E.03746
G1 X95.91 Y79.819 E.00508
G1 X97.835 Y79.819 E.04075
G1 X97.835 Y81.711 E.04004
G1 X97.796 Y82.8 E.02307
G1 X97.831 Y83.742 E.01995
G1 X97.796 Y85.055 E.02781
G1 X97.796 Y86.414 E.02875
G1 X97.835 Y87.29 E.01858
G1 X97.801 Y88.755 E.03102
G1 X97.834 Y90 E.02635
G1 X97.801 Y91.244 E.02635
G1 X97.835 Y92.71 E.03102
G1 X97.796 Y93.586 E.01858
G1 X97.796 Y94.945 E.02875
G1 X97.831 Y96.258 E.02781
G1 X97.796 Y97.202 E.02
G1 X97.835 Y98.098 E.01897
G1 X97.835 Y100.181 E.04409
G1 X95.91 Y100.181 E.04075
G1 X95.909 Y99.941 E.00508
G1 X94.139 Y99.941 E.03746
G1 X94.139 Y80.119 E.41954
M204 S250
G1 X93.73 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P65 R11
G1 F1500
M204 S500
G1 X95.501 Y79.65 E.03483
G1 X95.501 Y79.41 E.00472
G1 X98.244 Y79.41 E.05394
G1 X98.245 Y81.718 E.0454
G1 X98.206 Y82.8 E.02129
G1 X98.239 Y83.784 E.01937
G1 X98.234 Y83.975 E.00375
G1 X98.206 Y85.061 E.02137
G1 X98.206 Y86.405 E.02643
G1 X98.244 Y87.286 E.01736
G1 X98.21 Y88.755 E.02889
G1 X98.244 Y90 E.0245
G1 X98.21 Y91.245 E.02451
G1 X98.244 Y92.714 E.02889
G1 X98.206 Y93.595 E.01736
G1 X98.206 Y94.939 E.02643
G1 X98.234 Y96.025 E.02137
G1 X98.239 Y96.216 E.00375
G1 X98.206 Y97.201 E.01939
G1 X98.245 Y98.089 E.01748
G1 X98.244 Y100.59 E.0492
G1 X95.501 Y100.59 E.05394
G1 X95.501 Y100.35 E.00472
G1 X93.73 Y100.35 E.03483
G1 X93.73 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X95.501 Y79.65 E-.33664
G1 X95.501 Y79.422 E-.04336
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




G1 X96.544 Y80.576
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.199 Y80.576 E.00783
; WIPE_START
G1 X96.544 Y80.576 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.926 Y80.933 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X94.926 Y80.846 E.00183
G1 X96.182 Y80.846 E.02657
G1 X96.182 Y81.071 E.00476
G1 X96.312 Y81.071 E.00276
G1 X96.27 Y81.351 E.00599
G1 X96.3 Y81.807 E.00966
G1 X96.475 Y82.262 E.01032
G1 X96.859 Y82.717 E.01261
G1 X97.011 Y82.865 E.00449
G1 X97.044 Y83.746 E.01866
G1 X97.009 Y85.045 E.02751
G1 X97.009 Y86.431 E.02932
G1 X97.035 Y87.013 E.01234
G1 X96.773 Y87.269 E.00775
G1 X96.497 Y87.724 E.01126
G1 X96.338 Y88.179 E.01021
G1 X96.27 Y88.635 E.00974
G1 X96.3 Y89.09 E.00966
G1 X96.475 Y89.545 E.01032
G1 X96.859 Y90 E.01261
G1 X97.042 Y90.179 E.00542
G1 X97.014 Y91.243 E.02253
G1 X97.048 Y92.701 E.03088
G1 X97.009 Y93.569 E.01839
G1 X97.009 Y94.321 E.01592
G1 X96.773 Y94.552 E.007
G1 X96.497 Y95.007 E.01126
G1 X96.338 Y95.462 E.01021
G1 X96.27 Y95.918 E.00974
G1 X96.3 Y96.373 E.00966
G1 X96.475 Y96.828 E.01032
G1 X96.859 Y97.283 E.01261
G1 X97.019 Y97.439 E.00472
G1 X97.048 Y98.115 E.01432
G1 X97.048 Y98.929 E.01723
G1 X96.842 Y98.929 E.00437
M204 S10000
G1 X96.544 Y99.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.199 Y99.424 E.00783
; WIPE_START
G1 X96.544 Y99.424 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.683 Y92.841 Z4.44 F18000
G1 X85.437 Y80.483 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.437 Y99.517 E.40285
G1 X83.668 Y99.517 E.03745
G1 X83.668 Y99.757 E.00508
G1 X82.596 Y99.757 E.02268
G1 X82.628 Y95.844 E.08282
G1 X82.594 Y94.925 E.01946
G1 X82.629 Y93.599 E.02807
G1 X82.601 Y92.604 E.02106
G1 X82.592 Y90 E.05512
G1 X82.601 Y87.396 E.05513
G1 X82.629 Y86.401 E.02106
G1 X82.594 Y85.075 E.02807
G1 X82.628 Y84.156 E.01946
G1 X82.596 Y80.243 E.08282
G1 X83.668 Y80.243 E.02269
G1 X83.668 Y80.483 E.00508
G1 X85.377 Y80.483 E.03616
M204 S10000
G1 X85.861 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.861 Y99.941 E.42081
G1 X84.092 Y99.941 E.03746
G1 X84.091 Y100.181 E.00508
G1 X82.17 Y100.181 E.04066
G1 X82.204 Y95.852 E.09163
G1 X82.17 Y94.927 E.01958
G1 X82.204 Y93.599 E.02812
G1 X82.177 Y92.611 E.02093
G1 X82.168 Y90 E.05526
G1 X82.177 Y87.389 E.05526
G1 X82.204 Y86.401 E.02094
G1 X82.17 Y85.073 E.02811
G1 X82.204 Y84.148 E.01958
G1 X82.17 Y79.819 E.09163
G1 X84.091 Y79.819 E.04067
G1 X84.092 Y80.059 E.00508
G1 X85.801 Y80.059 E.03618
M204 S250
G1 X86.271 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.271 Y100.35 E.40715
G1 X84.5 Y100.35 E.03482
G1 X84.5 Y100.59 E.00472
G1 X81.759 Y100.59 E.0539
G1 X81.768 Y98.183 E.04734
G1 X81.795 Y97.203 E.01928
G1 X81.795 Y95.86 E.02642
G1 X81.76 Y94.929 E.01831
G1 X81.795 Y93.6 E.02616
G1 X81.768 Y92.617 E.01934
G1 X81.759 Y90 E.05147
G1 X81.768 Y87.383 E.05148
G1 X81.795 Y86.4 E.01934
G1 X81.76 Y85.071 E.02616
G1 X81.795 Y84.14 E.01831
G1 X81.795 Y82.797 E.02642
G1 X81.768 Y81.817 E.01928
G1 X81.759 Y79.41 E.04734
G1 X84.5 Y79.41 E.0539
G1 X84.5 Y79.65 E.00472
G1 X86.211 Y79.65 E.03364
; WIPE_START
M204 S6000
G1 X86.216 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.457 Y80.576 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.809 Y80.576 E.00775
M204 S10000
G1 X82.969 Y81.495 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.983 Y83.192 E.03592
G1 X83.503 Y84.083 E.02183
G1 X83.662 Y84.538 E.01021
G1 X83.73 Y84.993 E.00974
G1 X83.7 Y85.448 E.00966
G1 X83.525 Y85.903 E.01032
G1 X83.141 Y86.359 E.01261
G1 X82.984 Y86.697 E.0079
G1 X82.964 Y87.401 E.01491
G1 X82.956 Y90.427 E.06405
G1 X83.503 Y91.366 E.02298
G1 X83.662 Y91.821 E.01021
G1 X83.73 Y92.276 E.00974
G1 X83.7 Y92.731 E.00966
G1 X83.525 Y93.186 E.01032
G1 X83.141 Y93.642 E.01261
G1 X82.982 Y93.984 E.008
G1 X82.957 Y94.923 E.01988
G1 X82.991 Y95.839 E.01939
G1 X82.975 Y97.744 E.04033
G1 X83.503 Y98.649 E.02216
G1 X83.601 Y98.929 E.00628
G1 X83.819 Y98.929 E.00461
G1 X83.819 Y99.154 E.00476
G1 X85.073 Y99.154 E.02654
; WIPE_START
G1 X83.819 Y99.154 E-.23829
G1 X83.819 Y98.929 E-.04275
G1 X83.601 Y98.929 E-.04139
G1 X83.503 Y98.649 E-.05636
G1 X83.5 Y98.643 E-.00121
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.456 Y99.424 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.809 Y99.424 E.00774
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.456 Y99.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/74
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I1.048 J.618 P1  F18000
G1 X94.618 Y80.483 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.488 Y80.483 E.03957
G1 X96.488 Y80.243 E.00508
G1 X97.437 Y80.243 E.0201
G1 X97.432 Y81.946 E.03603
G1 X97.395 Y82.796 E.01803
G1 X97.438 Y83.964 E.02474
G1 X97.396 Y85.156 E.02524
G1 X97.396 Y86.421 E.02677
G1 X97.432 Y87.345 E.01958
G1 X97.4 Y88.668 E.028
G1 X97.439 Y90 E.02821
G1 X97.4 Y91.332 E.02821
G1 X97.432 Y92.655 E.028
G1 X97.396 Y93.579 E.01958
G1 X97.396 Y94.844 E.02677
G1 X97.438 Y96.036 E.02524
G1 X97.395 Y97.203 E.02474
G1 X97.432 Y98.054 E.01803
G1 X97.437 Y99.757 E.03603
G1 X96.488 Y99.757 E.02009
G1 X96.488 Y99.517 E.00508
G1 X94.616 Y99.517 E.0396
G1 X94.618 Y80.543 E.40158
M204 S10000
G1 X94.193 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.063 Y80.059 E.0396
G1 X96.064 Y79.819 E.00508
G1 X97.863 Y79.819 E.03808
G1 X97.856 Y81.955 E.04522
G1 X97.819 Y82.798 E.01785
G1 X97.863 Y83.964 E.0247
G1 X97.82 Y85.164 E.02541
G1 X97.82 Y86.412 E.02643
G1 X97.857 Y87.342 E.01969
G1 X97.825 Y88.667 E.02805
G1 X97.864 Y90 E.02823
G1 X97.825 Y91.333 E.02823
G1 X97.857 Y92.658 E.02805
G1 X97.82 Y93.588 E.01969
G1 X97.82 Y94.836 E.02643
G1 X97.863 Y96.036 E.02541
G1 X97.819 Y97.202 E.0247
G1 X97.856 Y98.044 E.01785
G1 X97.862 Y100.181 E.04522
G1 X96.064 Y100.181 E.03807
G1 X96.063 Y99.941 E.00508
G1 X94.192 Y99.941 E.03961
G1 X94.205 Y85.171 E.31262
G1 X94.193 Y80.119 E.10692
M204 S250
G1 X93.783 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.654 Y79.65 E.03682
G1 X95.654 Y79.41 E.00472
G1 X98.273 Y79.41 E.05151
G1 X98.266 Y81.965 E.05025
G1 X98.229 Y82.799 E.01642
G1 X98.272 Y83.964 E.02292
G1 X98.229 Y85.171 E.02376
G1 X98.229 Y86.404 E.02426
G1 X98.266 Y87.339 E.0184
G1 X98.234 Y88.666 E.02611
G1 X98.273 Y90 E.02626
G1 X98.234 Y91.334 E.02626
G1 X98.266 Y92.661 E.02611
G1 X98.229 Y93.596 E.0184
G1 X98.229 Y94.829 E.02426
G1 X98.272 Y96.036 E.02376
G1 X98.229 Y97.201 E.02292
G1 X98.266 Y98.035 E.01643
G1 X98.273 Y100.59 E.05025
G1 X95.654 Y100.59 E.05149
G1 X95.654 Y100.35 E.00472
G1 X93.782 Y100.35 E.03682
G1 X93.795 Y85.171 E.29856
G1 X93.783 Y79.71 E.10742
; WIPE_START
M204 S6000
G1 X95.654 Y79.65 E-.35581
G1 X95.654 Y79.523 E-.02419
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




G1 X96.7 Y80.576
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.224 Y80.576 E.00628
; WIPE_START
G1 X96.7 Y80.576 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.981 Y81.19 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X94.981 Y80.846 E.00727
G1 X96.334 Y80.846 E.02865
G1 X96.21 Y81.351 E.01101
G1 X96.199 Y81.807 E.00964
G1 X96.331 Y82.262 E.01003
G1 X96.703 Y82.717 E.01245
G1 X97.04 Y83.012 E.00948
G1 X97.075 Y83.965 E.02017
G1 X97.033 Y85.15 E.02509
G1 X97.033 Y86.428 E.02706
G1 X97.058 Y87.065 E.01349
G1 X96.825 Y87.269 E.00655
G1 X96.508 Y87.724 E.01175
G1 X96.313 Y88.179 E.01048
G1 X96.21 Y88.635 E.00988
G1 X96.199 Y89.09 E.00964
M73 P66 R11
G1 X96.331 Y89.545 E.01003
G1 X96.703 Y90 E.01245
G1 X97.067 Y90.319 E.01024
G1 X97.038 Y91.331 E.02143
G1 X97.069 Y92.652 E.02796
G1 X97.033 Y93.572 E.01949
G1 X97.033 Y94.37 E.01688
G1 X96.825 Y94.552 E.00585
G1 X96.508 Y95.007 E.01175
G1 X96.313 Y95.462 E.01048
G1 X96.21 Y95.918 E.00988
G1 X96.199 Y96.373 E.00964
G1 X96.331 Y96.828 E.01003
G1 X96.703 Y97.283 E.01245
G1 X97.049 Y97.586 E.00972
G1 X97.069 Y98.063 E.0101
G1 X97.072 Y98.929 E.01833
G1 X96.718 Y98.929 E.00749
M204 S10000
G1 X96.7 Y99.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.224 Y99.424 E.00627
; WIPE_START
G1 X96.7 Y99.424 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.786 Y92.872 Z4.56 F18000
G1 X85.385 Y80.483 Z4.56
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.385 Y99.517 E.40285
G1 X83.512 Y99.517 E.03965
G1 X83.512 Y99.757 E.00508
G1 X82.567 Y99.757 E.02
G1 X82.572 Y98.431 E.02806
G1 X82.605 Y97.215 E.02575
G1 X82.605 Y95.955 E.02666
G1 X82.562 Y94.817 E.0241
G1 X82.605 Y93.604 E.02569
G1 X82.572 Y92.369 E.02614
G1 X82.563 Y90.001 E.05013
G1 X82.572 Y87.631 E.05017
G1 X82.605 Y86.395 E.02616
G1 X82.562 Y85.236 E.02456
G1 X82.605 Y84.044 E.02524
G1 X82.605 Y82.785 E.02663
G1 X82.572 Y81.569 E.02575
G1 X82.567 Y80.243 E.02806
G1 X83.517 Y80.243 E.02011
G1 X83.518 Y80.483 E.00508
G1 X85.325 Y80.483 E.03824
M204 S10000
G1 X85.809 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.809 Y99.941 E.42081
G1 X83.937 Y99.941 E.03964
G1 X83.937 Y100.181 E.00508
G1 X82.141 Y100.181 E.038
G1 X82.181 Y95.963 E.08927
G1 X82.138 Y94.817 E.02426
G1 X82.181 Y93.602 E.02573
G1 X82.147 Y92.376 E.02597
G1 X82.139 Y90.001 E.05027
G1 X82.147 Y87.624 E.0503
G1 X82.181 Y86.397 E.02599
G1 X82.138 Y85.236 E.0246
G1 X82.181 Y84.036 E.0254
G1 X82.141 Y79.819 E.08926
G1 X83.939 Y79.819 E.03805
G1 X83.94 Y80.059 E.00508
G1 X85.749 Y80.059 E.03829
M204 S250
G1 X86.219 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.219 Y100.35 E.40715
G1 X84.346 Y100.35 E.03683
G1 X84.347 Y100.59 E.00472
G1 X81.731 Y100.59 E.05145
G1 X81.771 Y95.971 E.09086
G1 X81.728 Y94.818 E.02269
G1 X81.772 Y93.601 E.02395
G1 X81.738 Y92.382 E.02398
G1 X81.73 Y90.001 E.04683
G1 X81.738 Y87.618 E.04687
G1 X81.772 Y86.399 E.02399
G1 X81.728 Y85.236 E.02289
G1 X81.771 Y84.029 E.02376
G1 X81.731 Y79.41 E.09086
G1 X84.346 Y79.41 E.05145
G1 X84.348 Y79.65 E.00472
G1 X86.159 Y79.65 E.03562
; WIPE_START
M204 S6000
G1 X86.164 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.306 Y80.576 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.78 Y80.576 E.0063
M204 S10000
G1 X82.934 Y81.519 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.968 Y83.216 E.03592
G1 X83.175 Y83.627 E.00975
G1 X83.492 Y84.083 E.01175
G1 X83.687 Y84.538 E.01048
G1 X83.79 Y84.993 E.00988
G1 X83.801 Y85.448 E.00964
G1 X83.669 Y85.903 E.01003
G1 X83.297 Y86.359 E.01245
G1 X82.955 Y86.896 E.01348
G1 X82.934 Y87.636 E.01568
G1 X82.928 Y90.419 E.0589
G1 X83.175 Y90.91 E.01164
G1 X83.492 Y91.366 E.01175
G1 X83.687 Y91.821 E.01048
G1 X83.79 Y92.276 E.00988
G1 X83.801 Y92.731 E.00964
G1 X83.669 Y93.186 E.01003
G1 X83.297 Y93.642 E.01245
G1 X82.948 Y94.19 E.01376
G1 X82.925 Y94.817 E.01328
G1 X82.968 Y95.948 E.02397
G1 X82.953 Y97.753 E.03819
G1 X83.175 Y98.194 E.01044
G1 X83.492 Y98.649 E.01175
G1 X83.612 Y98.929 E.00645
G1 X83.662 Y98.929 E.00106
G1 X83.662 Y99.154 E.00476
G1 X85.022 Y99.154 E.02879
G1 X85.022 Y99.092 E.00131
; WIPE_START
G1 X85.022 Y99.154 E-.01176
G1 X83.662 Y99.154 E-.25841
G1 X83.662 Y98.929 E-.04275
G1 X83.612 Y98.929 E-.00951
G1 X83.493 Y98.65 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.3 Y99.424 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.78 Y99.424 E.00622
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.3 Y99.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 35/74
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I1.043 J.627 P1  F18000
G1 X94.674 Y80.483 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.619 Y80.483 E.04117
G1 X96.619 Y80.243 E.00508
G1 X97.458 Y80.243 E.01776
G1 X97.452 Y82.021 E.03762
G1 X97.419 Y82.793 E.01635
G1 X97.46 Y84.181 E.02941
G1 X97.419 Y85.266 E.02298
G1 X97.419 Y86.423 E.02448
G1 X97.452 Y87.167 E.01577
G1 X97.424 Y88.581 E.02993
G1 X97.465 Y90 E.03005
G1 X97.424 Y91.422 E.0301
G1 X97.453 Y92.617 E.02531
G1 X97.419 Y93.582 E.02043
G1 X97.419 Y94.73 E.0243
G1 X97.46 Y96.089 E.02877
G1 X97.418 Y97.203 E.02361
G1 X97.452 Y97.98 E.01646
G1 X97.46 Y99.757 E.0376
G1 X96.619 Y99.757 E.01782
G1 X96.619 Y99.517 E.00508
G1 X94.674 Y99.517 E.04117
G1 X94.685 Y93.044 E.137
M73 P66 R10
G1 X94.671 Y89.768 E.06933
G1 X94.682 Y85.908 E.0817
G1 X94.7 Y85.43 E.01013
G1 X94.682 Y84.853 E.01222
G1 X94.674 Y80.543 E.09122
M204 S10000
G1 X94.249 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.194 Y80.059 E.04117
G1 X96.194 Y79.819 E.00508
G1 X97.883 Y79.819 E.03576
G1 X97.877 Y82.031 E.04681
G1 X97.843 Y82.796 E.0162
G1 X97.884 Y84.183 E.02938
G1 X97.843 Y85.274 E.02312
G1 X97.843 Y86.414 E.02411
G1 X97.876 Y87.162 E.01586
G1 X97.849 Y88.579 E.02999
G1 X97.889 Y90 E.03009
G1 X97.849 Y91.423 E.03012
G1 X97.877 Y92.619 E.02534
G1 X97.843 Y93.589 E.02054
G1 X97.843 Y94.723 E.02401
G1 X97.884 Y96.09 E.02894
G1 X97.843 Y97.202 E.02355
G1 X97.877 Y97.97 E.01627
G1 X97.887 Y100.181 E.0468
G1 X96.194 Y100.181 E.03583
G1 X96.194 Y99.941 E.00508
G1 X94.249 Y99.941 E.04117
G1 X94.261 Y93.045 E.14596
G1 X94.247 Y89.769 E.06934
G1 X94.258 Y85.9 E.08189
G1 X94.275 Y85.429 E.00998
G1 X94.258 Y84.86 E.01204
G1 X94.249 Y80.119 E.10034
M204 S250
G1 X93.839 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.784 Y79.65 E.03826
G1 X95.784 Y79.41 E.00472
G1 X98.294 Y79.41 E.04936
G1 X98.286 Y82.04 E.05173
G1 X98.253 Y82.798 E.01493
G1 X98.294 Y84.184 E.02727
G1 X98.253 Y85.282 E.0216
G1 X98.253 Y86.405 E.02208
G1 X98.286 Y87.157 E.01482
G1 X98.258 Y88.577 E.02793
G1 X98.299 Y90 E.028
G1 X98.258 Y91.423 E.02801
G1 X98.287 Y92.621 E.02357
G1 X98.253 Y93.596 E.01919
G1 X98.253 Y94.717 E.02205
G1 X98.294 Y96.092 E.02705
G1 X98.253 Y97.201 E.02183
G1 X98.286 Y97.96 E.01495
G1 X98.298 Y100.59 E.05173
G1 X95.784 Y100.59 E.04944
G1 X95.784 Y100.35 E.00472
G1 X93.839 Y100.35 E.03826
G1 X93.851 Y93.045 E.14367
G1 X93.838 Y89.769 E.06444
G1 X93.848 Y85.892 E.07627
G1 X93.866 Y85.427 E.00914
G1 X93.848 Y84.867 E.01103
G1 X93.839 Y79.71 E.10143
; WIPE_START
M204 S6000
G1 X95.784 Y79.65 E-.36977
G1 X95.784 Y79.596 E-.01023
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




G1 X95.038 Y81.275
G1 Z4.28
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.037 Y80.846 E.00907
G1 X96.306 Y80.846 E.02684
G1 X96.28 Y80.896 E.00119
G1 X96.085 Y81.807 E.01971
G1 X96.163 Y82.262 E.00977
G1 X96.517 Y82.717 E.0122
G1 X97.066 Y83.143 E.01472
G1 X97.097 Y84.18 E.02196
G1 X97.056 Y85.26 E.02287
G1 X97.056 Y86.431 E.02479
G1 X97.086 Y87.105 E.0143
G1 X96.875 Y87.269 E.00565
G1 X96.511 Y87.724 E.01233
G1 X96.28 Y88.179 E.0108
G1 X96.085 Y89.09 E.01971
G1 X96.163 Y89.545 E.00977
G1 X96.517 Y90 E.0122
G1 X97.089 Y90.444 E.01534
G1 X97.061 Y91.421 E.02068
G1 X97.09 Y92.615 E.02528
G1 X97.056 Y93.575 E.02034
G1 X97.056 Y94.412 E.0177
G1 X96.875 Y94.552 E.00485
G1 X96.511 Y95.007 E.01233
G1 X96.28 Y95.462 E.0108
G1 X96.085 Y96.373 E.01971
G1 X96.163 Y96.828 E.00977
G1 X96.517 Y97.283 E.0122
G1 X97.078 Y97.718 E.01503
G1 X97.096 Y99.394 E.03546
G1 X97.075 Y99.394 E.00045
; WIPE_START
G1 X97.096 Y99.394 E-.00404
G1 X97.078 Y97.718 E-.31835
G1 X96.838 Y97.533 E-.05761
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.567 Y91.207 Z4.68 F18000
G1 X85.327 Y80.483 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.327 Y99.517 E.40285
G1 X83.384 Y99.517 E.04113
G1 X83.384 Y99.757 E.00508
M73 P67 R10
G1 X82.538 Y99.757 E.01791
G1 X82.542 Y98.666 E.02309
G1 X82.581 Y97.215 E.03073
G1 X82.581 Y96.066 E.0243
G1 X82.541 Y94.981 E.02298
G1 X82.582 Y93.601 E.02923
G1 X82.542 Y92.134 E.03106
G1 X82.535 Y90.001 E.04516
G1 X82.542 Y87.866 E.04519
G1 X82.582 Y86.399 E.03106
G1 X82.541 Y85.019 E.02922
G1 X82.581 Y83.934 E.02298
G1 X82.581 Y82.785 E.0243
G1 X82.542 Y81.334 E.03073
G1 X82.538 Y80.243 E.02309
G1 X83.386 Y80.243 E.01795
G1 X83.387 Y80.483 E.00508
G1 X85.267 Y80.483 E.03978
M204 S10000
G1 X85.752 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.752 Y99.941 E.42081
G1 X83.808 Y99.941 E.04114
G1 X83.808 Y100.181 E.00508
G1 X82.112 Y100.181 E.03589
G1 X82.117 Y98.659 E.0322
G1 X82.157 Y97.209 E.03072
G1 X82.157 Y96.074 E.02401
G1 X82.116 Y94.983 E.02312
G1 X82.157 Y93.601 E.02927
G1 X82.117 Y92.141 E.03091
G1 X82.11 Y90.001 E.04529
G1 X82.117 Y87.859 E.04533
G1 X82.157 Y86.399 E.03092
G1 X82.116 Y85.017 E.02927
G1 X82.157 Y83.926 E.02312
G1 X82.157 Y82.791 E.02401
G1 X82.117 Y81.341 E.03072
G1 X82.112 Y79.819 E.0322
G1 X83.809 Y79.819 E.03591
G1 X83.81 Y80.059 E.00508
G1 X85.692 Y80.059 E.03983
M204 S250
G1 X86.162 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.149 Y86.954 E.14367
G1 X86.162 Y100.35 E.26348
G1 X84.217 Y100.35 E.03825
G1 X84.217 Y100.59 E.00472
G1 X81.702 Y100.59 E.04947
G1 X81.708 Y98.653 E.0381
G1 X81.748 Y97.203 E.02853
G1 X81.748 Y96.082 E.02205
G1 X81.707 Y94.984 E.0216
G1 X81.748 Y93.6 E.02724
G1 X81.708 Y92.147 E.02859
G1 X81.701 Y90.001 E.04221
G1 X81.708 Y87.853 E.04224
G1 X81.748 Y86.4 E.02859
G1 X81.707 Y85.016 E.02724
G1 X81.748 Y83.918 E.0216
G1 X81.748 Y82.797 E.02205
G1 X81.708 Y81.347 E.02853
G1 X81.702 Y79.41 E.0381
G1 X84.217 Y79.41 E.04947
G1 X84.217 Y79.65 E.00472
G1 X86.102 Y79.65 E.03706
; WIPE_START
M204 S6000
G1 X86.115 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.91 Y81.528 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.944 Y83.224 E.03592
G1 X83.125 Y83.627 E.00935
G1 X83.489 Y84.083 E.01233
G1 X83.72 Y84.538 E.0108
G1 X83.915 Y85.448 E.01971
G1 X83.837 Y85.903 E.00977
G1 X83.484 Y86.359 E.0122
G1 X82.928 Y87.019 E.01826
G1 X82.904 Y87.871 E.01805
G1 X82.899 Y90.406 E.05365
G1 X83.125 Y90.91 E.01171
G1 X83.489 Y91.366 E.01233
G1 X83.72 Y91.821 E.0108
G1 X83.915 Y92.731 E.01971
G1 X83.837 Y93.186 E.00977
G1 X83.484 Y93.642 E.0122
G1 X82.924 Y94.306 E.01839
G1 X82.904 Y94.98 E.01426
G1 X82.944 Y96.06 E.02287
G1 X82.929 Y97.757 E.03594
G1 X83.125 Y98.194 E.01012
G1 X83.489 Y98.649 E.01233
G1 X83.73 Y99.154 E.01185
G1 X84.965 Y99.154 E.02613
G1 X84.965 Y98.691 E.00979
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X84.965 Y99.154 E-.0879
G1 X83.73 Y99.154 E-.23453
G1 X83.6 Y98.88 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/74
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I1.041 J.63 P1  F18000
G1 X94.734 Y80.483 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X96.73 Y80.483 E.04223
G1 X96.73 Y80.243 E.00508
G1 X97.478 Y80.243 E.01584
G1 X97.473 Y82.096 E.03922
G1 X97.442 Y82.796 E.01483
G1 X97.48 Y83.816 E.0216
G1 X97.48 Y84.387 E.01207
G1 X97.443 Y85.378 E.02098
G1 X97.443 Y86.416 E.02198
G1 X97.474 Y87.421 E.02129
G1 X97.448 Y88.489 E.02261
G1 X97.49 Y90 E.03199
G1 X97.448 Y91.511 E.03199
G1 X97.474 Y92.579 E.02261
G1 X97.443 Y93.584 E.02128
G1 X97.443 Y94.622 E.02198
G1 X97.48 Y95.613 E.02098
G1 X97.48 Y96.184 E.01207
G1 X97.442 Y97.203 E.0216
G1 X97.473 Y97.905 E.01487
G1 X97.484 Y99.757 E.03918
G1 X96.73 Y99.757 E.01596
G1 X96.73 Y99.517 E.00508
G1 X94.732 Y99.517 E.04228
G1 X94.732 Y90.004 E.20135
G1 X94.743 Y86.416 E.07594
G1 X94.77 Y85.686 E.01547
G1 X94.742 Y84.804 E.01866
G1 X94.734 Y80.543 E.09019
M204 S10000
G1 X94.309 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.306 Y80.059 E.04226
G1 X96.306 Y79.819 E.00508
G1 X97.904 Y79.819 E.03381
G1 X97.897 Y82.106 E.0484
G1 X97.866 Y82.798 E.01465
G1 X97.904 Y83.809 E.02141
G1 X97.904 Y84.395 E.01241
G1 X97.867 Y85.386 E.02099
G1 X97.867 Y86.41 E.02167
G1 X97.898 Y87.42 E.02139
G1 X97.872 Y88.488 E.02262
G1 X97.914 Y90 E.03201
G1 X97.872 Y91.512 E.03201
G1 X97.898 Y92.58 E.02262
G1 X97.867 Y93.59 E.02139
G1 X97.867 Y94.614 E.02167
G1 X97.904 Y95.605 E.02099
G1 X97.904 Y96.191 E.01241
G1 X97.866 Y97.202 E.02141
G1 X97.897 Y97.895 E.01468
G1 X97.911 Y100.181 E.04839
G1 X96.306 Y100.181 E.03396
G1 X96.306 Y99.941 E.00508
G1 X94.308 Y99.941 E.04229
G1 X94.308 Y90.002 E.21036
G1 X94.318 Y86.407 E.07608
G1 X94.345 Y85.684 E.01532
G1 X94.318 Y84.811 E.01848
G1 X94.309 Y80.119 E.09931
M204 S250
G1 X93.899 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.897 Y79.65 E.0393
G1 X95.898 Y79.41 E.00472
G1 X98.319 Y79.41 E.04762
G1 X98.314 Y79.622 E.00418
G1 X98.306 Y82.116 E.04904
G1 X98.276 Y82.799 E.01346
G1 X98.313 Y83.801 E.01972
G1 X98.313 Y84.402 E.01183
G1 X98.276 Y85.393 E.0195
G1 X98.276 Y86.403 E.01987
G1 X98.307 Y87.418 E.01997
G1 X98.282 Y88.487 E.02104
G1 X98.324 Y90 E.02976
G1 X98.282 Y91.513 E.02976
G1 X98.307 Y92.582 E.02104
G1 X98.276 Y93.597 E.01997
G1 X98.276 Y94.607 E.01987
G1 X98.313 Y95.598 E.0195
G1 X98.313 Y96.199 E.01183
G1 X98.276 Y97.201 E.01972
G1 X98.306 Y97.885 E.01346
G1 X98.323 Y100.59 E.05321
G1 X95.898 Y100.59 E.0477
G1 X95.897 Y100.35 E.00472
G1 X93.899 Y100.35 E.03931
G1 X93.899 Y90.001 E.20356
G1 X93.909 Y86.399 E.07084
G1 X93.936 Y85.683 E.0141
G1 X93.909 Y84.818 E.01702
G1 X93.899 Y79.71 E.10047
; WIPE_START
M204 S6000
G1 X95.897 Y79.65 E-.37979
G1 X95.897 Y79.649 E-.00021
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




G1 X95.099 Y81.372
G1 Z4.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.098 Y80.846 E.01112
G1 X96.269 Y80.846 E.02479
G1 X96.24 Y80.896 E.00122
G1 X95.956 Y81.807 E.02018
G1 X95.96 Y82.262 E.00963
G1 X96.27 Y82.717 E.01166
G1 X97.095 Y83.239 E.02066
G1 X97.117 Y84.38 E.02416
G1 X97.08 Y85.371 E.02099
G1 X97.08 Y86.422 E.02224
G1 X97.102 Y87.142 E.01525
G1 X96.923 Y87.269 E.00466
G1 X96.508 Y87.724 E.01303
G1 X96.24 Y88.179 E.01118
G1 X95.956 Y89.09 E.02018
G1 X95.96 Y89.545 E.00963
G1 X96.27 Y90 E.01166
G1 X97.112 Y90.534 E.02111
G1 X97.085 Y91.51 E.02067
G1 X97.111 Y92.578 E.0226
G1 X97.08 Y93.578 E.02119
G1 X97.08 Y94.441 E.01825
G1 X96.923 Y94.552 E.00408
G1 X96.508 Y95.007 E.01303
G1 X96.24 Y95.462 E.01118
G1 X95.956 Y96.373 E.02018
G1 X95.96 Y96.828 E.00963
G1 X96.27 Y97.283 E.01166
G1 X97.105 Y97.812 E.02093
G1 X97.119 Y99.394 E.03348
G1 X97.092 Y99.394 E.00056
G1 X97.092 Y99.305 E.00187
; WIPE_START
G1 X97.092 Y99.394 E-.01682
G1 X97.119 Y99.394 E-.00506
G1 X97.105 Y97.812 E-.30054
G1 X96.849 Y97.65 E-.05758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.734 Y90.099 Z4.8 F18000
G1 X95.116 Y85.915 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1200
M204 S6000
G1 X95.097 Y99.092 E.22351
; WIPE_START
G1 X95.1 Y97.092 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.212 Y90.524 Z4.8 F18000
G1 X85.268 Y80.483 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.268 Y99.517 E.40285
G1 X83.269 Y99.517 E.04232
G1 X83.269 Y99.757 E.00508
G1 X82.511 Y99.757 E.01604
G1 X82.512 Y98.9 E.01814
G1 X82.558 Y97.215 E.03568
G1 X82.558 Y96.178 E.02195
G1 X82.521 Y95.187 E.02098
G1 X82.521 Y94.616 E.01207
G1 X82.558 Y93.605 E.02142
G1 X82.512 Y91.899 E.03612
G1 X82.512 Y88.1 E.08042
G1 X82.558 Y86.395 E.03609
G1 X82.521 Y85.384 E.02142
G1 X82.521 Y84.813 E.01207
G1 X82.558 Y83.822 E.02098
G1 X82.558 Y82.785 E.02195
G1 X82.512 Y81.1 E.03568
G1 X82.511 Y80.243 E.01814
G1 X83.269 Y80.243 E.01604
G1 X83.269 Y80.483 E.00508
G1 X85.208 Y80.483 E.04105
M204 S10000
G1 X85.693 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.693 Y99.941 E.42081
G1 X83.693 Y99.941 E.04232
G1 X83.693 Y100.181 E.00508
G1 X82.087 Y100.181 E.03401
G1 X82.087 Y98.894 E.02724
M73 P68 R10
G1 X82.134 Y97.209 E.03568
G1 X82.134 Y96.186 E.02165
G1 X82.097 Y95.195 E.02099
G1 X82.097 Y94.609 E.01241
G1 X82.134 Y93.603 E.0213
G1 X82.087 Y91.906 E.03594
G1 X82.087 Y88.094 E.08068
G1 X82.134 Y86.397 E.03593
G1 X82.097 Y85.391 E.0213
G1 X82.097 Y84.805 E.01241
G1 X82.134 Y83.814 E.02099
G1 X82.134 Y82.791 E.02165
G1 X82.087 Y81.106 E.03568
G1 X82.087 Y79.819 E.02724
G1 X83.693 Y79.819 E.03401
G1 X83.693 Y80.059 E.00508
G1 X85.633 Y80.059 E.04105
M204 S250
G1 X86.102 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.102 Y100.35 E.40715
G1 X84.103 Y100.35 E.03932
G1 X84.103 Y100.59 E.00472
G1 X81.677 Y100.59 E.04771
G1 X81.678 Y98.888 E.03348
G1 X81.724 Y97.203 E.03315
G1 X81.724 Y96.193 E.01986
G1 X81.687 Y95.202 E.0195
G1 X81.687 Y94.601 E.01183
G1 X81.725 Y93.601 E.01968
G1 X81.678 Y91.912 E.03324
G1 X81.678 Y88.088 E.07521
G1 X81.725 Y86.399 E.03323
G1 X81.687 Y85.399 E.01968
G1 X81.687 Y84.798 E.01183
G1 X81.724 Y83.807 E.0195
G1 X81.724 Y82.797 E.01986
G1 X81.678 Y81.112 E.03315
G1 X81.677 Y79.41 E.03348
G1 X84.103 Y79.41 E.04771
G1 X84.103 Y79.65 E.00472
G1 X86.042 Y79.65 E.03814
; WIPE_START
M204 S6000
G1 X86.048 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.892 Y81.733 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.921 Y83.43 E.03591
G1 X83.077 Y83.627 E.00534
G1 X83.492 Y84.083 E.01303
G1 X83.76 Y84.538 E.01118
G1 X84.044 Y85.448 E.02018
G1 X84.04 Y85.903 E.00963
G1 X83.73 Y86.359 E.01166
G1 X82.998 Y86.814 E.01824
G1 X82.906 Y86.963 E.00373
G1 X82.874 Y88.105 E.02416
G1 X82.874 Y90.654 E.05396
G1 X83.077 Y90.91 E.00692
G1 X83.492 Y91.366 E.01303
G1 X83.76 Y91.821 E.01118
G1 X84.044 Y92.731 E.02018
G1 X84.04 Y93.186 E.00963
G1 X83.73 Y93.642 E.01166
G1 X82.998 Y94.097 E.01824
G1 X82.897 Y94.261 E.00407
G1 X82.884 Y95.18 E.01946
G1 X82.921 Y96.171 E.02099
G1 X82.9 Y97.97 E.03808
G1 X83.077 Y98.194 E.00604
G1 X83.492 Y98.649 E.01303
G1 X83.776 Y99.154 E.01226
G1 X84.539 Y99.154 E.01615
G1 X84.537 Y98.22 E.01977
; WIPE_START
G1 X84.539 Y99.154 E-.17748
G1 X83.776 Y99.154 E-.14495
G1 X83.627 Y98.889 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.903 Y99.152 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1200
M204 S6000
G1 X84.903 Y80.908 E.30945
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.903 Y82.908 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/74
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I.29 J1.182 P1  F18000
G1 X94.797 Y80.483 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.831 Y80.483 E.04305
G1 X96.831 Y80.243 E.00508
G1 X97.507 Y80.243 E.01432
G1 X97.493 Y82.169 E.04076
G1 X97.465 Y82.796 E.01329
G1 X97.499 Y83.706 E.01926
G1 X97.466 Y86.414 E.05733
G1 X97.494 Y87.459 E.02212
G1 X97.472 Y88.395 E.0198
G1 X97.513 Y90 E.03399
G1 X97.472 Y91.605 E.03399
G1 X97.494 Y92.541 E.0198
G1 X97.466 Y93.586 E.02212
G1 X97.466 Y94.511 E.01959
G1 X97.499 Y95.392 E.01866
G1 X97.499 Y96.294 E.01909
G1 X97.465 Y97.203 E.01926
G1 X97.493 Y97.831 E.0133
G1 X97.507 Y99.757 E.04076
G1 X96.831 Y99.757 E.01432
G1 X96.831 Y99.517 E.00508
G1 X94.796 Y99.517 E.04306
G1 X94.803 Y86.923 E.26656
G1 X94.84 Y85.941 E.02078
G1 X94.803 Y84.756 E.0251
G1 X94.797 Y80.543 E.08916
M204 S10000
G1 X94.372 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.407 Y80.059 E.04306
G1 X96.407 Y79.819 E.00508
G1 X97.935 Y79.819 E.03235
G1 X97.917 Y82.18 E.04997
G1 X97.89 Y82.798 E.01309
G1 X97.923 Y83.698 E.01907
G1 X97.89 Y86.409 E.05737
G1 X97.919 Y87.459 E.02223
G1 X97.896 Y88.396 E.01985
G1 X97.938 Y90 E.03396
G1 X97.896 Y91.604 E.03396
G1 X97.919 Y92.542 E.01985
G1 X97.89 Y93.591 E.02223
G1 X97.89 Y94.503 E.0193
G1 X97.923 Y95.384 E.01866
G1 X97.923 Y96.302 E.01942
G1 X97.89 Y97.202 E.01906
G1 X97.917 Y97.82 E.01309
G1 X97.935 Y100.181 E.04997
G1 X96.407 Y100.181 E.03235
G1 X96.407 Y99.941 E.00508
G1 X94.372 Y99.941 E.04307
G1 X94.379 Y86.915 E.27571
G1 X94.415 Y85.94 E.02064
G1 X94.379 Y84.763 E.02493
G1 X94.372 Y80.119 E.09828
M204 S250
G1 X93.963 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.997 Y79.65 E.04002
G1 X95.997 Y79.41 E.00472
G1 X98.347 Y79.41 E.04622
G1 X98.326 Y82.191 E.05469
G1 X98.3 Y82.799 E.01198
G1 X98.333 Y83.69 E.01754
G1 X98.3 Y86.403 E.05336
G1 X98.328 Y87.458 E.02076
G1 X98.306 Y88.397 E.01848
G1 X98.348 Y90 E.03153
G1 X98.306 Y91.603 E.03153
G1 X98.328 Y92.542 E.01848
G1 X98.3 Y93.597 E.02076
G1 X98.3 Y94.496 E.01767
G1 X98.333 Y95.377 E.01734
G1 X98.333 Y96.31 E.01835
G1 X98.3 Y97.201 E.01754
G1 X98.326 Y97.809 E.01198
G1 X98.347 Y100.59 E.05469
G1 X95.997 Y100.59 E.04622
G1 X95.997 Y100.35 E.00472
G1 X93.962 Y100.35 E.04002
G1 X93.97 Y86.907 E.26442
G1 X94.006 Y85.939 E.01906
G1 X93.97 Y84.769 E.02301
G1 X93.963 Y79.71 E.09951
; WIPE_START
M204 S6000
G1 X95.962 Y79.651 E-.38
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




G1 X95.17 Y80.855
G1 Z4.52
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1200
M204 S6000
G1 X95.175 Y84.75 E.06607
G1 X95.194 Y85.942 E.02022
G1 X95.171 Y90 E.06884
G1 X95.17 Y99.083 E.15408
; WIPE_START
G1 X95.17 Y97.083 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.677 Y99.154 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.14 Y99.154 E.00981
G1 X97.131 Y97.92 E.02611
G1 X96.82 Y97.738 E.00762
G1 X95.844 Y97.283 E.0228
G1 X95.696 Y96.828 E.01013
G1 X95.809 Y96.373 E.00993
G1 X96.191 Y95.462 E.0209
G1 X96.496 Y95.007 E.01161
G1 X96.968 Y94.552 E.01387
G1 X97.103 Y94.473 E.00332
G1 X97.103 Y93.581 E.01888
G1 X97.131 Y92.54 E.02204
G1 X97.109 Y91.605 E.0198
G1 X97.133 Y90.639 E.02046
G1 X96.82 Y90.455 E.00768
G1 X95.844 Y90 E.0228
G1 X95.696 Y89.545 E.01013
G1 X95.809 Y89.09 E.00993
G1 X96.191 Y88.179 E.0209
G1 X96.496 Y87.724 E.01161
G1 X96.968 Y87.269 E.01387
G1 X97.124 Y87.178 E.00382
G1 X97.103 Y86.417 E.01611
G1 X97.136 Y83.71 E.05729
G1 X97.123 Y83.349 E.00765
G1 X96.82 Y83.172 E.00742
G1 X95.844 Y82.717 E.0228
G1 X95.696 Y82.262 E.01013
G1 X95.809 Y81.807 E.00993
G1 X96.224 Y80.846 E.02214
G1 X97.14 Y80.846 E.01939
G1 X97.134 Y81.627 E.01653
; WIPE_START
G1 X97.14 Y80.846 E-.14838
G1 X96.224 Y80.846 E-.17405
G1 X96.104 Y81.124 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.484 Y80.676 Z4.92 F18000
G1 X85.205 Y80.483 Z4.92
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X85.205 Y99.517 E.40285
G1 X83.172 Y99.517 E.04302
G1 X83.172 Y99.757 E.00508
G1 X82.488 Y99.757 E.01448
G1 X82.488 Y98.907 E.01798
G1 X82.534 Y97.215 E.03584
G1 X82.501 Y94.506 E.05733
G1 X82.535 Y93.608 E.01902
G1 X82.486 Y91.414 E.04644
G1 X82.488 Y88.107 E.06999
G1 X82.535 Y86.395 E.03626
G1 X82.501 Y85.494 E.01908
G1 X82.534 Y82.785 E.05733
G1 X82.488 Y81.093 E.03584
G1 X82.488 Y80.243 E.01798
G1 X83.173 Y80.243 E.0145
G1 X83.174 Y80.483 E.00508
G1 X85.145 Y80.483 E.04172
M204 S10000
G1 X85.629 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.629 Y99.941 E.42081
G1 X83.596 Y99.941 E.04304
G1 X83.595 Y100.181 E.00508
G1 X82.064 Y100.181 E.03242
G1 X82.064 Y98.901 E.02708
G1 X82.11 Y97.209 E.03584
G1 X82.077 Y94.498 E.05738
G1 X82.11 Y93.605 E.01892
G1 X82.062 Y91.419 E.04628
G1 X82.064 Y88.102 E.07021
G1 X82.11 Y86.397 E.03609
G1 X82.077 Y85.502 E.01896
G1 X82.11 Y82.791 E.05738
G1 X82.064 Y81.099 E.03584
G1 X82.064 Y79.819 E.02708
M73 P69 R10
G1 X83.596 Y79.819 E.03243
G1 X83.596 Y80.059 E.00508
G1 X85.569 Y80.059 E.04175
M204 S250
G1 X86.038 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.038 Y100.35 E.40715
G1 X84.004 Y100.35 E.04001
G1 X84.004 Y100.59 E.00472
G1 X81.654 Y100.59 E.04621
G1 X81.654 Y98.896 E.03333
G1 X81.701 Y97.203 E.03331
G1 X81.668 Y94.49 E.05336
G1 X81.701 Y93.601 E.0175
G1 X81.652 Y91.423 E.04286
G1 X81.654 Y88.096 E.06545
G1 X81.701 Y86.399 E.03338
G1 X81.668 Y85.51 E.01751
G1 X81.701 Y82.797 E.05336
G1 X81.654 Y81.104 E.03331
G1 X81.654 Y79.41 E.03333
G1 X84.004 Y79.41 E.04621
G1 X84.004 Y79.65 E.00472
G1 X85.978 Y79.65 E.03883
; WIPE_START
M204 S6000
G1 X85.984 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.868 Y81.725 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.897 Y82.783 E.0224
G1 X82.89 Y83.421 E.01352
G1 X83.032 Y83.627 E.0053
G1 X83.504 Y84.083 E.01387
G1 X83.81 Y84.538 E.01161
G1 X84.191 Y85.448 E.0209
G1 X84.304 Y85.903 E.00993
G1 X84.156 Y86.359 E.01013
G1 X83.18 Y86.814 E.0228
G1 X82.878 Y87.11 E.00895
G1 X82.851 Y88.113 E.02122
G1 X82.849 Y90.646 E.05363
G1 X83.032 Y90.91 E.0068
G1 X83.504 Y91.366 E.01387
G1 X83.81 Y91.821 E.01161
G1 X84.191 Y92.731 E.0209
G1 X84.304 Y93.186 E.00993
G1 X84.156 Y93.642 E.01013
G1 X83.18 Y94.097 E.0228
G1 X82.868 Y94.403 E.00925
G1 X82.897 Y97.217 E.05956
G1 X82.877 Y97.969 E.01592
G1 X83.032 Y98.194 E.00578
G1 X83.504 Y98.649 E.01387
G1 X83.83 Y99.154 E.01273
G1 X84.458 Y99.154 E.01328
G1 X84.455 Y98.084 E.02263
; WIPE_START
G1 X84.458 Y99.154 E-.20318
G1 X83.83 Y99.154 E-.11925
G1 X83.666 Y98.899 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.831 Y99.143 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1200
M204 S6000
G1 X84.831 Y80.917 E.30916
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.831 Y82.917 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 38/74
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I.287 J1.183 P1  F18000
G1 X94.864 Y80.483 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.924 Y80.483 E.04359
G1 X96.923 Y80.243 E.00508
G1 X97.528 Y80.243 E.01281
G1 X97.513 Y82.245 E.04236
G1 X97.489 Y82.796 E.01168
G1 X97.519 Y83.595 E.01692
G1 X97.519 Y84.829 E.02611
G1 X97.489 Y85.607 E.01648
G1 X97.515 Y87.493 E.03992
G1 X97.496 Y88.309 E.01728
G1 X97.536 Y90 E.0358
G1 X97.496 Y91.691 E.0358
G1 X97.515 Y92.507 E.01728
G1 X97.489 Y94.393 E.03992
G1 X97.519 Y95.171 E.01648
G1 X97.519 Y96.405 E.02611
G1 X97.489 Y97.203 E.01692
G1 X97.513 Y97.756 E.0117
G1 X97.528 Y99.757 E.04235
G1 X96.923 Y99.757 E.01282
G1 X96.924 Y99.517 E.00508
G1 X94.864 Y99.517 E.04358
G1 X94.864 Y87.43 E.25582
G1 X94.91 Y86.197 E.02612
G1 X94.864 Y84.708 E.03154
G1 X94.864 Y80.543 E.08814
M204 S10000
G1 X94.44 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.498 Y80.059 E.04355
G1 X96.497 Y79.819 E.00508
G1 X97.955 Y79.819 E.03086
G1 X97.937 Y82.256 E.05157
G1 X97.913 Y82.798 E.01149
G1 X97.943 Y83.587 E.01673
G1 X97.943 Y84.837 E.02644
G1 X97.914 Y85.612 E.01642
G1 X97.94 Y87.495 E.03985
G1 X97.92 Y88.309 E.01724
G1 X97.96 Y90 E.0358
G1 X97.92 Y91.691 E.0358
G1 X97.94 Y92.505 E.01724
G1 X97.914 Y94.388 E.03985
G1 X97.943 Y95.163 E.01642
G1 X97.943 Y96.413 E.02644
G1 X97.913 Y97.202 E.01672
G1 X97.937 Y97.745 E.01149
G1 X97.956 Y100.181 E.05156
G1 X96.497 Y100.181 E.03087
G1 X96.498 Y99.941 E.00508
G1 X94.44 Y99.941 E.04355
G1 X94.44 Y87.422 E.26497
G1 X94.485 Y86.196 E.02598
G1 X94.439 Y84.714 E.03137
G1 X94.44 Y80.119 E.09726
M204 S250
G1 X94.031 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.087 Y79.65 E.04044
G1 X96.086 Y79.41 E.00472
G1 X98.368 Y79.41 E.04487
G1 X98.367 Y79.526 E.00228
G1 X98.346 Y82.266 E.05389
G1 X98.323 Y82.799 E.0105
G1 X98.352 Y83.58 E.01537
G1 X98.352 Y84.844 E.02487
G1 X98.323 Y85.617 E.01521
G1 X98.349 Y87.497 E.03698
G1 X98.329 Y88.309 E.01598
G1 X98.37 Y90 E.03327
G1 X98.329 Y91.691 E.03327
G1 X98.349 Y92.503 E.01598
G1 X98.323 Y94.383 E.03698
G1 X98.352 Y95.156 E.01521
G1 X98.352 Y96.42 E.02487
G1 X98.323 Y97.201 E.01537
G1 X98.346 Y97.734 E.0105
G1 X98.368 Y100.59 E.05618
G1 X96.086 Y100.59 E.04488
G1 X96.087 Y100.35 E.00472
G1 X94.031 Y100.35 E.04044
G1 X94.031 Y87.414 E.25443
G1 X94.076 Y86.194 E.02402
G1 X94.03 Y84.72 E.029
G1 X94.031 Y79.71 E.09855
; WIPE_START
M204 S6000
G1 X96.03 Y79.652 E-.38
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




G1 X97.155 Y81.571
G1 Z4.64
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.16 Y80.846 E.01534
G1 X96.188 Y80.846 E.02058
G1 X95.918 Y81.267 E.01059
G1 X95.63 Y81.789 E.01261
G1 X95.633 Y83.245 E.03082
G1 X95.918 Y83.084 E.00692
G1 X96.373 Y83.135 E.00969
G1 X97.149 Y83.42 E.0175
G1 X97.156 Y84.822 E.02967
G1 X97.126 Y85.603 E.01654
G1 X97.148 Y87.196 E.03373
G1 X96.828 Y87.399 E.00803
G1 X96.373 Y87.843 E.01346
G1 X95.918 Y88.55 E.0178
G1 X95.628 Y89.075 E.01268
G1 X95.627 Y90.531 E.03082
G1 X95.918 Y90.367 E.00706
G1 X96.373 Y90.418 E.00969
G1 X97.156 Y90.706 E.01767
M73 P69 R9
G1 X97.133 Y91.691 E.02086
G1 X97.152 Y92.509 E.01732
G1 X97.13 Y94.491 E.04195
G1 X96.828 Y94.682 E.00757
G1 X96.373 Y95.126 E.01346
G1 X95.918 Y95.833 E.0178
G1 X95.633 Y96.349 E.01246
G1 X95.631 Y97.812 E.03097
G1 X95.918 Y97.65 E.00697
G1 X96.373 Y97.701 E.00969
G1 X97.152 Y97.987 E.01757
G1 X97.161 Y99.154 E.02469
G1 X96.63 Y99.154 E.01123
; WIPE_START
G1 X97.161 Y99.154 E-.10083
G1 X97.152 Y97.987 E-.2216
G1 X96.868 Y97.883 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.246 Y99.135 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.370348
G1 F1200
M204 S6000
G1 X95.244 Y89.998 E.15707
G1 X95.25 Y87.437 E.04403
G1 X95.274 Y86.193 E.02139
G1 X95.25 Y84.702 E.02563
G1 X95.246 Y80.925 E.06493
; WIPE_START
G1 X95.248 Y82.925 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.829 Y81.134 Z5.04 F18000
G1 X85.136 Y80.483 Z5.04
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.136 Y99.517 E.40285
G1 X83.083 Y99.517 E.04346
G1 X83.083 Y99.757 E.00508
G1 X82.467 Y99.757 E.01302
G1 X82.47 Y98.697 E.02242
G1 X82.511 Y97.215 E.03139
G1 X82.511 Y96.4 E.01724
G1 X82.482 Y95.629 E.01633
G1 X82.482 Y94.395 E.02611
G1 X82.511 Y93.605 E.01674
G1 X82.47 Y92.101 E.03184
G1 X82.464 Y90.689 E.02989
G1 X82.47 Y87.897 E.0591
G1 X82.511 Y86.395 E.0318
G1 X82.482 Y85.605 E.01674
G1 X82.482 Y84.371 E.02611
G1 X82.511 Y83.6 E.01633
G1 X82.511 Y82.785 E.01724
G1 X82.47 Y81.303 E.03139
G1 X82.467 Y80.243 E.02242
G1 X83.084 Y80.243 E.01305
G1 X83.085 Y80.483 E.00508
G1 X85.076 Y80.483 E.04214
M204 S10000
G1 X85.56 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.56 Y99.941 E.42081
G1 X83.507 Y99.941 E.04347
G1 X83.506 Y100.181 E.00508
G1 X82.042 Y100.181 E.03099
G1 X82.046 Y98.691 E.03153
G1 X82.087 Y97.209 E.03139
G1 X82.087 Y96.408 E.01695
G1 X82.058 Y95.637 E.01633
G1 X82.058 Y94.387 E.02644
G1 X82.087 Y93.603 E.01662
G1 X82.046 Y92.108 E.03165
M73 P70 R9
G1 X82.04 Y90.689 E.03003
G1 X82.046 Y87.891 E.05923
G1 X82.087 Y86.397 E.03163
G1 X82.058 Y85.613 E.01662
G1 X82.058 Y84.363 E.02644
G1 X82.087 Y83.592 E.01633
G1 X82.087 Y82.791 E.01695
G1 X82.046 Y81.309 E.03139
G1 X82.042 Y79.819 E.03153
G1 X83.507 Y79.819 E.031
G1 X83.508 Y80.059 E.00508
G1 X85.5 Y80.059 E.04217
M204 S250
G1 X85.97 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.97 Y100.35 E.40715
G1 X83.915 Y100.35 E.04041
G1 X83.915 Y100.59 E.00472
G1 X81.632 Y100.59 E.0449
G1 X81.637 Y98.685 E.03747
G1 X81.677 Y97.203 E.02916
G1 X81.677 Y96.416 E.01549
G1 X81.649 Y95.644 E.01518
G1 X81.649 Y94.38 E.02487
G1 X81.678 Y93.601 E.01533
G1 X81.637 Y92.115 E.02924
G1 X81.63 Y90.689 E.02805
G1 X81.637 Y87.885 E.05516
G1 X81.678 Y86.399 E.02923
G1 X81.649 Y85.62 E.01533
G1 X81.649 Y84.356 E.02487
G1 X81.677 Y83.584 E.01518
G1 X81.677 Y82.797 E.01549
G1 X81.637 Y81.315 E.02916
G1 X81.632 Y79.41 E.03747
G1 X83.915 Y79.41 E.0449
G1 X83.916 Y79.65 E.00472
G1 X85.91 Y79.65 E.03922
; WIPE_START
M204 S6000
G1 X85.915 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.849 Y81.872 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.874 Y83.569 E.03591
G1 X83.172 Y83.757 E.00747
G1 X83.627 Y84.202 E.01346
G1 X84.082 Y84.908 E.0178
G1 X84.364 Y85.419 E.01234
G1 X84.361 Y86.883 E.03098
G1 X84.082 Y86.726 E.00677
G1 X83.627 Y86.776 E.00969
G1 X82.856 Y87.06 E.01739
G1 X82.833 Y87.903 E.01785
G1 X82.827 Y90.822 E.0618
G1 X83.172 Y91.041 E.00864
G1 X83.627 Y91.485 E.01346
G1 X84.082 Y92.192 E.0178
G1 X84.362 Y92.7 E.01228
G1 X84.363 Y94.167 E.03106
G1 X84.082 Y94.009 E.00682
G1 X83.627 Y94.059 E.00969
G1 X82.847 Y94.346 E.0176
G1 X82.845 Y95.622 E.027
G1 X82.874 Y96.393 E.01634
G1 X82.849 Y98.119 E.03653
G1 X83.172 Y98.324 E.00809
G1 X83.627 Y98.768 E.01346
G1 X83.876 Y99.154 E.00971
G1 X84.373 Y99.154 E.01051
G1 X84.37 Y97.953 E.0254
; WIPE_START
G1 X84.373 Y99.154 E-.22804
G1 X83.876 Y99.154 E-.09439
G1 X83.712 Y98.899 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.754 Y99.135 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.371257
G1 F1200
M204 S6000
G1 X84.754 Y80.925 E.31388
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.754 Y82.925 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/74
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I.284 J1.183 P1  F18000
G1 X94.937 Y80.483 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.001 Y80.483 E.0437
G1 X97.001 Y80.243 E.00508
G1 X97.548 Y80.243 E.01158
G1 X97.533 Y82.32 E.04396
G1 X97.512 Y82.796 E.01009
G1 X97.538 Y83.485 E.01458
G1 X97.538 Y85.05 E.03313
G1 X97.513 Y85.718 E.01414
G1 X97.536 Y87.532 E.03841
G1 X97.52 Y88.218 E.01451
G1 X97.557 Y90 E.03773
G1 X97.52 Y91.782 E.03772
G1 X97.536 Y92.468 E.01452
G1 X97.513 Y94.282 E.03841
G1 X97.538 Y94.95 E.01414
G1 X97.538 Y96.515 E.03313
G1 X97.512 Y97.203 E.01458
G1 X97.533 Y97.68 E.0101
G1 X97.549 Y99.757 E.04395
G1 X97.001 Y99.757 E.0116
G1 X97.001 Y99.517 E.00508
G1 X94.936 Y99.517 E.04373
G1 X94.938 Y88.462 E.23398
G1 X94.942 Y87.479 E.02081
G1 X94.98 Y86.452 E.02174
G1 X94.942 Y85.243 E.02561
G1 X94.937 Y80.543 E.09947
M204 S10000
G1 X94.512 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.576 Y80.059 E.04369
G1 X96.576 Y79.819 E.00508
G1 X97.975 Y79.819 E.02962
G1 X97.957 Y82.331 E.05317
G1 X97.937 Y82.798 E.00989
G1 X97.962 Y83.477 E.01438
G1 X97.962 Y85.058 E.03346
G1 X97.937 Y85.723 E.01409
G1 X97.96 Y87.535 E.03835
G1 X97.944 Y88.219 E.01448
G1 X97.981 Y90 E.03771
G1 X97.944 Y91.781 E.03771
G1 X97.96 Y92.465 E.01449
G1 X97.937 Y94.277 E.03835
G1 X97.962 Y94.942 E.01409
G1 X97.962 Y96.523 E.03346
G1 X97.937 Y97.202 E.01438
G1 X97.957 Y97.669 E.0099
G1 X97.976 Y100.181 E.05316
G1 X96.576 Y100.181 E.02965
G1 X96.576 Y99.941 E.00508
G1 X94.511 Y99.941 E.04371
G1 X94.513 Y88.462 E.24295
G1 X94.518 Y87.47 E.02101
G1 X94.555 Y86.451 E.02157
G1 X94.518 Y85.25 E.02543
G1 X94.512 Y80.119 E.1086
M204 S250
G1 X94.102 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.166 Y79.65 E.0406
G1 X96.166 Y79.41 E.00472
G1 X98.388 Y79.41 E.04372
G1 X98.384 Y79.832 E.00831
G1 X98.367 Y82.341 E.04935
G1 X98.347 Y82.799 E.00901
G1 X98.371 Y83.469 E.01319
G1 X98.371 Y85.065 E.03139
G1 X98.347 Y85.728 E.01305
G1 X98.37 Y87.537 E.03558
G1 X98.353 Y88.22 E.01343
G1 X98.39 Y90 E.03503
G1 X98.353 Y91.78 E.03503
G1 X98.37 Y92.463 E.01343
G1 X98.347 Y94.272 E.03558
G1 X98.371 Y94.935 E.01305
G1 X98.371 Y96.531 E.03139
G1 X98.347 Y97.201 E.01319
G1 X98.367 Y97.659 E.00902
G1 X98.389 Y100.59 E.05766
G1 X96.166 Y100.59 E.04373
G1 X96.166 Y100.35 E.00472
G1 X94.102 Y100.35 E.0406
G1 X94.104 Y88.462 E.23382
G1 X94.109 Y87.461 E.0197
G1 X94.146 Y86.45 E.0199
G1 X94.109 Y85.256 E.02349
G1 X94.102 Y79.71 E.10909
; WIPE_START
M204 S6000
G1 X96.101 Y79.652 E-.38
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




G1 X97.176 Y81.497
G1 Z4.76
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.181 Y80.846 E.01377
G1 X96.134 Y80.846 E.02215
G1 X95.716 Y81.429 E.01519
G1 X95.716 Y83.463 E.04305
G1 X95.918 Y83.315 E.00529
G1 X96.373 Y83.273 E.00968
G1 X97.175 Y83.486 E.01756
G1 X97.175 Y85.043 E.03296
G1 X97.15 Y85.713 E.0142
G1 X97.169 Y87.219 E.03187
G1 X96.828 Y87.407 E.00824
G1 X96.373 Y87.797 E.01269
G1 X95.716 Y88.713 E.02385
G1 X95.716 Y90.747 E.04305
G1 X95.918 Y90.598 E.00529
G1 X96.373 Y90.556 E.00968
G1 X97.178 Y90.77 E.01763
G1 X97.157 Y91.782 E.02143
G1 X97.173 Y92.469 E.01455
G1 X97.158 Y94.508 E.04315
G1 X96.828 Y94.69 E.00798
G1 X96.373 Y95.08 E.01269
G1 X95.716 Y95.996 E.02385
G1 X95.716 Y98.03 E.04305
G1 X95.918 Y97.881 E.00529
G1 X96.373 Y97.839 E.00968
G1 X97.173 Y98.052 E.01753
G1 X97.182 Y99.154 E.02333
G1 X96.587 Y99.154 E.01259
; WIPE_START
G1 X97.182 Y99.154 E-.11303
G1 X97.173 Y98.052 E-.2094
G1 X96.88 Y97.974 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.326 Y99.126 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.377755
G1 F1200
M204 S6000
G1 X95.329 Y87.486 E.20442
G1 X95.348 Y86.448 E.01823
G1 X95.329 Y85.237 E.02127
G1 X95.327 Y80.933 E.07559
; WIPE_START
G1 X95.328 Y82.933 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.904 Y81.161 Z5.16 F18000
G1 X85.065 Y80.483 Z5.16
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.065 Y99.517 E.40285
G1 X83.005 Y99.517 E.0436
G1 X83.005 Y99.757 E.00508
G1 X82.447 Y99.757 E.01181
G1 X82.452 Y98.488 E.02686
G1 X82.487 Y97.215 E.02696
G1 X82.487 Y96.511 E.01489
G1 X82.463 Y95.85 E.01401
G1 X82.463 Y94.285 E.03312
G1 X82.488 Y93.605 E.0144
G1 X82.452 Y92.312 E.02737
G1 X82.442 Y90 E.04894
G1 X82.452 Y87.688 E.04895
G1 X82.488 Y86.395 E.02737
G1 X82.463 Y85.715 E.0144
G1 X82.463 Y84.15 E.03312
G1 X82.487 Y83.489 E.01401
G1 X82.487 Y82.785 E.01489
G1 X82.452 Y81.512 E.02696
G1 X82.447 Y80.246 E.0268
G1 X83.005 Y80.248 E.01181
G1 X83.006 Y80.483 E.00499
G1 X85.005 Y80.483 E.04233
M204 S10000
G1 X85.49 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.49 Y99.941 E.42081
G1 X83.428 Y99.941 E.04363
G1 X83.427 Y100.181 E.00508
G1 X82.021 Y100.181 E.02978
G1 X82.028 Y98.481 E.03598
G1 X82.063 Y97.209 E.02694
G1 X82.063 Y96.519 E.01459
G1 X82.038 Y95.858 E.01401
G1 X82.038 Y94.277 E.03346
G1 X82.063 Y93.603 E.01428
G1 X82.028 Y92.319 E.02718
G1 X82.018 Y90 E.04908
G1 X82.028 Y87.681 E.0491
G1 X82.063 Y86.397 E.02718
G1 X82.038 Y85.723 E.01428
G1 X82.038 Y84.142 E.03346
M73 P71 R9
G1 X82.063 Y83.481 E.01401
G1 X82.063 Y82.791 E.01459
G1 X82.028 Y81.519 E.02694
G1 X82.021 Y79.821 E.03595
G1 X83.427 Y79.824 E.02978
G1 X83.428 Y80.059 E.00497
G1 X85.43 Y80.059 E.04236
M204 S250
G1 X85.899 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.899 Y100.35 E.40715
G1 X83.836 Y100.35 E.04057
G1 X83.835 Y100.59 E.00472
G1 X81.61 Y100.59 E.04378
G1 X81.619 Y98.474 E.04162
G1 X81.654 Y97.203 E.02501
G1 X81.654 Y96.527 E.0133
G1 X81.629 Y95.865 E.01302
G1 X81.629 Y94.269 E.03139
G1 X81.654 Y93.601 E.01316
G1 X81.619 Y92.326 E.02508
G1 X81.609 Y90 E.04575
G1 X81.619 Y87.674 E.04576
G1 X81.654 Y86.399 E.02508
G1 X81.629 Y85.731 E.01316
G1 X81.629 Y84.135 E.03139
G1 X81.654 Y83.473 E.01302
G1 X81.654 Y82.797 E.0133
G1 X81.619 Y81.526 E.02501
G1 X81.61 Y79.411 E.04161
G1 X83.835 Y79.416 E.04378
G1 X83.836 Y79.65 E.0046
G1 X85.839 Y79.65 E.03939
; WIPE_START
M204 S6000
G1 X85.845 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.826 Y81.889 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.85 Y82.781 E.01887
G1 X82.847 Y83.586 E.01705
G1 X83.172 Y83.765 E.00786
G1 X83.627 Y84.155 E.01269
G1 X84.284 Y85.072 E.02387
G1 X84.284 Y87.105 E.04304
G1 X84.082 Y86.957 E.00531
G1 X83.627 Y86.915 E.00968
G1 X82.831 Y87.126 E.01744
G1 X82.805 Y90 E.06084
G1 X82.809 Y90.848 E.01795
G1 X83.172 Y91.048 E.00878
G1 X83.627 Y91.438 E.01269
G1 X84.284 Y92.355 E.02387
G1 X84.284 Y94.389 E.04304
G1 X84.082 Y94.24 E.00531
G1 X83.627 Y94.198 E.00968
G1 X82.826 Y94.41 E.01756
G1 X82.826 Y95.843 E.03032
G1 X82.85 Y96.504 E.01401
G1 X82.85 Y97.219 E.01513
G1 X82.825 Y98.14 E.0195
G1 X83.172 Y98.331 E.00839
G1 X83.627 Y98.722 E.01269
G1 X84 Y99.154 E.01208
G1 X84.284 Y99.154 E.00601
G1 X84.284 Y97.741 E.02991
; WIPE_START
G1 X84.284 Y99.154 E-.26846
G1 X84 Y99.154 E-.05397
G1 X83.802 Y98.924 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.675 Y99.126 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.382492
G1 F1200
M204 S6000
G1 X84.675 Y80.934 E.32378
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.675 Y82.934 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/74
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I.281 J1.184 P1  F18000
G1 X95.015 Y80.483 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.074 Y80.483 E.04357
G1 X97.073 Y80.243 E.00508
G1 X97.568 Y80.243 E.01048
G1 X97.553 Y82.396 E.04556
G1 X97.536 Y82.796 E.00849
G1 X97.557 Y83.374 E.01224
G1 X97.557 Y85.281 E.04035
G1 X97.537 Y86.399 E.02368
G1 X97.557 Y87.575 E.02488
G1 X97.543 Y88.128 E.01171
G1 X97.577 Y90 E.03964
G1 X97.543 Y91.872 E.03964
G1 X97.557 Y92.428 E.01177
G1 X97.536 Y94.171 E.03689
G1 X97.557 Y94.729 E.01181
G1 X97.557 Y96.626 E.04014
G1 X97.536 Y97.203 E.01224
G1 X97.553 Y97.605 E.00851
G1 X97.57 Y99.757 E.04554
G1 X97.073 Y99.757 E.01051
G1 X97.074 Y99.517 E.00508
G1 X95.016 Y99.517 E.04356
G1 X95.028 Y93.412 E.1292
G1 X95.013 Y89.596 E.08077
G1 X95.022 Y87.452 E.0454
G1 X95.05 Y86.708 E.01575
G1 X95.023 Y85.833 E.01854
G1 X95.015 Y80.543 E.11195
M204 S10000
G1 X94.59 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.648 Y80.059 E.04357
G1 X96.648 Y79.819 E.00508
G1 X97.996 Y79.819 E.02854
G1 X97.993 Y80.135 E.00669
G1 X97.978 Y82.406 E.04807
G1 X97.96 Y82.798 E.00829
G1 X97.982 Y83.366 E.01204
G1 X97.968 Y88.129 E.1008
G1 X98.002 Y90 E.03961
G1 X97.968 Y91.871 E.03961
G1 X97.981 Y92.426 E.01175
G1 X97.961 Y94.166 E.03684
G1 X97.982 Y94.721 E.01176
G1 X97.982 Y96.634 E.04048
G1 X97.96 Y97.202 E.01204
G1 X97.978 Y97.594 E.0083
G1 X97.997 Y100.181 E.05475
G1 X96.648 Y100.181 E.02856
G1 X96.648 Y99.941 E.00508
G1 X94.59 Y99.941 E.04356
G1 X94.604 Y93.413 E.13817
G1 X94.589 Y89.597 E.08076
G1 X94.598 Y87.443 E.04561
G1 X94.625 Y86.707 E.01559
G1 X94.599 Y85.84 E.01836
G1 X94.59 Y80.119 E.12108
M204 S250
G1 X94.18 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.238 Y79.65 E.04048
G1 X96.237 Y79.41 E.00472
G1 X98.409 Y79.41 E.04272
G1 X98.402 Y80.139 E.01433
G1 X98.387 Y82.417 E.04481
G1 X98.37 Y82.799 E.00753
G1 X98.391 Y83.359 E.01102
G1 X98.391 Y85.288 E.03795
G1 X98.37 Y86.4 E.02187
G1 X98.39 Y87.577 E.02316
G1 X98.377 Y88.13 E.01088
G1 X98.411 Y90 E.03678
G1 X98.377 Y91.87 E.03678
G1 X98.39 Y92.423 E.01089
G1 X98.37 Y94.161 E.03418
G1 X98.391 Y94.714 E.01088
G1 X98.391 Y96.641 E.03791
G1 X98.37 Y97.201 E.01101
G1 X98.387 Y97.583 E.00753
G1 X98.41 Y100.59 E.05914
G1 X96.237 Y100.59 E.04272
G1 X96.238 Y100.35 E.00472
G1 X94.18 Y100.35 E.04047
G1 X94.195 Y93.414 E.13643
G1 X94.18 Y89.598 E.07504
G1 X94.189 Y87.434 E.04257
G1 X94.216 Y86.705 E.01434
G1 X94.189 Y85.846 E.01691
G1 X94.18 Y79.71 E.12069
; WIPE_START
M204 S6000
G1 X96.179 Y79.652 E-.38
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




G1 X97.32 Y80.456
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.093562
G1 F1500
M204 S6000
G1 X97.32 Y80.695 E.00081
M204 S10000
G1 X97.197 Y81.403 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.2 Y81.058 E.00729
G1 X96.909 Y81.057 E.00615
G1 X96.91 Y80.846 E.00447
G1 X96.059 Y80.846 E.01801
G1 X95.811 Y81.148 E.00826
G1 X95.811 Y83.585 E.05159
G1 X95.918 Y83.5 E.0029
G1 X96.373 Y83.395 E.00989
G1 X96.828 Y83.428 E.00966
G1 X97.194 Y83.527 E.00804
G1 X97.194 Y85.277 E.03704
G1 X97.174 Y86.399 E.02375
G1 X97.188 Y87.237 E.01775
G1 X96.828 Y87.407 E.00842
G1 X96.373 Y87.748 E.01205
G1 X95.811 Y88.431 E.01871
G1 X95.811 Y90.868 E.05159
G1 X95.918 Y90.783 E.0029
G1 X96.373 Y90.678 E.00989
G1 X96.828 Y90.712 E.00966
G1 X97.2 Y90.812 E.00815
G1 X97.18 Y91.873 E.02247
G1 X97.194 Y92.431 E.0118
G1 X97.174 Y94.176 E.03695
G1 X97.186 Y94.521 E.00731
G1 X96.828 Y94.69 E.00839
G1 X96.373 Y95.032 E.01205
G1 X95.811 Y95.714 E.01871
G1 X95.811 Y98.151 E.05159
G1 X95.918 Y98.066 E.0029
G1 X96.373 Y97.961 E.00989
G1 X96.828 Y97.995 E.00966
G1 X97.194 Y98.093 E.00803
G1 X97.173 Y97.205 E.01882
G1 X97.194 Y96.397 E.0171
; WIPE_START
G1 X97.173 Y97.205 E-.15346
G1 X97.194 Y98.093 E-.16892
G1 X96.901 Y98.015 E-.05762
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.321 Y99.544 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0949313
G1 F1500
M204 S6000
G1 X97.32 Y99.305 E.00083
; WIPE_START
G1 X97.321 Y99.544 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.414 Y99.119 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.390501
G1 F1200
M204 S6000
G1 X95.412 Y89.597 E.17329
G1 X95.43 Y86.715 E.05244
G1 X95.413 Y80.941 E.10507
; WIPE_START
G1 X95.419 Y82.941 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.99 Y81.191 Z5.28 F18000
G1 X84.985 Y80.483 Z5.28
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.972 Y86.588 E.12922
G1 X84.987 Y89.597 E.06368
G1 X84.972 Y93.414 E.08078
G1 X84.985 Y99.517 E.12917
G1 X82.932 Y99.517 E.04346
G1 X82.932 Y99.757 E.00508
G1 X82.429 Y99.757 E.01064
G1 X82.435 Y98.276 E.03135
G1 X82.464 Y97.205 E.02267
G1 X82.443 Y96.081 E.0238
G1 X82.443 Y94.174 E.04035
G1 X82.464 Y93.605 E.01206
G1 X82.435 Y92.524 E.02288
G1 X82.425 Y90 E.05343
G1 X82.435 Y87.476 E.05344
G1 X82.464 Y86.395 E.02288
G1 X82.443 Y85.826 E.01206
G1 X82.443 Y83.919 E.04035
G1 X82.464 Y82.795 E.0238
G1 X82.435 Y81.724 E.02267
G1 X82.429 Y80.243 E.03135
G1 X82.933 Y80.243 E.01067
G1 X82.934 Y80.483 E.00508
G1 X84.925 Y80.483 E.04215
M204 S10000
G1 X85.41 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.396 Y86.587 E.13817
M73 P72 R9
G1 X85.412 Y89.598 E.06372
G1 X85.396 Y93.414 E.08077
G1 X85.41 Y99.941 E.13815
G1 X83.355 Y99.941 E.04349
G1 X83.355 Y100.181 E.00508
G1 X82.003 Y100.181 E.02862
G1 X82.011 Y98.269 E.04046
G1 X82.04 Y97.203 E.02258
G1 X82.019 Y96.084 E.02368
G1 X82.019 Y94.166 E.04059
G1 X82.04 Y93.603 E.01194
G1 X82.011 Y92.531 E.0227
G1 X82 Y90 E.05356
G1 X82.011 Y87.469 E.05357
G1 X82.04 Y86.397 E.0227
G1 X82.019 Y85.834 E.01194
G1 X82.019 Y83.916 E.04059
G1 X82.04 Y82.797 E.02368
G1 X82.011 Y81.731 E.02258
G1 X82.003 Y79.819 E.04046
G1 X83.356 Y79.819 E.02863
G1 X83.357 Y80.059 E.00508
G1 X85.35 Y80.059 E.0422
M204 S250
G1 X85.82 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.806 Y86.586 E.13643
G1 X85.821 Y89.598 E.05924
G1 X85.806 Y93.414 E.07505
G1 X85.82 Y100.35 E.13643
G1 X83.764 Y100.35 E.04045
G1 X83.764 Y100.59 E.00472
G1 X81.592 Y100.59 E.04271
G1 X81.601 Y98.263 E.04577
G1 X81.631 Y97.201 E.02089
G1 X81.61 Y96.088 E.02189
G1 X81.61 Y94.159 E.03795
G1 X81.631 Y93.601 E.01098
G1 X81.601 Y92.537 E.02093
G1 X81.591 Y90 E.0499
G1 X81.601 Y87.463 E.04991
G1 X81.631 Y86.399 E.02093
G1 X81.61 Y85.841 E.01098
G1 X81.61 Y83.912 E.03795
G1 X81.631 Y82.799 E.02189
G1 X81.601 Y81.737 E.02089
G1 X81.592 Y79.41 E.04577
G1 X83.764 Y79.41 E.04271
G1 X83.764 Y79.65 E.00472
G1 X85.76 Y79.65 E.03926
; WIPE_START
M204 S6000
G1 X85.773 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.587 Y80.881 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.390414
G1 F1200
M204 S6000
G1 X84.587 Y99.059 E.33073
; WIPE_START
G1 X84.587 Y97.059 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.19 Y97.623 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.19 Y99.154 E.0324
G1 X84.024 Y99.154 E.00351
G1 X83.627 Y98.673 E.01319
G1 X83.172 Y98.331 E.01205
G1 X82.801 Y98.157 E.00868
G1 X82.827 Y97.206 E.02013
G1 X82.806 Y96.077 E.02391
G1 X82.806 Y94.452 E.0344
G1 X83.172 Y94.353 E.00802
G1 X83.627 Y94.319 E.00966
G1 X84.082 Y94.424 E.00989
G1 X84.19 Y94.51 E.00291
G1 X84.19 Y92.073 E.05159
G1 X83.627 Y91.39 E.01873
G1 X83.172 Y91.048 E.01205
G1 X82.791 Y90.869 E.00891
G1 X82.798 Y87.481 E.07171
G1 X82.806 Y87.169 E.00662
G1 X83.172 Y87.07 E.00802
G1 X83.627 Y87.036 E.00966
G1 X84.082 Y87.141 E.00989
G1 X84.19 Y87.227 E.00291
G1 X84.19 Y84.79 E.05159
G1 X83.627 Y84.107 E.01873
G1 X83.172 Y83.765 E.01205
G1 X82.812 Y83.596 E.00842
G1 X82.827 Y82.794 E.01698
G1 X82.803 Y81.899 E.01893
; WIPE_START
G1 X82.827 Y82.794 E-.16996
G1 X82.812 Y83.596 E-.15247
G1 X83.086 Y83.725 E-.05758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.683 Y80.695 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.105469
G1 F1500
M204 S6000
G1 X82.682 Y80.456 E.00095
; WIPE_START
G1 X82.683 Y80.695 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.682 Y88.328 Z5.28 F18000
G1 X82.682 Y99.305 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.103486
G1 F1500
M204 S6000
G1 X82.681 Y99.544 E.00093
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.682 Y99.305 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 41/74
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I1.016 J.67 P1  F18000
G1 X95.095 Y80.483 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.139 Y80.483 E.04327
G1 X97.139 Y80.243 E.00508
G1 X97.588 Y80.243 E.00951
G1 X97.56 Y82.814 E.0544
G1 X97.577 Y83.263 E.00951
G1 X97.567 Y88.048 E.10128
G1 X97.595 Y90 E.04132
G1 X97.567 Y91.952 E.04133
G1 X97.577 Y96.737 E.10128
G1 X97.56 Y97.186 E.0095
G1 X97.585 Y99.757 E.05441
G1 X97.139 Y99.757 E.00944
G1 X97.139 Y99.517 E.00508
G1 X95.096 Y99.517 E.04325
G1 X95.111 Y93.201 E.13367
G1 X95.094 Y90 E.06776
G1 X95.103 Y87.423 E.05453
G1 X95.12 Y86.964 E.00974
G1 X95.103 Y86.421 E.01148
G1 X95.095 Y80.543 E.12441
M204 S10000
G1 X94.67 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.714 Y80.059 E.04326
G1 X96.713 Y79.819 E.00508
G1 X98.017 Y79.819 E.02759
G1 X97.984 Y82.808 E.06326
G1 X98.001 Y83.255 E.00947
G1 X97.992 Y88.045 E.10139
G1 X98.019 Y90 E.04137
G1 X97.992 Y91.955 E.04138
G1 X98.001 Y96.745 E.10139
G1 X97.984 Y97.192 E.00946
G1 X98.013 Y100.181 E.06327
G1 X96.713 Y100.181 E.02751
G1 X96.714 Y99.941 E.00508
G1 X94.671 Y99.941 E.04324
G1 X94.687 Y93.201 E.14265
G1 X94.67 Y90 E.06777
G1 X94.679 Y87.415 E.05471
G1 X94.695 Y86.962 E.00959
G1 X94.679 Y86.428 E.01131
G1 X94.67 Y80.119 E.13354
M204 S250
G1 X94.26 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.303 Y79.65 E.04018
G1 X96.303 Y79.41 E.00472
G1 X98.428 Y79.41 E.0418
G1 X98.428 Y79.659 E.00489
G1 X98.394 Y82.803 E.06184
G1 X98.41 Y83.248 E.00877
G1 X98.401 Y88.043 E.09431
G1 X98.428 Y90 E.03849
G1 X98.401 Y91.957 E.0385
G1 X98.41 Y96.752 E.09431
G1 X98.394 Y97.197 E.00876
G1 X98.426 Y100.59 E.06674
G1 X96.303 Y100.59 E.04177
G1 X96.303 Y100.35 E.00472
G1 X94.261 Y100.35 E.04018
G1 X94.278 Y93.201 E.14061
G1 X94.261 Y90 E.06298
G1 X94.269 Y87.407 E.051
G1 X94.286 Y86.961 E.00877
G1 X94.27 Y86.435 E.01035
G1 X94.26 Y79.71 E.13227
; WIPE_START
M204 S6000
G1 X96.26 Y79.651 E-.38
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




G1 X95.914 Y81.961
G1 Z5
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.914 Y83.658 E.03592
G1 X96.373 Y83.502 E.01024
G1 X96.828 Y83.494 E.00964
G1 X97.213 Y83.567 E.0083
G1 X97.206 Y87.252 E.078
G1 X96.828 Y87.4 E.0086
G1 X96.373 Y87.697 E.01151
G1 X95.916 Y88.192 E.01426
G1 X95.917 Y90.939 E.05813
G1 X96.373 Y90.786 E.01018
G1 X96.828 Y90.777 E.00964
G1 X97.22 Y90.851 E.00844
G1 X97.205 Y91.95 E.02326
G1 X97.21 Y94.534 E.05468
G1 X96.828 Y94.683 E.00867
G1 X96.373 Y94.98 E.01151
G1 X95.918 Y95.473 E.01418
G1 X95.919 Y98.221 E.05816
G1 X96.373 Y98.069 E.01013
G1 X96.828 Y98.06 E.00964
G1 X97.206 Y98.132 E.00815
G1 X97.197 Y97.181 E.02012
G1 X97.213 Y96.435 E.01579
; WIPE_START
G1 X97.197 Y97.181 E-.14175
G1 X97.206 Y98.132 E-.18065
G1 X96.908 Y98.075 E-.0576
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.508 Y99.105 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.418921
G1 F1200
M204 S6000
G1 X95.504 Y80.953 E.35607
; WIPE_START
G1 X95.505 Y82.953 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.071 Y81.221 Z5.4 F18000
G1 X84.905 Y80.483 Z5.4
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
M73 P72 R8
G1 X84.889 Y86.799 E.13367
G1 X84.906 Y90 E.06776
G1 X84.889 Y93.201 E.06776
G1 X84.905 Y99.517 E.13367
G1 X82.869 Y99.517 E.04308
G1 X82.868 Y99.757 E.00508
G1 X82.411 Y99.757 E.00968
G1 X82.417 Y98.064 E.03582
G1 X82.441 Y97.205 E.0182
G1 X82.424 Y94.064 E.06648
G1 X82.441 Y93.605 E.00972
G1 X82.417 Y92.736 E.01841
G1 X82.407 Y90 E.0579
G1 X82.417 Y87.264 E.0579
G1 X82.441 Y86.395 E.01841
G1 X82.424 Y85.936 E.00972
G1 X82.441 Y82.795 E.06648
G1 X82.417 Y81.936 E.0182
G1 X82.411 Y80.243 E.03582
G1 X82.869 Y80.243 E.00969
G1 X82.87 Y80.483 E.00508
G1 X84.845 Y80.483 E.0418
M204 S10000
G1 X85.33 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.314 Y86.799 E.14265
G1 X85.331 Y90 E.06776
G1 X85.314 Y93.201 E.06776
G1 X85.33 Y99.941 E.14265
G1 X83.292 Y99.941 E.04313
G1 X83.291 Y100.181 E.00508
G1 X81.985 Y100.181 E.02764
G1 X81.993 Y98.058 E.04493
G1 X82.016 Y97.203 E.01811
G1 X82 Y94.056 E.06661
G1 X82.016 Y93.603 E.00959
G1 X81.993 Y92.742 E.01823
G1 X81.983 Y90 E.05804
G1 X81.993 Y87.258 E.05804
G1 X82.016 Y86.397 E.01823
G1 X82 Y85.944 E.00959
G1 X82.016 Y82.797 E.06661
G1 X81.993 Y81.942 E.01811
G1 X81.985 Y79.819 E.04493
G1 X83.291 Y79.819 E.02765
G1 X83.292 Y80.059 E.00508
G1 X85.27 Y80.059 E.04186
M204 S250
G1 X85.74 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.723 Y86.799 E.14061
M73 P73 R8
G1 X85.74 Y90 E.06297
G1 X85.723 Y93.201 E.06297
G1 X85.74 Y100.35 E.14061
G1 X83.7 Y100.35 E.04013
G1 X83.699 Y100.59 E.00472
G1 X81.574 Y100.59 E.04179
G1 X81.584 Y98.052 E.04993
G1 X81.607 Y97.201 E.01674
G1 X81.59 Y94.048 E.06201
G1 X81.607 Y93.601 E.0088
G1 X81.584 Y92.748 E.01678
G1 X81.574 Y90 E.05406
G1 X81.584 Y87.252 E.05406
G1 X81.607 Y86.399 E.01678
G1 X81.59 Y85.952 E.0088
G1 X81.607 Y82.799 E.06201
G1 X81.584 Y81.948 E.01674
G1 X81.574 Y79.41 E.04993
G1 X83.699 Y79.41 E.04179
G1 X83.7 Y79.65 E.00472
G1 X85.68 Y79.65 E.03895
; WIPE_START
M204 S6000
G1 X85.692 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.492 Y80.895 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.414523
G1 F1200
M204 S6000
G1 X84.495 Y99.048 E.3521
; WIPE_START
G1 X84.495 Y97.048 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.087 Y97.423 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X84.087 Y99.12 E.03592
G1 X83.627 Y98.622 E.01435
G1 X83.172 Y98.324 E.01151
G1 X82.78 Y98.171 E.00892
G1 X82.804 Y97.209 E.02037
G1 X82.789 Y94.491 E.05752
G1 X83.172 Y94.418 E.00825
G1 X83.627 Y94.427 E.00964
G1 X84.086 Y94.582 E.01024
G1 X84.085 Y91.834 E.05816
G1 X83.627 Y91.339 E.01427
G1 X83.172 Y91.041 E.01151
G1 X82.773 Y90.885 E.00907
G1 X82.77 Y90 E.01874
G1 X82.782 Y87.209 E.05907
G1 X83.172 Y87.135 E.00841
G1 X83.627 Y87.144 E.00964
G1 X84.083 Y87.297 E.01018
G1 X84.082 Y84.549 E.05818
G1 X83.627 Y84.056 E.0142
G1 X83.172 Y83.758 E.01151
G1 X82.799 Y83.612 E.00848
G1 X82.804 Y82.791 E.01738
G1 X82.78 Y81.916 E.01854
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.804 Y82.791 E-.16643
G1 X82.799 Y83.612 E-.15599
G1 X83.081 Y83.723 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/74
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I.315 J1.176 P1  F18000
G1 X95.182 Y80.483 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X97.194 Y80.483 E.04259
G1 X97.194 Y80.243 E.00508
G1 X97.609 Y80.243 E.00879
G1 X97.584 Y82.814 E.05441
G1 X97.596 Y83.151 E.00714
G1 X97.584 Y86.402 E.0688
G1 X97.611 Y89.999 E.07615
G1 X97.584 Y93.606 E.07633
G1 X97.603 Y99.757 E.13019
G1 X97.194 Y99.757 E.00865
G1 X97.194 Y99.517 E.00508
G1 X95.182 Y99.517 E.0426
G1 X95.194 Y92.987 E.13821
G1 X95.178 Y89.999 E.06324
G1 X95.194 Y86.58 E.07238
G1 X95.182 Y80.543 E.12776
M204 S10000
G1 X94.757 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.77 Y80.059 E.04262
G1 X96.77 Y79.819 E.00508
G1 X98.034 Y79.819 E.02676
G1 X98.034 Y80.203 E.00813
G1 X98.008 Y82.808 E.05513
G1 X98.02 Y83.144 E.00711
G1 X98.008 Y86.401 E.06894
G1 X98.035 Y90 E.07617
G1 X98.008 Y93.603 E.07628
G1 X98.02 Y94.272 E.01415
G1 X98.008 Y97.201 E.062
G1 X98.03 Y100.181 E.06307
G1 X96.77 Y100.181 E.02667
G1 X96.77 Y99.941 E.00508
G1 X94.757 Y99.941 E.04262
G1 X94.77 Y92.988 E.14716
G1 X94.754 Y89.999 E.06325
G1 X94.769 Y86.579 E.07239
G1 X94.757 Y80.119 E.13674
M204 S250
G1 X94.347 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.361 Y79.65 E.03962
G1 X96.361 Y79.41 E.00472
G1 X98.444 Y79.41 E.04097
G1 X98.443 Y80.205 E.01564
G1 X98.417 Y82.803 E.05109
G1 X98.43 Y83.137 E.00659
G1 X98.417 Y86.4 E.06418
G1 X98.444 Y90 E.0708
G1 X98.417 Y93.601 E.07083
G1 X98.43 Y94.269 E.01314
G1 X98.417 Y97.2 E.05766
G1 X98.443 Y100.59 E.06667
G1 X96.361 Y100.59 E.04094
G1 X96.361 Y100.35 E.00472
G1 X94.347 Y100.35 E.03962
G1 X94.36 Y92.989 E.14478
G1 X94.345 Y90 E.0588
G1 X94.36 Y86.579 E.06728
G1 X94.347 Y79.71 E.13511
; WIPE_START
M204 S6000
G1 X96.346 Y79.65 E-.38
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




G1 X95.607 Y80.908
G1 Z5.12
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.447065
G1 F1200
M204 S6000
G1 X95.607 Y99.032 E.38095
; WIPE_START
G1 X95.607 Y97.032 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.23 Y96.466 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.235 Y98.163 E.03592
G1 X96.828 Y98.117 E.00867
G1 X96.373 Y98.165 E.00969
G1 X96.032 Y98.309 E.00783
G1 X96.034 Y95.225 E.06527
G1 X96.373 Y94.926 E.00956
G1 X96.828 Y94.669 E.01106
G1 X97.224 Y94.545 E.00878
G1 X97.241 Y90.88 E.07757
G1 X96.828 Y90.834 E.00881
G1 X96.373 Y90.882 E.00969
G1 X96.031 Y91.026 E.00784
G1 X96.019 Y89.999 E.02172
G1 X96.036 Y87.94 E.04359
G1 X96.373 Y87.643 E.00951
G1 X96.828 Y87.386 E.01106
G1 X97.227 Y87.261 E.00886
G1 X97.231 Y83.596 E.07757
G1 X96.828 Y83.55 E.0086
G1 X96.373 Y83.598 E.00969
G1 X96.033 Y83.742 E.0078
G1 X96.032 Y82.045 E.03592
; WIPE_START
G1 X96.033 Y83.742 E-.32243
G1 X96.312 Y83.624 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.95 Y81.612 Z5.52 F18000
G1 X84.819 Y80.483 Z5.52
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X84.807 Y87.013 E.13821
G1 X84.822 Y90 E.06321
G1 X84.807 Y92.989 E.06326
G1 X84.819 Y99.517 E.13817
G1 X82.811 Y99.517 E.0425
G1 X82.81 Y99.757 E.00508
G1 X82.393 Y99.757 E.00882
G1 X82.417 Y97.205 E.05401
G1 X82.405 Y96.525 E.01438
G1 X82.417 Y93.588 E.06218
G1 X82.399 Y92.947 E.01357
G1 X82.39 Y90.001 E.06235
G1 X82.399 Y87.053 E.06239
G1 X82.417 Y86.412 E.01357
G1 X82.405 Y83.475 E.06218
G1 X82.417 Y82.795 E.01438
G1 X82.393 Y80.248 E.0539
G1 X82.81 Y80.25 E.00883
G1 X82.811 Y80.483 E.00493
G1 X84.759 Y80.483 E.04123
M204 S10000
G1 X85.244 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.231 Y87.012 E.14716
G1 X85.246 Y90 E.06324
G1 X85.231 Y92.989 E.06327
G1 X85.244 Y99.941 E.14714
G1 X83.233 Y99.941 E.04256
G1 X83.232 Y100.181 E.00508
G1 X81.967 Y100.181 E.02677
G1 X81.975 Y97.847 E.0494
G1 X81.993 Y97.203 E.01364
G1 X81.98 Y96.528 E.01429
G1 X81.993 Y93.593 E.06213
G1 X81.975 Y92.953 E.01354
G1 X81.965 Y90.001 E.06248
G1 X81.975 Y87.047 E.06253
G1 X81.993 Y86.407 E.01354
G1 X81.98 Y83.472 E.06213
G1 X81.993 Y82.797 E.01429
G1 X81.975 Y82.153 E.01364
G1 X81.967 Y79.822 E.04934
G1 X83.232 Y79.828 E.02678
G1 X83.234 Y80.059 E.00489
G1 X85.184 Y80.059 E.04128
M204 S250
G1 X85.654 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.64 Y87.011 E.14478
G1 X85.656 Y90 E.05879
G1 X85.64 Y92.989 E.0588
G1 X85.654 Y100.35 E.14478
G1 X83.641 Y100.35 E.0396
G1 X83.64 Y100.59 E.00472
G1 X81.557 Y100.59 E.04097
G1 X81.566 Y97.841 E.05408
G1 X81.584 Y97.201 E.01259
G1 X81.571 Y96.531 E.01318
G1 X81.583 Y93.597 E.0577
G1 X81.566 Y92.959 E.01256
M73 P74 R8
G1 X81.556 Y90.001 E.05819
G1 X81.566 Y87.041 E.05823
G1 X81.583 Y86.403 E.01256
G1 X81.571 Y83.469 E.0577
G1 X81.584 Y82.799 E.01318
G1 X81.566 Y82.159 E.01259
G1 X81.557 Y79.411 E.05406
G1 X83.64 Y79.421 E.04097
G1 X83.641 Y79.65 E.00451
G1 X85.594 Y79.65 E.03842
; WIPE_START
M204 S6000
G1 X85.607 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.394 Y80.908 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.446969
G1 F1200
M204 S6000
G1 X84.394 Y99.032 E.38087
; WIPE_START
G1 X84.394 Y97.032 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.968 Y97.172 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.969 Y98.869 E.03592
G1 X83.627 Y98.568 E.00964
G1 X83.172 Y98.311 E.01106
G1 X82.771 Y98.185 E.0089
G1 X82.776 Y94.52 E.07758
G1 X83.172 Y94.475 E.00844
G1 X83.627 Y94.523 E.00969
G1 X83.966 Y94.666 E.00779
G1 X83.965 Y91.582 E.06528
G1 X83.627 Y91.285 E.00952
G1 X83.172 Y91.028 E.01106
G1 X82.755 Y90.897 E.00924
G1 X82.752 Y90.002 E.01895
G1 X82.762 Y87.238 E.05849
G1 X83.172 Y87.192 E.00874
G1 X83.627 Y87.24 E.00969
G1 X83.965 Y87.383 E.00776
G1 X83.967 Y84.301 E.06523
G1 X83.627 Y84.002 E.00959
G1 X83.172 Y83.745 E.01106
G1 X82.768 Y83.618 E.00896
G1 X82.772 Y81.921 E.03591
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.768 Y83.618 E-.3224
G1 X83.057 Y83.709 E-.0576
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/74
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I.311 J1.177 P1  F18000
G1 X95.27 Y80.483 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X97.249 Y80.483 E.04189
G1 X97.249 Y80.243 E.00508
G1 X97.626 Y80.243 E.00798
G1 X97.625 Y80.747 E.01065
G1 X97.607 Y82.795 E.04336
G1 X97.627 Y89.999 E.15248
G1 X97.607 Y97.2 E.15242
G1 X97.621 Y99.757 E.0541
G1 X97.249 Y99.757 E.00788
G1 X97.249 Y99.517 E.00508
G1 X95.27 Y99.517 E.04189
G1 X95.27 Y80.543 E.40158
M204 S10000
G1 X94.846 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.825 Y80.059 E.04188
G1 X96.824 Y79.819 E.00508
G1 X98.051 Y79.819 E.02596
G1 X98.05 Y80.749 E.01968
G1 X98.031 Y82.797 E.04335
G1 X98.051 Y89.999 E.15244
G1 X98.031 Y97.2 E.15242
G1 X98.048 Y100.181 E.06308
G1 X96.824 Y100.181 E.0259
G1 X96.825 Y99.941 E.00508
G1 X94.846 Y99.941 E.04188
G1 X94.846 Y80.119 E.41954
M204 S250
G1 X94.437 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.415 Y79.65 E.03891
G1 X96.415 Y79.41 E.00472
G1 X98.46 Y79.41 E.04024
G1 X98.459 Y80.751 E.02638
G1 X98.441 Y82.799 E.04029
G1 X98.461 Y89.999 E.14162
G1 X98.441 Y97.2 E.14164
G1 X98.459 Y100.59 E.06667
G1 X96.415 Y100.59 E.04022
G1 X96.415 Y100.35 E.00472
G1 X94.437 Y100.35 E.03891
G1 X94.437 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.415 Y79.65 E-.37599
G1 X96.415 Y79.629 E-.00401
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




G1 X95.709 Y80.922
G1 Z5.24
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.477068
G1 F1200
M204 S6000
G1 X95.709 Y99.018 E.40747
; WIPE_START
G1 X95.709 Y97.018 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.246 Y96.485 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.25 Y98.182 E.03592
G1 X96.828 Y98.166 E.00893
G1 X96.373 Y98.251 E.0098
G1 X96.147 Y98.364 E.00535
G1 X96.147 Y95.046 E.07023
G1 X96.373 Y94.868 E.00608
G1 X96.828 Y94.65 E.01069
G1 X97.252 Y94.549 E.00922
G1 X97.262 Y90.899 E.07725
G1 X96.828 Y90.883 E.00919
G1 X96.373 Y90.968 E.0098
G1 X96.147 Y91.081 E.00535
G1 X96.13 Y90 E.02288
G1 X96.147 Y87.763 E.04735
G1 X96.373 Y87.585 E.00608
G1 X96.828 Y87.367 E.01069
G1 X97.257 Y87.264 E.00933
G1 X97.247 Y83.615 E.07724
G1 X96.828 Y83.6 E.00887
G1 X96.373 Y83.685 E.0098
G1 X96.147 Y83.798 E.00535
G1 X96.147 Y82.101 E.03592
; WIPE_START
G1 X96.147 Y83.798 E-.32243
G1 X96.373 Y83.685 E-.04799
G1 X96.422 Y83.675 E-.00958
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.059 Y81.665 Z5.64 F18000
G1 X84.73 Y80.483 Z5.64
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X84.73 Y99.517 E.40285
G1 X82.753 Y99.517 E.04186
G1 X82.752 Y99.757 E.00508
G1 X82.379 Y99.757 E.0079
G1 X82.393 Y97.2 E.0541
G1 X82.373 Y90.163 E.14895
G1 X82.393 Y82.8 E.15586
G1 X82.379 Y80.243 E.0541
G1 X82.754 Y80.243 E.00794
G1 X82.755 Y80.483 E.00508
G1 X84.67 Y80.483 E.04053
M204 S10000
G1 X85.154 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.154 Y99.941 E.42081
G1 X83.177 Y99.941 E.04186
G1 X83.177 Y100.181 E.00508
G1 X81.953 Y100.181 E.0259
G1 X81.969 Y97.2 E.06308
G1 X81.949 Y90.163 E.14895
G1 X81.969 Y82.8 E.15586
G1 X81.953 Y79.819 E.06308
G1 X83.177 Y79.819 E.02592
G1 X83.178 Y80.059 E.00508
G1 X85.094 Y80.059 E.04056
M204 S250
G1 X85.564 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.564 Y100.35 E.40715
G1 X83.586 Y100.35 E.03891
G1 X83.586 Y100.59 E.00472
G1 X81.541 Y100.59 E.04021
G1 X81.56 Y97.2 E.06667
G1 X81.54 Y90.163 E.13841
G1 X81.56 Y82.8 E.14484
G1 X81.541 Y79.41 E.06667
G1 X83.586 Y79.41 E.04021
G1 X83.586 Y79.65 E.00472
G1 X85.504 Y79.65 E.03771
; WIPE_START
M204 S6000
G1 X85.509 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.751 Y81.93 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.754 Y83.627 E.03592
G1 X83.296 Y83.773 E.01189
G1 X83.854 Y84.108 E.01376
G1 X83.854 Y87.423 E.07017
G1 X83.296 Y87.253 E.01233
G1 X82.744 Y87.258 E.01169
G1 X82.736 Y90.165 E.06152
G1 X82.738 Y90.905 E.01568
G1 X83.296 Y91.056 E.01224
G1 X83.854 Y91.391 E.01376
G1 X83.854 Y94.706 E.07017
G1 X83.296 Y94.536 E.01233
G1 X82.749 Y94.541 E.0116
G1 X82.751 Y98.192 E.07728
G1 X83.296 Y98.339 E.01196
G1 X83.854 Y98.674 E.01376
G1 X83.854 Y96.977 E.03592
; WIPE_START
G1 X83.854 Y98.674 E-.32243
G1 X83.594 Y98.518 E-.05757
; WIPE_END
M73 P75 R8
G1 E-.02 F1800
M204 S10000
G1 X84.292 Y99.078 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.477089
G1 F1200
M204 S6000
G1 X84.292 Y80.982 E.40749
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.292 Y82.982 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/74
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I.268 J1.187 P1  F18000
G1 X95.365 Y80.483 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.3 Y80.483 E.04095
G1 X97.299 Y80.243 E.00508
G1 X97.641 Y80.243 E.00724
G1 X97.642 Y80.753 E.01079
G1 X97.641 Y99.757 E.40222
G1 X97.299 Y99.757 E.00723
G1 X97.3 Y99.517 E.00508
G1 X95.365 Y99.517 E.04095
G1 X95.365 Y80.543 E.40158
M204 S10000
G1 X94.941 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.875 Y80.059 E.04093
G1 X96.874 Y79.819 E.00508
G1 X98.065 Y79.819 E.02522
G1 X98.066 Y80.753 E.01977
G1 X98.065 Y100.181 E.4112
G1 X96.874 Y100.181 E.02521
G1 X96.875 Y99.941 E.00508
G1 X94.941 Y99.941 E.04093
G1 X94.941 Y80.119 E.41954
M204 S250
G1 X94.531 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.464 Y79.65 E.03802
G1 X96.464 Y79.41 E.00472
G1 X98.474 Y79.41 E.03955
G1 X98.475 Y80.753 E.02642
G1 X98.474 Y100.59 E.39017
G1 X96.464 Y100.59 E.03955
G1 X96.464 Y100.35 E.00472
G1 X94.531 Y100.35 E.03802
G1 X94.531 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.464 Y79.65 E-.36742
G1 X96.464 Y79.584 E-.01258
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




G1 X96.249 Y82.137
G1 Z5.36
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.249 Y83.834 E.03592
G1 X96.373 Y83.763 E.00303
G1 X96.828 Y83.642 E.00997
G1 X97.279 Y83.625 E.00955
G1 X97.279 Y87.267 E.07709
G1 X96.828 Y87.341 E.00966
G1 X96.373 Y87.523 E.01037
G1 X96.249 Y87.61 E.00321
G1 X96.249 Y91.117 E.07423
G1 X96.373 Y91.046 E.00303
G1 X96.828 Y90.925 E.00997
G1 X97.278 Y90.908 E.00954
G1 X97.278 Y94.551 E.07709
G1 X96.828 Y94.624 E.00966
G1 X96.373 Y94.806 E.01037
G1 X96.249 Y94.893 E.00321
G1 X96.249 Y98.4 E.07423
G1 X96.373 Y98.329 E.00303
G1 X96.828 Y98.208 E.00997
G1 X97.278 Y98.192 E.00953
G1 X97.278 Y96.495 E.03592
; WIPE_START
G1 X97.278 Y98.192 E-.32243
G1 X96.975 Y98.203 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.807 Y99.075 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.485332
G1 F1200
M204 S6000
G1 X95.807 Y80.985 E.41476
; WIPE_START
G1 X95.807 Y82.985 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.359 Y81.317 Z5.76 F18000
G1 X84.636 Y80.483 Z5.76
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.636 Y99.517 E.40285
G1 X82.706 Y99.517 E.04084
G1 X82.706 Y99.757 E.00508
G1 X82.361 Y99.757 E.00729
G1 X82.361 Y80.243 E.41301
G1 X82.706 Y80.243 E.00731
G1 X82.707 Y80.483 E.00508
G1 X84.576 Y80.483 E.03956
M204 S10000
G1 X85.06 Y80.059 F18000
G1 F1500
M204 S500
G1 X85.06 Y99.941 E.42081
G1 X83.129 Y99.941 E.04086
G1 X83.129 Y100.181 E.00508
G1 X81.937 Y100.181 E.02523
G1 X81.937 Y79.819 E.43097
G1 X83.129 Y79.819 E.02524
G1 X83.13 Y80.059 E.00508
G1 X85 Y80.059 E.03958
M204 S250
G1 X85.469 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.469 Y100.35 E.40715
G1 X83.538 Y100.35 E.03799
G1 X83.537 Y100.59 E.00472
G1 X81.527 Y100.59 E.03953
G1 X81.527 Y79.41 E.41659
G1 X83.537 Y79.41 E.03953
G1 X83.538 Y79.65 E.00472
G1 X85.409 Y79.65 E.03681
; WIPE_START
M204 S6000
G1 X85.415 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.724 Y81.929 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.724 Y83.626 E.03592
G1 X83.296 Y83.737 E.01235
G1 X83.752 Y83.973 E.01086
G1 X83.752 Y87.48 E.07421
G1 X83.296 Y87.305 E.01033
G1 X82.724 Y87.267 E.01215
G1 X82.724 Y90.91 E.07709
G1 X83.296 Y91.021 E.01235
G1 X83.752 Y91.257 E.01086
G1 X83.752 Y94.763 E.07421
M73 P75 R7
G1 X83.296 Y94.588 E.01033
G1 X82.724 Y94.55 E.01215
G1 X82.724 Y98.193 E.0771
G1 X83.296 Y98.304 E.01235
G1 X83.752 Y98.54 E.01086
G1 X83.752 Y96.843 E.03592
; WIPE_START
G1 X83.752 Y98.54 E-.32243
G1 X83.483 Y98.4 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.194 Y99.075 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.485332
G1 F1200
M204 S6000
G1 X84.194 Y80.985 E.41476
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.194 Y82.985 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/74
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I.264 J1.188 P1  F18000
G1 X95.468 Y80.483 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
M73 P76 R7
G1 X97.341 Y80.483 E.03966
G1 X97.342 Y80.243 E.00508
G1 X97.653 Y80.243 E.0066
G1 X97.654 Y80.747 E.01066
G1 X97.653 Y99.757 E.40235
G1 X97.342 Y99.757 E.00658
G1 X97.341 Y99.517 E.00508
G1 X95.474 Y99.517 E.03953
G1 X95.468 Y80.543 E.40158
M204 S10000
G1 X95.043 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.918 Y80.059 E.03967
G1 X96.918 Y79.819 E.00508
G1 X98.077 Y79.819 E.02454
G1 X98.078 Y80.747 E.01964
G1 X98.077 Y100.181 E.41133
G1 X96.918 Y100.181 E.02454
G1 X96.918 Y99.941 E.00508
G1 X95.047 Y99.941 E.0396
G1 X95.043 Y80.119 E.41954
M204 S250
G1 X94.634 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.509 Y79.65 E.03688
G1 X96.509 Y79.41 E.00472
G1 X98.486 Y79.41 E.03889
G1 X98.487 Y80.747 E.0263
G1 X98.486 Y100.59 E.39029
G1 X96.509 Y100.59 E.03889
G1 X96.509 Y100.35 E.00472
G1 X94.635 Y100.35 E.03686
G1 X94.634 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.509 Y79.65 E-.35645
G1 X96.509 Y79.526 E-.02355
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




G1 X97.291 Y81.931
G1 Z5.48
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.291 Y83.628 E.03592
G1 X96.828 Y83.678 E.00985
G1 X96.37 Y83.837 E.01027
G1 X96.37 Y87.458 E.07664
G1 X96.828 Y87.31 E.01019
G1 X97.29 Y87.27 E.00983
G1 X97.29 Y90.911 E.07707
G1 X96.828 Y90.961 E.00984
G1 X96.37 Y91.12 E.01027
G1 X96.37 Y94.741 E.07664
G1 X96.828 Y94.593 E.01019
G1 X97.29 Y94.553 E.00982
G1 X97.29 Y98.194 E.07707
G1 X96.828 Y98.244 E.00984
G1 X96.37 Y98.403 E.01027
G1 X96.37 Y96.706 E.03592
; WIPE_START
G1 X96.37 Y98.403 E-.32243
G1 X96.656 Y98.304 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.922 Y99.069 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.500412
G1 F1200
M204 S6000
G1 X95.919 Y80.994 E.42801
; WIPE_START
G1 X95.919 Y82.994 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.465 Y81.352 Z5.88 F18000
G1 X84.527 Y80.483 Z5.88
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.533 Y99.517 E.40285
G1 X82.662 Y99.517 E.0396
G1 X82.662 Y99.757 E.00508
G1 X82.348 Y99.757 E.00663
G1 X82.348 Y80.243 E.41301
G1 X82.664 Y80.243 E.00667
G1 X82.665 Y80.483 E.00508
G1 X84.467 Y80.483 E.03813
M204 S10000
G1 X84.954 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.958 Y99.941 E.42081
G1 X83.085 Y99.941 E.03963
G1 X83.085 Y100.181 E.00508
G1 X81.924 Y100.181 E.02456
G1 X81.924 Y79.819 E.43097
G1 X83.086 Y79.819 E.02458
G1 X83.087 Y80.059 E.00508
G1 X84.894 Y80.059 E.03824
M204 S250
G1 X85.366 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.367 Y100.35 E.40715
G1 X83.493 Y100.35 E.03685
G1 X83.493 Y100.59 E.00472
G1 X81.515 Y100.59 E.0389
G1 X81.515 Y79.41 E.41659
G1 X83.493 Y79.41 E.0389
G1 X83.494 Y79.65 E.00472
G1 X85.306 Y79.65 E.03564
; WIPE_START
M204 S6000
G1 X85.312 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.631 Y82.119 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.631 Y83.816 E.03592
G1 X83.172 Y83.668 E.01021
G1 X82.711 Y83.628 E.00979
G1 X82.711 Y87.269 E.07707
G1 X83.172 Y87.32 E.00981
G1 X83.631 Y87.478 E.01028
G1 X83.631 Y91.1 E.07664
G1 X83.172 Y90.951 E.01021
G1 X82.711 Y90.911 E.00979
G1 X82.711 Y94.552 E.07707
G1 X83.172 Y94.603 E.00981
G1 X83.631 Y94.762 E.01028
G1 X83.631 Y98.383 E.07664
G1 X83.172 Y98.234 E.01021
G1 X82.711 Y98.194 E.00979
G1 X82.711 Y96.497 E.03592
; WIPE_START
G1 X82.711 Y98.194 E-.32243
G1 X83.013 Y98.221 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.082 Y99.066 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.500432
G1 F1200
M204 S6000
G1 X84.079 Y80.991 E.42803
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1200
G1 X84.079 Y82.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/74
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I.259 J1.189 P1  F18000
G1 X95.586 Y80.483 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.389 Y80.483 E.03817
G1 X97.388 Y80.243 E.00508
G1 X97.665 Y80.243 E.00587
G1 X97.665 Y99.757 E.41301
G1 X97.388 Y99.757 E.00586
G1 X97.389 Y99.517 E.00508
G1 X95.586 Y99.517 E.03817
M73 P77 R7
G1 X95.59 Y91.436 E.17104
G1 X95.573 Y90 E.03038
G1 X95.59 Y88.564 E.0304
G1 X95.586 Y80.543 E.16977
M204 S10000
G1 X95.156 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.963 Y80.059 E.03824
G1 X96.961 Y79.819 E.00508
G1 X98.089 Y79.819 E.02387
G1 X98.089 Y100.181 E.43097
G1 X96.961 Y100.181 E.02387
G1 X96.963 Y99.941 E.00508
G1 X95.156 Y99.941 E.03824
G1 X95.156 Y80.119 E.41954
M204 S250
G1 X94.742 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.551 Y79.65 E.03559
G1 X96.55 Y79.41 E.00472
G1 X98.498 Y79.41 E.03832
G1 X98.499 Y79.778 E.00724
G1 X98.498 Y100.59 E.40936
G1 X96.55 Y100.59 E.03832
G1 X96.551 Y100.35 E.00472
G1 X94.742 Y100.35 E.03559
G1 X94.757 Y99.119 E.02421
G1 X94.757 Y91.441 E.15103
G1 X94.74 Y90 E.02834
G1 X94.757 Y88.559 E.02835
G1 X94.757 Y80.881 E.15103
G1 X94.742 Y79.71 E.02303
; WIPE_START
M204 S6000
G1 X96.551 Y79.65 E-.34386
G1 X96.55 Y79.46 E-.03614
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




G1 X97.302 Y81.927
G1 Z5.6
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.302 Y83.624 E.03592
G1 X96.828 Y83.708 E.01019
G1 X96.49 Y83.851 E.00778
G1 X96.49 Y87.354 E.07415
G1 X96.828 Y87.272 E.00737
G1 X97.302 Y87.268 E.01003
G1 X97.302 Y90.907 E.07701
G1 X96.828 Y90.991 E.01019
G1 X96.49 Y91.134 E.00778
G1 X96.49 Y94.637 E.07415
G1 X96.828 Y94.555 E.00737
G1 X97.302 Y94.551 E.01003
G1 X97.302 Y98.19 E.07701
G1 X96.828 Y98.274 E.01019
G1 X96.49 Y98.417 E.00778
G1 X96.49 Y96.72 E.03592
; WIPE_START
G1 X96.49 Y98.417 E-.32243
G1 X96.769 Y98.299 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.038 Y99.065 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.50404
G1 F1200
M204 S6000
G1 X96.038 Y80.995 E.43117
; WIPE_START
G1 X96.038 Y82.995 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.578 Y81.383 Z6 F18000
G1 X84.415 Y80.483 Z6
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.41 Y88.564 E.17104
G1 X84.427 Y90 E.03038
G1 X84.41 Y91.436 E.0304
G1 X84.415 Y99.517 E.17104
G1 X82.615 Y99.517 E.03811
G1 X82.615 Y99.757 E.00508
G1 X82.336 Y99.757 E.00591
G1 X82.336 Y80.243 E.41301
G1 X82.615 Y80.243 E.00591
G1 X82.615 Y80.483 E.00508
G1 X84.355 Y80.483 E.03684
M204 S10000
G1 X84.845 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.845 Y99.941 E.42081
G1 X83.04 Y99.941 E.0382
G1 X83.04 Y100.181 E.00508
G1 X81.912 Y100.181 E.02389
G1 X81.912 Y79.819 E.43097
G1 X83.04 Y79.819 E.02389
G1 X83.04 Y80.059 E.00508
G1 X84.785 Y80.059 E.03693
M204 S250
G1 X85.259 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.244 Y80.881 E.02421
G1 X85.244 Y88.559 E.15103
G1 X85.261 Y90 E.02834
G1 X85.244 Y91.441 E.02835
G1 X85.244 Y99.119 E.15103
G1 X85.259 Y100.35 E.02421
G1 X83.45 Y100.35 E.03558
G1 X83.451 Y100.59 E.00472
G1 X81.503 Y100.59 E.03832
G1 X81.503 Y79.41 E.41659
G1 X83.451 Y79.41 E.03832
G1 X83.45 Y79.65 E.00472
G1 X85.199 Y79.65 E.0344
; WIPE_START
M204 S6000
G1 X85.244 Y80.881 E-.23398
G1 X85.244 Y81.649 E-.14602
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.963 Y80.935 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.50405
G1 F1200
M204 S6000
G1 X83.963 Y99.005 E.43117
; WIPE_START
G1 X83.963 Y97.005 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.699 Y96.496 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.699 Y98.193 E.03592
G1 X83.172 Y98.197 E.01002
G1 X83.511 Y98.279 E.00738
G1 X83.511 Y94.776 E.07414
G1 X83.172 Y94.633 E.00779
G1 X82.699 Y94.548 E.01018
G1 X82.699 Y90.91 E.07701
G1 X83.172 Y90.913 E.01002
G1 X83.511 Y90.996 E.00738
G1 X83.511 Y87.493 E.07415
G1 X83.172 Y87.349 E.00779
G1 X82.699 Y87.265 E.01018
G1 X82.699 Y83.627 E.07701
G1 X83.172 Y83.63 E.01002
G1 X83.511 Y83.713 E.00738
G1 X83.511 Y82.016 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X83.511 Y83.713 E-.32243
G1 X83.217 Y83.641 E-.05757
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/74
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I.298 J1.18 P1  F18000
G1 X95.701 Y80.483 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X97.668 Y80.483 E.04164
G1 X97.658 Y82.8 E.04903
G1 X97.675 Y90 E.15239
G1 X97.658 Y97.202 E.15245
G1 X97.669 Y99.517 E.04899
G1 X95.701 Y99.517 E.04165
M73 P78 R7
G1 X95.701 Y90.924 E.18187
G1 X95.684 Y90 E.01955
G1 X95.701 Y89.076 E.01955
G1 X95.701 Y80.543 E.1806
M204 S10000
G1 X95.271 Y80.059 F18000
G1 F1500
M204 S500
G1 X96.997 Y80.059 E.03652
G1 X96.996 Y79.819 E.00508
G1 X98.095 Y79.819 E.02326
G1 X98.082 Y82.8 E.06309
G1 X98.096 Y100.181 E.36788
G1 X96.996 Y100.181 E.02328
G1 X96.997 Y99.941 E.00508
G1 X95.271 Y99.941 E.03652
G1 X95.271 Y80.119 E.41954
M204 S250
G1 X94.855 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.587 Y79.65 E.03408
G1 X96.587 Y79.41 E.00472
G1 X98.506 Y79.41 E.03775
G1 X98.492 Y82.8 E.06667
G1 X98.508 Y90 E.14161
G1 X98.492 Y97.2 E.14163
G1 X98.507 Y100.59 E.06667
G1 X96.587 Y100.59 E.03777
G1 X96.587 Y100.35 E.00472
G1 X94.855 Y100.35 E.03408
G1 X94.868 Y99.629 E.01419
G1 X94.868 Y90.931 E.17107
G1 X94.85 Y90 E.01832
G1 X94.868 Y89.069 E.01832
G1 X94.868 Y80.371 E.17107
G1 X94.856 Y79.71 E.01301
; WIPE_START
M204 S6000
G1 X96.587 Y79.65 E-.32917
G1 X96.587 Y79.41 E-.0456
G1 X96.615 Y79.41 E-.00523
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




G1 X97.209 Y80.151
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.882 Y80.151 E.00806
; WIPE_START
G1 X97.209 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.299 Y81.915 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.297 Y83.612 E.03592
G1 X96.828 Y83.732 E.01025
G1 X96.61 Y83.842 E.00518
G1 X96.61 Y87.263 E.07242
G1 X96.828 Y87.228 E.00468
G1 X97.306 Y87.26 E.01014
G1 X97.312 Y89.998 E.05795
G1 X97.31 Y90.894 E.01897
G1 X96.828 Y91.015 E.01052
G1 X96.61 Y91.125 E.00518
G1 X96.61 Y94.546 E.07242
G1 X96.828 Y94.511 E.00468
G1 X97.301 Y94.542 E.01004
G1 X97.3 Y98.178 E.07695
G1 X96.828 Y98.298 E.0103
G1 X96.61 Y98.408 E.00518
G1 X96.61 Y96.711 E.03592
; WIPE_START
G1 X96.61 Y98.408 E-.32243
G1 X96.828 Y98.298 E-.04646
G1 X96.885 Y98.284 E-.0111
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.155 Y99.062 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.511028
G1 F1200
M204 S6000
G1 X96.155 Y80.998 E.43735
; WIPE_START
G1 X96.155 Y82.998 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.632 Y90.615 Z6.12 F18000
G1 X97.209 Y99.849 Z6.12
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.883 Y99.849 E.00807
; WIPE_START
G1 X97.209 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.975 Y93.498 Z6.12 F18000
G1 X84.3 Y80.483 Z6.12
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.3 Y89.076 E.18187
G1 X84.317 Y90 E.01955
G1 X84.3 Y90.924 E.01956
G1 X84.3 Y99.517 E.18187
G1 X82.332 Y99.517 E.04165
G1 X82.332 Y80.483 E.40285
G1 X84.24 Y80.483 E.04038
M204 S10000
G1 X84.729 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.729 Y99.941 E.42081
G1 X83.007 Y99.941 E.03645
G1 X83.007 Y100.181 E.00508
G1 X81.905 Y100.181 E.02332
G1 X81.918 Y97.2 E.06308
G1 X81.905 Y79.819 E.36788
G1 X83.007 Y79.819 E.02333
G1 X83.008 Y80.059 E.00508
G1 X84.669 Y80.059 E.03517
M204 S250
G1 X85.146 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.133 Y80.371 E.01419
G1 X85.133 Y89.069 E.17107
G1 X85.15 Y90 E.01832
G1 X85.133 Y90.931 E.01832
G1 X85.133 Y99.629 E.17107
G1 X85.146 Y100.35 E.01419
G1 X83.415 Y100.35 E.03404
G1 X83.414 Y100.59 E.00472
G1 X81.493 Y100.59 E.03778
G1 X81.509 Y97.2 E.06667
G1 X81.493 Y90.001 E.14161
G1 X81.509 Y82.8 E.14163
G1 X81.493 Y79.41 E.06667
G1 X83.414 Y79.41 E.03778
G1 X83.415 Y79.65 E.00472
G1 X85.086 Y79.65 E.03286
; WIPE_START
M204 S6000
G1 X85.133 Y80.371 E-.13731
G1 X85.133 Y81.648 E-.24269
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.845 Y80.938 Z6.12 F18000
G1 Z5.72
M73 P78 R6
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.511038
G1 F1200
M204 S6000
G1 X83.845 Y99.002 E.43736
; WIPE_START
G1 X83.845 Y97.002 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.796 Y99.849 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.118 Y99.849 E.00811
; WIPE_START
G1 X82.796 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.695 Y96.488 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X82.695 Y98.185 E.03592
G1 X83.172 Y98.152 E.01013
G1 X83.391 Y98.188 E.00469
G1 X83.391 Y94.767 E.07241
G1 X83.172 Y94.656 E.00519
G1 X82.695 Y94.536 E.01042
G1 X82.695 Y90.902 E.07693
G1 X83.172 Y90.869 E.01013
G1 X83.391 Y90.905 E.00469
G1 X83.391 Y87.484 E.07241
G1 X83.172 Y87.373 E.00519
M73 P79 R6
G1 X82.695 Y87.253 E.01042
G1 X82.695 Y83.619 E.07693
G1 X83.172 Y83.586 E.01013
G1 X83.391 Y83.622 E.00469
G1 X83.391 Y81.925 E.03592
; WIPE_START
G1 X83.391 Y83.622 E-.32243
G1 X83.172 Y83.586 E-.04215
G1 X83.091 Y83.592 E-.01543
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.796 Y80.151 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.118 Y80.151 E.00811
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.796 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/74
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-.031 J1.217 P1  F18000
G1 X95.803 Y80.483 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.672 Y80.483 E.03957
G1 X97.66 Y82.8 E.04903
G1 X97.683 Y89.999 E.15238
G1 X97.66 Y97.2 E.15242
G1 X97.675 Y99.517 E.04902
G1 X95.803 Y99.517 E.03962
G1 X95.803 Y80.543 E.40158
M204 S10000
G1 X95.379 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.032 Y80.059 E.03499
G1 X97.031 Y79.819 E.00508
G1 X98.1 Y79.819 E.02262
G1 X98.084 Y82.8 E.06309
G1 X98.107 Y89.999 E.15238
G1 X98.084 Y97.2 E.15242
G1 X98.103 Y100.181 E.06308
G1 X97.031 Y100.181 E.02268
G1 X97.032 Y99.941 E.00508
G1 X95.379 Y99.941 E.03499
G1 X95.379 Y80.119 E.41954
M204 S250
G1 X94.969 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.622 Y79.65 E.0325
G1 X96.621 Y79.41 E.00472
G1 X98.513 Y79.41 E.0372
G1 X98.511 Y79.492 E.0016
G1 X98.493 Y82.8 E.06507
G1 X98.516 Y89.999 E.14161
G1 X98.493 Y97.2 E.14164
G1 X98.515 Y100.59 E.06667
G1 X96.621 Y100.59 E.03725
G1 X96.622 Y100.35 E.00472
G1 X94.969 Y100.35 E.0325
G1 X94.969 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.622 Y79.65 E-.31417
G1 X96.621 Y79.41 E-.0456
G1 X96.728 Y79.41 E-.02023
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




G1 X97.244 Y80.151
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.886 Y80.151 E.00769
; WIPE_START
G1 X97.244 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.302 Y81.897 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.299 Y83.594 E.03592
G1 X96.828 Y83.749 E.01051
G1 X96.73 Y83.807 E.00242
G1 X96.73 Y87.184 E.07147
G1 X96.828 Y87.176 E.00209
G1 X97.311 Y87.247 E.01034
G1 X97.32 Y89.999 E.05824
G1 X97.317 Y90.875 E.01854
G1 X96.828 Y91.032 E.01088
G1 X96.73 Y91.091 E.00242
G1 X96.73 Y94.467 E.07147
G1 X96.828 Y94.459 E.00209
G1 X97.305 Y94.528 E.01021
G1 X97.303 Y98.16 E.07686
G1 X96.828 Y98.316 E.01058
G1 X96.73 Y98.374 E.00242
G1 X96.73 Y96.677 E.03592
; WIPE_START
G1 X96.73 Y98.374 E-.32243
G1 X96.828 Y98.316 E-.0217
G1 X97.007 Y98.257 E-.03587
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.266 Y99.053 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.528352
G1 F1200
M204 S6000
G1 X96.266 Y81.007 E.45251
; WIPE_START
G1 X96.266 Y83.007 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.709 Y90.627 Z6.24 F18000
G1 X97.244 Y99.849 Z6.24
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.889 Y99.849 E.00772
; WIPE_START
G1 X97.244 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.98 Y93.519 Z6.24 F18000
G1 X84.198 Y80.483 Z6.24
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.198 Y99.517 E.40285
G1 X82.326 Y99.517 E.03961
G1 X82.341 Y97.2 E.04902
G1 X82.318 Y90.001 E.15239
G1 X82.341 Y82.8 E.15242
G1 X82.326 Y80.483 E.04902
G1 X84.138 Y80.483 E.03834
M204 S10000
G1 X84.622 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.622 Y99.941 E.42081
G1 X82.968 Y99.941 E.03501
G1 X82.969 Y100.181 E.00508
G1 X81.898 Y100.181 E.02266
G1 X81.917 Y97.2 E.06308
G1 X81.894 Y90.001 E.15239
G1 X81.917 Y82.8 E.15242
G1 X81.898 Y79.819 E.06308
G1 X82.969 Y79.819 E.02266
G1 X82.968 Y80.059 E.00508
G1 X84.562 Y80.059 E.03374
M204 S250
G1 X85.031 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.031 Y100.35 E.40715
G1 X83.378 Y100.35 E.03251
G1 X83.379 Y100.59 E.00472
G1 X81.486 Y100.59 E.03722
G1 X81.507 Y97.2 E.06667
G1 X81.485 Y90.001 E.14161
G1 X81.507 Y82.8 E.14164
G1 X81.486 Y79.41 E.06667
G1 X83.379 Y79.41 E.03722
G1 X83.378 Y79.65 E.00472
G1 X84.971 Y79.65 E.03133
; WIPE_START
M204 S6000
G1 X84.977 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.756 Y80.151 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.112 Y80.151 E.0077
; WIPE_START
G1 X82.756 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.271 Y81.845 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.271 Y83.542 E.03592
G1 X83.172 Y83.534 E.0021
G1 X82.701 Y83.601 E.01007
G1 X82.69 Y87.234 E.07689
G1 X83.172 Y87.391 E.01073
G1 X83.271 Y87.449 E.00243
G1 X83.271 Y90.826 E.07146
G1 X83.172 Y90.818 E.0021
G1 X82.684 Y90.89 E.01044
G1 X82.695 Y94.518 E.07678
G1 X83.172 Y94.674 E.01062
G1 X83.271 Y94.732 E.00243
G1 X83.271 Y98.109 E.07146
G1 X83.172 Y98.101 E.0021
G1 X82.698 Y98.169 E.01015
G1 X82.701 Y96.472 E.03592
; WIPE_START
G1 X82.698 Y98.169 E-.32243
G1 X82.998 Y98.126 E-.05758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.734 Y99.053 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.528372
G1 F1200
M204 S6000
G1 X83.734 Y81.007 E.45252
; WIPE_START
G1 X83.734 Y83.007 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.292 Y90.627 Z6.24 F18000
M73 P80 R6
G1 X82.756 Y99.849 Z6.24
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.112 Y99.849 E.0077
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.756 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/74
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I1.006 J.684 P1  F18000
G1 X95.924 Y80.483 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.677 Y80.483 E.03711
G1 X97.662 Y82.799 E.04901
G1 X97.691 Y90 E.15242
G1 X97.662 Y97.202 E.15243
G1 X97.68 Y99.517 E.049
G1 X95.924 Y99.517 E.03718
G1 X95.924 Y80.543 E.40158
M204 S10000
G1 X95.5 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.063 Y80.059 E.03309
G1 X97.063 Y79.819 E.00508
G1 X98.106 Y79.819 E.02208
G1 X98.086 Y82.799 E.06308
G1 X98.115 Y90 E.15241
G1 X98.086 Y97.201 E.15242
G1 X98.11 Y100.181 E.06307
G1 X97.063 Y100.181 E.02217
G1 X97.063 Y99.941 E.00508
G1 X95.5 Y99.941 E.03309
G1 X95.5 Y80.119 E.41954
M204 S250
G1 X95.09 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.653 Y79.65 E.03074
G1 X96.653 Y79.41 E.00472
G1 X98.52 Y79.41 E.03674
G1 X98.516 Y79.701 E.00572
G1 X98.495 Y82.8 E.06095
G1 X98.524 Y90 E.14162
G1 X98.495 Y97.2 E.14163
G1 X98.522 Y100.59 E.06667
G1 X96.653 Y100.59 E.03677
G1 X96.653 Y100.35 E.00472
G1 X95.09 Y100.35 E.03074
G1 X95.09 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.653 Y79.65 E-.29714
G1 X96.653 Y79.41 E-.0456
G1 X96.849 Y79.41 E-.03726
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




G1 X97.275 Y80.151
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.891 Y80.151 E.00737
; WIPE_START
G1 X97.275 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.305 Y81.871 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.302 Y83.568 E.03592
G1 X96.85 Y83.752 E.01033
G1 X96.85 Y87.121 E.07132
G1 X97.317 Y87.228 E.01014
G1 X97.328 Y90 E.05868
G1 X97.324 Y90.847 E.01792
G1 X96.85 Y91.035 E.01081
G1 X96.85 Y94.405 E.07132
G1 X97.31 Y94.508 E.00998
G1 X97.306 Y98.134 E.07674
G1 X96.85 Y98.318 E.01042
G1 X96.85 Y96.621 E.03592
; WIPE_START
G1 X96.85 Y98.318 E-.32243
G1 X97.13 Y98.205 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.387 Y99.054 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.527372
G1 F1200
M204 S6000
G1 X96.387 Y81.006 E.45165
; WIPE_START
G1 X96.387 Y83.006 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.789 Y90.628 Z6.36 F18000
G1 X97.275 Y99.849 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.895 Y99.849 E.00742
; WIPE_START
G1 X97.275 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.977 Y93.542 Z6.36 F18000
G1 X84.077 Y80.483 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.077 Y99.517 E.40285
G1 X82.321 Y99.517 E.03717
G1 X82.339 Y97.202 E.049
G1 X82.311 Y90 E.15243
G1 X82.339 Y82.798 E.15243
G1 X82.321 Y80.483 E.049
G1 X84.017 Y80.483 E.0359
M204 S10000
G1 X84.501 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.501 Y99.941 E.42081
G1 X82.943 Y99.941 E.03298
G1 X82.942 Y100.181 E.00508
G1 X81.891 Y100.181 E.02223
G1 X81.915 Y97.201 E.06307
G1 X81.887 Y90 E.15241
G1 X81.915 Y82.799 E.15242
G1 X81.891 Y79.819 E.06307
G1 X82.943 Y79.819 E.02225
G1 X82.945 Y80.059 E.00508
G1 X84.441 Y80.059 E.03168
M204 S250
G1 X84.91 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.91 Y100.35 E.40715
G1 X83.35 Y100.35 E.03069
G1 X83.349 Y100.59 E.00472
G1 X81.479 Y100.59 E.03678
G1 X81.506 Y97.2 E.06667
G1 X81.477 Y90 E.14163
G1 X81.506 Y82.8 E.14163
G1 X81.479 Y79.41 E.06667
G1 X83.349 Y79.41 E.03678
G1 X83.351 Y79.65 E.00472
G1 X84.85 Y79.65 E.0295
; WIPE_START
M204 S6000
G1 X84.856 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.733 Y80.151 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.106 Y80.151 E.0075
; WIPE_START
G1 X82.733 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.151 Y81.783 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X83.151 Y83.48 E.03592
G1 X82.699 Y83.58 E.0098
G1 X82.685 Y87.207 E.07677
G1 X83.151 Y87.394 E.01063
G1 X83.151 Y90.763 E.07131
G1 X82.677 Y90.872 E.01029
G1 X82.691 Y94.492 E.07661
G1 X83.151 Y94.677 E.01049
G1 X83.151 Y98.046 E.07131
G1 X82.695 Y98.148 E.0099
G1 X82.699 Y96.451 E.03592
; WIPE_START
G1 X82.695 Y98.148 E-.32242
G1 X82.99 Y98.082 E-.05758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.614 Y99.054 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.527372
G1 F1200
M204 S6000
G1 X83.614 Y81.006 E.45165
; WIPE_START
G1 X83.614 Y83.006 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.215 Y90.628 Z6.36 F18000
G1 X82.731 Y99.849 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.106 Y99.849 E.00748
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.731 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 50/74
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.36 I1.003 J.689 P1  F18000
G1 X96.044 Y80.483 Z6.36
G1 Z6.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
M73 P81 R6
G1 X97.685 Y80.483 E.03475
G1 X97.663 Y82.797 E.04896
G1 X97.697 Y90 E.15246
G1 X97.663 Y97.203 E.15247
G1 X97.685 Y99.517 E.04897
G1 X96.044 Y99.517 E.03474
G1 X96.044 Y80.543 E.40158
M204 S10000
G1 X95.62 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.093 Y80.059 E.03118
G1 X97.092 Y79.819 E.00508
G1 X98.116 Y79.819 E.02168
G1 X98.088 Y82.798 E.06305
G1 X98.122 Y90 E.15243
G1 X98.088 Y97.202 E.15244
G1 X98.116 Y100.181 E.06305
G1 X97.092 Y100.181 E.02167
G1 X97.093 Y99.941 E.00508
G1 X95.62 Y99.941 E.03118
G1 X95.62 Y80.119 E.41954
M204 S250
G1 X95.21 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.682 Y79.65 E.02895
G1 X96.681 Y79.41 E.00472
G1 X98.529 Y79.41 E.03635
G1 X98.497 Y82.799 E.06667
G1 X98.531 Y90 E.14163
G1 X98.497 Y97.201 E.14163
G1 X98.529 Y100.59 E.06667
G1 X96.681 Y100.59 E.03634
G1 X96.682 Y100.35 E.00472
G1 X95.21 Y100.35 E.02895
G1 X95.21 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.682 Y79.65 E-.27987
G1 X96.681 Y79.41 E-.0456
G1 X96.968 Y79.41 E-.05453
; WIPE_END
G1 E-.02 F1800
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




G1 X97.305 Y80.151
G1 Z6.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.901 Y80.151 E.00713
; WIPE_START
G1 X97.305 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.453 Y80.893 Z6.48 F18000
G1 Z6.08
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X96.453 Y99.107 E.35826
G1 X97.272 Y99.107 E.01611
G1 X97.254 Y97.202 E.03747
G1 X97.288 Y90.002 E.14163
G1 X97.254 Y82.795 E.14175
G1 X97.272 Y80.893 E.03741
G1 X96.513 Y80.893 E.01493
M204 S10000
G1 X96.861 Y81.3 F18000
; LINE_WIDTH: 0.447885
G1 F1200
M204 S6000
G1 X96.86 Y98.64 E.36517
; WIPE_START
G1 X96.86 Y96.64 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.305 Y99.849 Z6.48 F18000
G1 Z6.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.901 Y99.849 E.00713
; WIPE_START
G1 X97.305 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.973 Y93.565 Z6.48 F18000
G1 X83.957 Y80.483 Z6.48
G1 Z6.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.957 Y99.517 E.40285
G1 X82.315 Y99.517 E.03474
G1 X82.337 Y97.203 E.04897
G1 X82.303 Y90 E.15246
G1 X82.337 Y82.797 E.15247
G1 X82.315 Y80.483 E.04896
G1 X83.897 Y80.483 E.03347
M204 S10000
G1 X84.381 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.381 Y99.941 E.42081
G1 X82.91 Y99.941 E.03113
G1 X82.91 Y100.181 E.00508
G1 X81.885 Y100.181 E.0217
G1 X81.913 Y97.202 E.06306
G1 X81.879 Y90 E.15243
G1 X81.913 Y82.798 E.15244
G1 X81.885 Y79.819 E.06305
G1 X82.913 Y79.819 E.02177
G1 X82.915 Y80.059 E.00508
G1 X84.321 Y80.059 E.02976
M204 S250
G1 X84.79 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.79 Y100.35 E.40715
G1 X83.32 Y100.35 E.02893
G1 X83.32 Y100.59 E.00472
G1 X81.472 Y100.59 E.03634
G1 X81.504 Y97.201 E.06667
G1 X81.47 Y90 E.14163
G1 X81.504 Y82.799 E.14163
G1 X81.472 Y79.41 E.06667
G1 X83.319 Y79.41 E.03634
G1 X83.321 Y79.65 E.00472
G1 X84.73 Y79.65 E.02772
; WIPE_START
M204 S6000
G1 X84.736 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.704 Y80.151 Z6.48 F18000
G1 Z6.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.1 Y80.151 E.00722
; WIPE_START
G1 X82.704 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.043 Y87.776 Z6.48 F18000
G1 X83.548 Y99.107 Z6.48
G1 Z6.08
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F1200
M204 S6000
G1 X83.548 Y80.893 E.35826
G1 X82.729 Y80.893 E.01611
G1 X82.747 Y82.797 E.03746
G1 X82.713 Y90.002 E.14171
G1 X82.747 Y97.205 E.14167
G1 X82.729 Y99.107 E.03742
G1 X83.488 Y99.107 E.01493
M204 S10000
G1 X83.14 Y98.7 F18000
; LINE_WIDTH: 0.447864
G1 F1200
M204 S6000
G1 X83.14 Y81.36 E.36516
; WIPE_START
G1 X83.14 Y83.36 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.936 Y90.99 Z6.48 F18000
G1 X82.698 Y99.849 Z6.48
G1 Z6.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.1 Y99.849 E.00716
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.698 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 51/74
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.48 I.999 J.695 P1  F18000
G1 X96.164 Y80.483 Z6.48
G1 Z6.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.69 Y80.483 E.0323
G1 X97.665 Y82.796 E.04895
G1 X97.701 Y90 E.15247
G1 X97.665 Y97.203 E.15247
M73 P81 R5
G1 X97.688 Y99.517 E.04896
G1 X96.164 Y99.517 E.03227
G1 X96.164 Y80.543 E.40158
M204 S10000
G1 X95.74 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.115 Y80.059 E.02912
G1 X97.116 Y79.819 E.00508
G1 X98.121 Y79.819 E.02128
G1 X98.089 Y82.798 E.06305
G1 X98.125 Y90 E.15244
G1 X98.089 Y97.202 E.15244
G1 X98.119 Y100.181 E.06305
G1 X97.116 Y100.181 E.02124
G1 X97.115 Y99.941 E.00508
G1 X95.74 Y99.941 E.02912
G1 X95.74 Y80.119 E.41954
M204 S250
G1 X95.33 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P82 R5
G1 F1500
M204 S500
G1 X96.707 Y79.65 E.02708
G1 X96.707 Y79.41 E.00472
G1 X98.534 Y79.41 E.03592
G1 X98.533 Y79.607 E.00388
G1 X98.499 Y82.799 E.06279
G1 X98.535 Y90 E.14163
G1 X98.499 Y97.201 E.14164
G1 X98.533 Y100.59 E.06667
G1 X96.707 Y100.59 E.0359
G1 X96.707 Y100.35 E.00472
G1 X95.33 Y100.35 E.02708
G1 X95.33 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.707 Y79.65 E-.26182
G1 X96.707 Y79.41 E-.0456
G1 X97.089 Y79.41 E-.07258
; WIPE_END
G1 E-.02 F1800
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




G1 X97.327 Y80.151
G1 Z6.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.906 Y80.151 E.00692
; WIPE_START
G1 X97.327 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.807 Y87.766 Z6.6 F18000
G1 X96.654 Y90 Z6.6
G1 Z6.2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.57237
G1 F1500
M204 S6000
G1 X96.649 Y99.031 E.2463
G1 X97.198 Y99.031 E.01497
G1 X97.184 Y97.202 E.04988
G1 X97.211 Y89.998 E.19646
G1 X97.184 Y82.798 E.19637
G1 X97.199 Y80.969 E.04987
G1 X96.649 Y80.969 E.01499
G1 X96.654 Y89.94 E.24464
; WIPE_START
G1 X96.653 Y87.94 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.084 Y95.56 Z6.6 F18000
G1 X97.327 Y99.849 Z6.6
G1 Z6.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.904 Y99.849 E.0069
; WIPE_START
G1 X97.327 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.965 Y93.586 Z6.6 F18000
G1 X83.837 Y80.483 Z6.6
G1 Z6.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.837 Y99.517 E.40285
G1 X82.312 Y99.517 E.03227
G1 X82.336 Y97.203 E.04896
G1 X82.299 Y90 E.15246
G1 X82.336 Y82.797 E.15247
G1 X82.312 Y80.483 E.04896
G1 X83.777 Y80.483 E.031
M204 S10000
G1 X84.261 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.261 Y99.941 E.42081
G1 X82.887 Y99.941 E.02908
G1 X82.886 Y100.181 E.00508
G1 X81.881 Y100.181 E.02127
G1 X81.911 Y97.202 E.06305
G1 X81.875 Y90 E.15243
G1 X81.911 Y82.798 E.15244
G1 X81.881 Y79.819 E.06305
G1 X82.887 Y79.819 E.02128
G1 X82.889 Y80.059 E.00508
G1 X84.201 Y80.059 E.02778
M204 S250
G1 X84.67 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.67 Y100.35 E.40715
G1 X83.295 Y100.35 E.02706
G1 X83.294 Y100.59 E.00472
G1 X81.468 Y100.59 E.03591
G1 X81.502 Y97.201 E.06667
G1 X81.466 Y90 E.14163
G1 X81.502 Y82.799 E.14163
G1 X81.468 Y79.41 E.06667
G1 X83.293 Y79.41 E.0359
G1 X83.295 Y79.65 E.00472
G1 X84.61 Y79.65 E.02587
; WIPE_START
M204 S6000
G1 X84.616 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.677 Y80.151 Z6.6 F18000
G1 Z6.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.097 Y80.151 E.00694
; WIPE_START
G1 X82.677 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.195 Y87.766 Z6.6 F18000
G1 X83.346 Y90 Z6.6
G1 Z6.2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.572351
G1 F1500
M204 S6000
G1 X83.352 Y80.969 E.24629
G1 X82.803 Y80.969 E.01497
G1 X82.817 Y82.794 E.04977
G1 X82.79 Y90.002 E.19656
G1 X82.817 Y97.202 E.19635
G1 X82.803 Y99.031 E.04989
G1 X83.352 Y99.031 E.01497
G1 X83.347 Y90.06 E.24464
; WIPE_START
G1 X83.348 Y92.06 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.692 Y99.664 Z6.6 F18000
G1 X82.676 Y99.849 Z6.6
G1 Z6.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.097 Y99.849 E.00693
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.676 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 52/74
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.6 I.996 J.7 P1  F18000
G1 X96.284 Y80.483 Z6.6
G1 Z6.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.695 Y80.483 E.02987
G1 X97.667 Y82.796 E.04895
G1 X97.705 Y90 E.15247
G1 X97.667 Y97.203 E.15247
G1 X97.691 Y99.517 E.04896
G1 X96.284 Y99.517 E.02979
G1 X96.284 Y80.543 E.40158
M204 S10000
G1 X95.86 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.144 Y80.059 E.02719
G1 X97.143 Y79.819 E.00508
G1 X98.127 Y79.819 E.02083
G1 X98.091 Y82.798 E.06305
G1 X98.129 Y90 E.15244
G1 X98.091 Y97.202 E.15244
G1 X98.123 Y100.181 E.06305
G1 X97.143 Y100.181 E.02074
G1 X97.144 Y99.941 E.00508
M73 P83 R5
G1 X95.86 Y99.941 E.02719
G1 X95.86 Y80.119 E.41954
M204 S250
G1 X95.45 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.733 Y79.65 E.02523
G1 X96.732 Y79.41 E.00472
G1 X98.537 Y79.41 E.03552
G1 X98.535 Y79.939 E.01041
G1 X98.5 Y82.799 E.05626
G1 X98.538 Y90 E.14163
G1 X98.5 Y97.201 E.14164
G1 X98.536 Y100.59 E.06667
G1 X96.732 Y100.59 E.0355
G1 X96.733 Y100.35 E.00472
G1 X95.45 Y100.35 E.02522
G1 X95.45 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.733 Y79.65 E-.24394
G1 X96.732 Y79.41 E-.0456
G1 X97.208 Y79.41 E-.09046
; WIPE_END
G1 E-.02 F1800
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




G1 X97.357 Y80.151
G1 Z6.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.911 Y80.151 E.00663
; WIPE_START
G1 X97.357 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.884 Y87.769 Z6.72 F18000
G1 X96.745 Y90 Z6.72
G1 Z6.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.513754
G1 F1500
M204 S6000
G1 X96.74 Y99.06 E.2206
G1 X97.23 Y99.06 E.01194
G1 X97.215 Y97.202 E.04524
G1 X97.244 Y89.998 E.1754
G1 X97.215 Y82.793 E.17543
G1 X97.233 Y80.94 E.04511
G1 X96.74 Y80.94 E.01198
G1 X96.745 Y89.94 E.21911
; WIPE_START
G1 X96.744 Y87.94 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.136 Y95.562 Z6.72 F18000
G1 X97.357 Y99.849 Z6.72
G1 Z6.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.907 Y99.849 E.00658
; WIPE_START
G1 X97.357 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.962 Y93.609 Z6.72 F18000
G1 X83.717 Y80.483 Z6.72
G1 Z6.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.717 Y99.517 E.40285
G1 X82.302 Y99.517 E.02994
G1 X82.334 Y97.209 E.04886
G1 X82.297 Y90 E.15257
G1 X82.334 Y82.791 E.15258
G1 X82.302 Y80.483 E.04886
G1 X83.657 Y80.483 E.02867
M204 S10000
G1 X84.141 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.141 Y99.941 E.42081
G1 X82.863 Y99.941 E.02705
G1 X82.862 Y100.181 E.00508
G1 X81.875 Y100.181 E.0209
G1 X81.91 Y97.205 E.06299
G1 X81.872 Y90 E.1525
G1 X81.91 Y82.795 E.1525
G1 X81.875 Y79.819 E.06299
G1 X82.863 Y79.819 E.02092
G1 X82.865 Y80.059 E.00508
G1 X84.081 Y80.059 E.02574
M204 S250
G1 X84.55 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.55 Y100.35 E.40715
G1 X83.271 Y100.35 E.02516
G1 X83.27 Y100.59 E.00472
G1 X81.464 Y100.59 E.03552
G1 X81.473 Y98.496 E.04119
G1 X81.5 Y97.202 E.02546
G1 X81.463 Y90 E.14165
G1 X81.5 Y82.798 E.14165
G1 X81.473 Y81.504 E.02546
G1 X81.464 Y79.41 E.04119
G1 X83.27 Y79.41 E.03552
G1 X83.271 Y79.65 E.00472
G1 X84.49 Y79.65 E.02397
; WIPE_START
M204 S6000
G1 X84.496 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.653 Y80.151 Z6.72 F18000
G1 Z6.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.089 Y80.151 E.00676
; WIPE_START
G1 X82.653 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.119 Y87.77 Z6.72 F18000
G1 X83.256 Y90 Z6.72
G1 Z6.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.513844
G1 F1500
M204 S6000
G1 X83.26 Y80.941 E.22061
G1 X82.766 Y80.941 E.01202
G1 X82.786 Y82.792 E.04507
G1 X82.758 Y90.001 E.17557
G1 X82.786 Y97.208 E.1755
G1 X82.766 Y99.059 E.04507
G1 X83.26 Y99.059 E.01202
G1 X83.256 Y90.06 E.21914
; WIPE_START
G1 X83.257 Y92.06 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.665 Y99.67 Z6.72 F18000
G1 X82.651 Y99.849 Z6.72
G1 Z6.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.089 Y99.849 E.00674
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.651 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 53/74
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.72 I.992 J.705 P1  F18000
G1 X96.404 Y80.483 Z6.72
G1 Z6.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.702 Y80.483 E.02747
G1 X97.697 Y81.373 E.01884
G1 X97.668 Y82.792 E.03003
G1 X97.708 Y89.91 E.15067
G1 X97.668 Y97.208 E.15447
G1 X97.702 Y99.517 E.04886
G1 X96.404 Y99.517 E.02747
G1 X96.404 Y80.543 E.40158
M204 S10000
G1 X95.98 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.164 Y80.059 E.02507
G1 X97.164 Y79.819 E.00508
G1 X98.13 Y79.819 E.02045
G1 X98.121 Y81.379 E.03302
G1 X98.093 Y82.795 E.02998
G1 X98.132 Y89.91 E.1506
G1 X98.093 Y97.205 E.1544
G1 X98.129 Y100.181 E.06299
G1 X97.164 Y100.181 E.02044
G1 X97.164 Y99.941 E.00508
G1 X95.98 Y99.941 E.02507
G1 X95.98 Y80.119 E.41954
M204 S250
G1 X95.57 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.754 Y79.65 E.02328
M73 P84 R5
G1 X96.753 Y79.41 E.00472
G1 X98.541 Y79.41 E.03516
G1 X98.531 Y81.384 E.03884
G1 X98.502 Y82.798 E.02782
G1 X98.542 Y89.91 E.13989
G1 X98.502 Y97.202 E.14342
G1 X98.531 Y98.616 E.02782
G1 X98.541 Y100.59 E.03884
G1 X96.753 Y100.59 E.03515
G1 X96.754 Y100.35 E.00472
G1 X95.57 Y100.35 E.02328
G1 X95.57 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.754 Y79.65 E-.22517
G1 X96.753 Y79.41 E-.0456
G1 X97.328 Y79.41 E-.10923
; WIPE_END
G1 E-.02 F1800
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




G1 X97.376 Y80.151
G1 Z6.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.916 Y80.151 E.00646
; WIPE_START
G1 X97.376 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.954 Y87.772 Z6.84 F18000
G1 X96.836 Y89.91 Z6.84
G1 Z6.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.455547
G1 F1500
M204 S6000
G1 X96.832 Y99.088 E.1968
G1 X97.267 Y99.088 E.00933
G1 X97.246 Y97.208 E.04032
G1 X97.276 Y89.909 E.15651
G1 X97.246 Y82.791 E.15262
G1 X97.27 Y80.913 E.04027
G1 X96.833 Y80.913 E.00936
G1 X96.836 Y89.85 E.19163
; WIPE_START
G1 X96.835 Y87.85 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.179 Y95.475 Z6.84 F18000
G1 X97.376 Y99.849 Z6.84
G1 Z6.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.915 Y99.849 E.00645
; WIPE_START
G1 X97.376 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.951 Y93.63 Z6.84 F18000
G1 X83.597 Y80.483 Z6.84
G1 Z6.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.597 Y99.517 E.40285
G1 X82.298 Y99.517 E.02748
G1 X82.332 Y97.208 E.04886
G1 X82.294 Y90 E.15257
G1 X82.332 Y82.792 E.15258
G1 X82.298 Y80.483 E.04886
G1 X83.537 Y80.483 E.02621
M204 S10000
G1 X84.021 Y80.059 F18000
G1 F1500
M204 S500
G1 X84.021 Y99.941 E.42081
G1 X82.837 Y99.941 E.02505
G1 X82.837 Y100.181 E.00508
G1 X81.872 Y100.181 E.02044
G1 X81.877 Y98.686 E.03164
G1 X81.908 Y97.205 E.03135
G1 X81.87 Y90 E.1525
G1 X81.908 Y82.795 E.1525
G1 X81.877 Y81.314 E.03135
G1 X81.872 Y79.819 E.03164
G1 X82.838 Y79.819 E.02044
G1 X82.838 Y80.059 E.00508
G1 X83.961 Y80.059 E.02378
M204 S250
G1 X84.43 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.43 Y100.35 E.40715
G1 X83.247 Y100.35 E.02328
G1 X83.247 Y100.59 E.00472
G1 X81.461 Y100.59 E.03512
G1 X81.468 Y98.681 E.03755
G1 X81.499 Y97.202 E.02911
G1 X81.46 Y90 E.14165
G1 X81.499 Y82.798 E.14165
G1 X81.468 Y81.319 E.02911
G1 X81.461 Y79.41 E.03755
G1 X83.246 Y79.41 E.03512
G1 X83.247 Y79.65 E.00472
G1 X84.37 Y79.65 E.0221
; WIPE_START
M204 S6000
G1 X84.376 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.626 Y80.151 Z6.84 F18000
G1 Z6.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.085 Y80.151 E.00647
; WIPE_START
G1 X82.626 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.043 Y87.772 Z6.84 F18000
G1 X83.165 Y90 Z6.84
G1 Z6.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.455048
G1 F1500
M204 S6000
G1 X83.169 Y80.912 E.19465
G1 X82.733 Y80.912 E.00933
G1 X82.754 Y82.792 E.04027
G1 X82.726 Y90.001 E.15442
G1 X82.754 Y97.208 E.15436
G1 X82.733 Y99.088 E.04027
G1 X83.169 Y99.088 E.00933
G1 X83.165 Y90.06 E.19336
; WIPE_START
G1 X83.166 Y92.06 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.637 Y99.674 Z6.84 F18000
G1 X82.625 Y99.849 Z6.84
G1 Z6.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.085 Y99.849 E.00647
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.625 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 54/74
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.84 I.989 J.71 P1  F18000
G1 X96.524 Y80.483 Z6.84
G1 Z6.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.703 Y80.483 E.02495
G1 X97.67 Y82.796 E.04895
G1 X97.708 Y89.129 E.13406
G1 X97.67 Y97.209 E.171
G1 X97.704 Y99.517 E.04886
G1 X96.524 Y99.517 E.02499
G1 X96.524 Y80.543 E.40158
M204 S10000
G1 X96.1 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.185 Y80.059 E.02298
G1 X97.185 Y79.819 E.00508
G1 X98.133 Y79.819 E.02007
G1 X98.133 Y80.068 E.00526
G1 X98.095 Y82.797 E.05779
G1 X98.133 Y89.129 E.13401
G1 X98.094 Y97.205 E.17094
G1 X98.127 Y98.797 E.0337
G1 X98.13 Y100.181 E.02929
G1 X97.184 Y100.181 E.02002
G1 X97.185 Y99.941 E.00508
M73 P84 R4
G1 X96.1 Y99.941 E.02298
G1 X96.1 Y80.119 E.41954
M204 S250
G1 X95.69 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.775 Y79.65 E.02133
M73 P85 R4
G1 X96.774 Y79.41 E.00472
G1 X98.541 Y79.41 E.03477
G1 X98.542 Y80.07 E.01299
G1 X98.504 Y82.799 E.05368
G1 X98.542 Y89.128 E.12449
G1 X98.504 Y97.202 E.1588
G1 X98.536 Y98.792 E.0313
G1 X98.541 Y100.59 E.03536
G1 X96.774 Y100.59 E.03476
G1 X96.775 Y100.35 E.00472
G1 X95.69 Y100.35 E.02133
G1 X95.69 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.775 Y79.65 E-.20634
G1 X96.774 Y79.41 E-.0456
G1 X97.448 Y79.41 E-.12806
; WIPE_END
G1 E-.02 F1800
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




G1 X97.398 Y80.151
G1 Z6.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.919 Y80.151 E.00624
; WIPE_START
G1 X97.398 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.997 Y87.773 Z6.96 F18000
G1 X96.926 Y89.13 Z6.96
G1 Z6.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.395869
G1 F1500
M204 S6000
G1 X96.923 Y99.118 E.18443
G1 X97.299 Y99.118 E.00695
G1 X97.278 Y97.212 E.03518
G1 X97.306 Y89.128 E.14927
G1 X97.278 Y82.796 E.11693
G1 X97.298 Y80.882 E.03534
G1 X96.922 Y80.882 E.00694
G1 X96.926 Y89.07 E.15118
; WIPE_START
G1 X96.925 Y87.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.207 Y94.697 Z6.96 F18000
G1 X97.398 Y99.849 Z6.96
G1 Z6.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.917 Y99.849 E.00622
; WIPE_START
G1 X97.398 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.943 Y93.651 Z6.96 F18000
G1 X83.477 Y80.483 Z6.96
G1 Z6.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.477 Y99.517 E.40285
G1 X82.294 Y99.517 E.02503
G1 X82.33 Y97.208 E.04886
G1 X82.291 Y90.302 E.14618
G1 X82.33 Y82.791 E.15897
G1 X82.294 Y80.483 E.04886
G1 X83.417 Y80.483 E.02376
M204 S10000
G1 X83.901 Y80.059 F18000
G1 F1500
M204 S500
G1 X83.901 Y99.941 E.42081
G1 X82.821 Y99.941 E.02285
G1 X82.82 Y100.181 E.00508
G1 X81.869 Y100.181 E.02015
G1 X81.871 Y98.871 E.02773
G1 X81.906 Y97.205 E.03527
G1 X81.867 Y90.302 E.1461
G1 X81.906 Y82.795 E.1589
G1 X81.871 Y81.129 E.03526
G1 X81.869 Y79.819 E.02773
G1 X82.822 Y79.819 E.02018
G1 X82.824 Y80.059 E.00508
G1 X83.841 Y80.059 E.02153
M204 S250
G1 X84.31 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.31 Y100.35 E.40715
G1 X83.229 Y100.35 E.02127
G1 X83.228 Y100.59 E.00472
G1 X81.459 Y100.59 E.03481
G1 X81.462 Y98.866 E.0339
G1 X81.497 Y97.202 E.03275
G1 X81.458 Y90.302 E.1357
G1 X81.497 Y82.798 E.1476
G1 X81.462 Y81.134 E.03275
G1 X81.459 Y79.41 E.0339
G1 X83.228 Y79.41 E.0348
G1 X83.23 Y79.65 E.00472
G1 X84.25 Y79.65 E.02007
; WIPE_START
M204 S6000
G1 X84.256 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.612 Y80.151 Z6.96 F18000
G1 Z6.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.081 Y80.151 E.00635
; WIPE_START
G1 X82.612 Y80.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.959 Y87.776 Z6.96 F18000
G1 X83.074 Y90.302 Z6.96
G1 Z6.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.396174
G1 F1500
M204 S6000
G1 X83.077 Y80.883 E.17407
G1 X82.7 Y80.883 E.00698
G1 X82.723 Y82.791 E.03527
G1 X82.694 Y90.303 E.13882
G1 X82.723 Y97.208 E.12761
G1 X82.7 Y99.117 E.03528
G1 X83.077 Y99.117 E.00698
G1 X83.075 Y90.362 E.1618
; WIPE_START
G1 X83.075 Y92.362 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.61 Y99.849 Z6.96 F18000
G1 Z6.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.082 Y99.849 E.00632
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.61 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 55/74
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.96 I.985 J.714 P1  F18000
G1 X96.644 Y80.483 Z6.96
G1 Z6.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.708 Y80.483 E.02253
G1 X97.709 Y80.844 E.00764
G1 X97.672 Y82.794 E.04127
G1 X97.709 Y88.35 E.11762
G1 X97.709 Y91.649 E.06983
G1 X97.672 Y97.208 E.11765
G1 X97.708 Y99.517 E.04888
G1 X96.644 Y99.517 E.02252
G1 X96.644 Y80.543 E.40158
M204 S10000
G1 X96.22 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.206 Y80.059 E.02087
G1 X97.204 Y79.819 E.00508
G1 X98.132 Y79.819 E.01965
G1 X98.133 Y80.848 E.02177
G1 X98.096 Y82.796 E.04124
G1 X98.133 Y88.349 E.11752
G1 X98.133 Y91.651 E.0699
G1 X98.096 Y97.205 E.11754
G1 X98.132 Y98.973 E.03745
G1 X98.132 Y100.181 E.02556
G1 X97.204 Y100.181 E.01964
G1 X97.206 Y99.941 E.00508
G1 X96.22 Y99.941 E.02087
G1 X96.22 Y80.119 E.41954
M204 S250
G1 X95.81 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.793 Y79.65 E.01933
G1 X96.791 Y79.41 E.00472
G1 X98.541 Y79.41 E.03442
G1 X98.542 Y80.852 E.02836
G1 X98.505 Y82.799 E.0383
G1 X98.542 Y88.347 E.10913
G1 X98.542 Y91.653 E.06502
G1 X98.505 Y97.201 E.10914
G1 X98.541 Y98.969 E.03478
G1 X98.541 Y100.59 E.03188
G1 X96.791 Y100.59 E.03442
G1 X96.793 Y100.35 E.00472
G1 X95.81 Y100.35 E.01933
G1 X95.81 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.793 Y79.65 E-.18709
G1 X96.791 Y79.41 E-.0456
G1 X97.567 Y79.41 E-.14731
; WIPE_END
M73 P86 R4
G1 E-.02 F1800
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




G1 X97.419 Y80.151
G1 Z6.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.92 Y80.151 E.006
M204 S10000
G1 X97.178 Y80.696 F18000
; LINE_WIDTH: 0.650687
G1 F1500
M204 S6000
G1 X97.158 Y82.794 E.06542
G1 X97.176 Y91.647 E.27602
G1 X97.158 Y97.207 E.17337
G1 X97.176 Y99.304 E.06538
M204 S10000
G1 X97.419 Y99.849 F18000
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.92 Y99.849 E.006
; WIPE_START
G1 X97.419 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.934 Y93.673 Z7.08 F18000
G1 X83.357 Y80.483 Z7.08
G1 Z6.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.357 Y99.517 E.40285
G1 X82.292 Y99.517 E.02253
G1 X82.329 Y97.208 E.04888
G1 X82.292 Y91.795 E.11456
G1 X82.292 Y87.978 E.0808
G1 X82.329 Y82.793 E.10975
G1 X82.292 Y80.483 E.04888
G1 X83.297 Y80.483 E.02126
M204 S10000
G1 X83.781 Y80.059 F18000
G1 F1500
M204 S500
G1 X83.781 Y99.941 E.42081
G1 X82.805 Y99.941 E.02067
G1 X82.803 Y100.181 E.00508
G1 X81.869 Y100.181 E.01978
G1 X81.868 Y99.007 E.02485
G1 X81.904 Y97.204 E.03815
G1 X81.868 Y91.797 E.11446
G1 X81.868 Y87.976 E.08088
G1 X81.904 Y82.796 E.10964
G1 X81.868 Y80.993 E.03815
G1 X81.869 Y79.819 E.02485
G1 X82.804 Y79.819 E.01979
G1 X82.806 Y80.059 E.00508
G1 X83.721 Y80.059 E.01938
M204 S250
G1 X84.19 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.19 Y100.35 E.40715
G1 X83.211 Y100.35 E.01925
G1 X83.21 Y100.59 E.00472
G1 X81.46 Y100.59 E.03443
G1 X81.458 Y99.003 E.03122
G1 X81.495 Y97.201 E.03543
G1 X81.458 Y91.799 E.10627
G1 X81.459 Y87.974 E.07523
G1 X81.495 Y82.799 E.10179
G1 X81.458 Y80.998 E.03543
G1 X81.46 Y79.41 E.03122
G1 X83.21 Y79.41 E.03443
G1 X83.212 Y79.65 E.00472
G1 X84.13 Y79.65 E.01807
; WIPE_START
M204 S6000
G1 X84.136 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.594 Y80.151 Z7.08 F18000
G1 Z6.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.08 Y80.151 E.00615
M204 S10000
G1 X82.825 Y80.696 F18000
; LINE_WIDTH: 0.651102
G1 F1500
M204 S6000
G1 X82.843 Y82.793 E.06544
G1 X82.824 Y91.793 E.28078
G1 X82.843 Y97.207 E.16893
G1 X82.825 Y99.304 E.06543
M204 S10000
G1 X82.593 Y99.849 F18000
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.08 Y99.849 E.00613
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.593 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 56/74
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.08 I.982 J.719 P1  F18000
G1 X96.764 Y80.483 Z7.08
G1 Z6.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.706 Y80.483 E.01993
G1 X97.705 Y81.265 E.01655
G1 X97.674 Y82.791 E.03231
G1 X97.707 Y89.827 E.14892
G1 X97.707 Y92.694 E.06067
G1 X97.674 Y97.207 E.09554
G1 X97.705 Y99.517 E.04888
G1 X96.764 Y99.517 E.01993
G1 X96.764 Y80.543 E.40158
M204 S10000
G1 X96.34 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.224 Y80.059 E.01872
G1 X97.222 Y79.819 E.00508
G1 X98.131 Y79.819 E.01924
G1 X98.129 Y81.27 E.03071
G1 X98.098 Y82.795 E.03228
G1 X98.131 Y89.828 E.14886
G1 X98.131 Y92.696 E.06071
G1 X98.098 Y97.204 E.09542
G1 X98.129 Y98.73 E.03229
G1 X98.13 Y100.181 E.03071
G1 X97.222 Y100.181 E.01923
G1 X97.224 Y99.941 E.00508
G1 X96.34 Y99.941 E.01872
G1 X96.34 Y80.119 E.41954
M204 S250
G1 X95.93 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.811 Y79.65 E.01732
G1 X96.808 Y79.41 E.00472
G1 X98.54 Y79.41 E.03407
G1 X98.538 Y81.274 E.03667
G1 X98.507 Y82.798 E.02998
G1 X98.541 Y89.828 E.13827
G1 X98.54 Y92.698 E.05645
G1 X98.507 Y97.201 E.08858
G1 X98.538 Y98.725 E.02998
G1 X98.54 Y100.59 E.03667
G1 X96.808 Y100.59 E.03406
G1 X96.811 Y100.35 E.00472
G1 X95.93 Y100.35 E.01732
G1 X95.93 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.811 Y79.65 E-.16767
G1 X96.808 Y79.41 E-.0456
G1 X97.686 Y79.41 E-.16673
; WIPE_END
G1 E-.02 F1800
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




G1 X97.918 Y80.151
G1 Z6.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.437 Y80.151 E.00576
M204 S10000
G1 X97.235 Y80.696 F18000
; LINE_WIDTH: 0.530565
G1 F1500
M204 S6000
G1 X97.219 Y82.791 E.05277
G1 X97.235 Y89.828 E.17723
G1 X97.219 Y97.207 E.18585
G1 X97.234 Y99.304 E.05282
M204 S10000
G1 X97.437 Y99.849 F18000
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.918 Y99.849 E.00575
; WIPE_START
G1 X97.437 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.924 Y93.694 Z7.2 F18000
G1 X83.237 Y80.483 Z7.2
G1 Z6.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.237 Y99.517 E.40285
G1 X82.294 Y99.517 E.01995
G1 X82.327 Y97.207 E.0489
G1 X82.294 Y91.964 E.11097
G1 X82.294 Y87.109 E.10275
G1 X82.327 Y82.794 E.09134
G1 X82.294 Y80.483 E.04891
G1 X83.177 Y80.483 E.01868
M204 S10000
G1 X83.661 Y80.059 F18000
G1 F1500
M204 S500
M73 P87 R4
G1 X83.661 Y99.941 E.42081
G1 X82.78 Y99.941 E.01865
G1 X82.781 Y100.181 E.00508
G1 X81.87 Y100.181 E.01927
G1 X81.87 Y98.973 E.02556
G1 X81.903 Y97.204 E.03746
G1 X81.869 Y91.965 E.11089
G1 X81.87 Y87.108 E.1028
G1 X81.903 Y82.796 E.09126
G1 X81.87 Y81.027 E.03746
G1 X81.87 Y79.819 E.02556
G1 X82.781 Y79.819 E.01927
G1 X82.78 Y80.059 E.00508
G1 X83.601 Y80.059 E.01738
M204 S250
G1 X84.07 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.07 Y100.35 E.40715
G1 X83.191 Y100.35 E.0173
G1 X83.192 Y100.59 E.00472
G1 X81.461 Y100.59 E.03404
G1 X81.46 Y98.969 E.03188
G1 X81.493 Y97.201 E.03478
G1 X81.46 Y91.966 E.10297
G1 X81.461 Y87.107 E.09558
G1 X81.493 Y82.799 E.08474
G1 X81.46 Y81.031 E.03478
G1 X81.461 Y79.41 E.03188
G1 X83.192 Y79.41 E.03404
G1 X83.191 Y79.65 E.00472
G1 X84.01 Y79.65 E.01612
; WIPE_START
M204 S6000
G1 X84.016 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.567 Y80.151 Z7.2 F18000
G1 Z6.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.082 Y80.151 E.0058
M204 S10000
G1 X82.765 Y80.696 F18000
; LINE_WIDTH: 0.531737
G1 F1500
M204 S6000
G1 X82.782 Y82.794 E.05298
G1 X82.765 Y91.961 E.23141
G1 X82.782 Y97.207 E.13241
G1 X82.765 Y99.304 E.05296
M204 S10000
G1 X82.567 Y99.849 F18000
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.082 Y99.849 E.0058
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.567 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 57/74
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.2 I.979 J.723 P1  F18000
G1 X96.884 Y80.483 Z7.2
G1 Z6.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.703 Y80.483 E.01735
G1 X97.703 Y80.734 E.00531
G1 X97.675 Y82.796 E.04365
G1 X97.703 Y86.223 E.07252
G1 X97.703 Y93.778 E.15991
G1 X97.675 Y97.205 E.07255
G1 X97.703 Y99.517 E.04893
G1 X96.884 Y99.517 E.01734
G1 X96.884 Y80.543 E.40158
M204 S10000
G1 X96.46 Y80.059 F18000
G1 F1500
M204 S500
G1 X97.22 Y80.059 E.01609
G1 X97.223 Y79.819 E.00508
G1 X98.127 Y79.819 E.01913
G1 X98.128 Y80.737 E.01943
G1 X98.1 Y82.798 E.04363
G1 X98.128 Y86.221 E.07245
G1 X98.128 Y93.779 E.15997
G1 X98.1 Y97.203 E.07247
G1 X98.127 Y98.857 E.03501
G1 X98.127 Y100.181 E.02803
G1 X97.223 Y100.181 E.01913
G1 X97.22 Y99.941 E.00508
G1 X96.46 Y99.941 E.01609
G1 X96.46 Y80.119 E.41954
M204 S250
G1 X96.05 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.816 Y79.65 E.01507
G1 X96.82 Y79.41 E.00472
G1 X98.536 Y79.41 E.03376
G1 X98.537 Y80.74 E.02615
G1 X98.509 Y82.799 E.04052
G1 X98.537 Y86.22 E.06727
G1 X98.537 Y93.78 E.14872
G1 X98.509 Y97.201 E.06728
G1 X98.537 Y98.853 E.0325
G1 X98.536 Y100.59 E.03417
G1 X96.82 Y100.59 E.03376
G1 X96.816 Y100.35 E.00472
G1 X96.05 Y100.35 E.01507
G1 X96.05 Y79.71 E.40597
; WIPE_START
M204 S6000
G1 X96.816 Y79.65 E-.14598
G1 X96.82 Y79.41 E-.0456
G1 X97.811 Y79.41 E-.18841
; WIPE_END
G1 E-.02 F1800
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




G1 X97.915 Y80.151
G1 Z6.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.431 Y80.151 E.0058
M204 S10000
G1 X97.294 Y80.696 F18000
; LINE_WIDTH: 0.412531
G1 F1500
M204 S6000
G1 X97.28 Y82.794 E.04049
G1 X97.293 Y99.304 E.3186
M204 S10000
G1 X97.431 Y99.849 F18000
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X97.915 Y99.849 E.0058
; WIPE_START
G1 X97.431 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.894 Y93.711 Z7.32 F18000
G1 X83.117 Y80.483 Z7.32
G1 Z6.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X83.117 Y99.517 E.40285
G1 X82.298 Y99.517 E.01732
G1 X82.325 Y97.206 E.04891
G1 X82.297 Y93.777 E.07256
G1 X82.297 Y90.15 E.07679
G1 X82.297 Y86.223 E.08312
G1 X82.325 Y82.794 E.07256
G1 X82.298 Y80.483 E.04891
G1 X83.057 Y80.483 E.01605
M204 S10000
G1 X83.541 Y80.059 F18000
G1 F1500
M204 S500
G1 X83.541 Y99.941 E.42081
G1 X82.794 Y99.941 E.01581
G1 X82.787 Y100.181 E.00508
G1 X81.873 Y100.181 E.01934
G1 X81.875 Y98.58 E.03389
G1 X81.901 Y97.203 E.02913
G1 X81.873 Y93.779 E.07248
G1 X81.873 Y90.15 E.07682
G1 X81.873 Y86.221 E.08315
G1 X81.901 Y82.797 E.07248
G1 X81.875 Y81.42 E.02913
G1 X81.873 Y79.819 E.03389
G1 X82.791 Y79.819 E.01942
G1 X82.8 Y80.059 E.00508
G1 X83.481 Y80.059 E.01441
M204 S250
G1 X83.95 Y79.65 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P87 R3
G1 F1500
M204 S500
G1 X83.95 Y100.35 E.40715
G1 X83.191 Y100.35 E.01493
G1 X83.184 Y100.59 E.00472
G1 X81.464 Y100.59 E.03384
G1 X81.466 Y98.575 E.03963
G1 X81.492 Y97.201 E.02703
G1 X81.464 Y93.78 E.06728
G1 X81.463 Y90.15 E.07142
G1 X81.464 Y86.22 E.0773
G1 X81.492 Y82.799 E.06728
G1 X81.466 Y81.425 E.02703
G1 X81.464 Y79.41 E.03963
G1 X83.184 Y79.41 E.03383
M73 P88 R3
G1 X83.193 Y79.65 E.00472
G1 X83.89 Y79.65 E.01371
; WIPE_START
M204 S6000
G1 X83.896 Y81.65 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.592 Y80.151 Z7.32 F18000
G1 Z6.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.086 Y80.151 E.00606
M204 S10000
G1 X82.708 Y80.696 F18000
; LINE_WIDTH: 0.412469
G1 F1500
M204 S6000
G1 X82.721 Y97.209 E.31861
G1 X82.708 Y99.304 E.04042
M204 S10000
G1 X82.585 Y99.849 F18000
; LINE_WIDTH: 0.265652
G1 F1500
M204 S6000
G1 X82.086 Y99.849 E.00597
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.585 Y99.849 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 58/74
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.32 I1.215 J.069 P1  F18000
G1 X83.724 Y79.65 Z7.32
G1 Z7.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.83 Y79.65 E.00208
G1 X83.83 Y100.35 E.40715
G1 X83.724 Y100.35 E.00208
G1 X83.724 Y79.71 E.40597
M204 S10000
G1 X82.757 Y79.819 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.756 Y100.181 E.43097
G1 X81.878 Y100.181 E.01857
G1 X81.899 Y97.203 E.06304
G1 X81.879 Y94.761 E.05169
G1 X81.879 Y85.239 E.20153
G1 X81.899 Y82.797 E.05169
G1 X81.878 Y79.819 E.06303
G1 X82.697 Y79.819 E.01734
M204 S250
G1 X83.167 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.165 Y100.59 E.41659
G1 X81.469 Y100.59 E.03336
G1 X81.47 Y98.516 E.0408
G1 X81.49 Y97.201 E.02587
G1 X81.47 Y94.762 E.04797
G1 X81.47 Y85.238 E.18733
G1 X81.49 Y82.799 E.04797
G1 X81.47 Y81.484 E.02587
G1 X81.469 Y79.41 E.0408
G1 X83.107 Y79.41 E.03221
; WIPE_START
M204 S6000
G1 X83.112 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.318 Y80.031
G1 Z7.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.473421
G1 F1500
M204 S6000
G1 X82.317 Y99.969 E.44529
; WIPE_START
G1 X82.317 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.921 Y91.881 Z7.44 F18000
G1 X96.17 Y79.654 Z7.44
G1 Z7.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X96.275 Y79.656 E.00206
G1 X96.276 Y100.35 E.40704
G1 X96.17 Y100.35 E.00208
G1 X96.17 Y79.714 E.4059
; WIPE_START
M204 S6000
G1 X96.275 Y79.656 E-.02275
G1 X96.275 Y81.536 E-.35725
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.244 Y79.819 Z7.44 F18000
G1 Z7.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.123 Y79.819 E.01861
G1 X98.101 Y82.8 E.0631
G1 X98.121 Y85.239 E.05163
G1 X98.121 Y94.761 E.20153
G1 X98.101 Y97.203 E.05169
G1 X98.122 Y100.181 E.06303
G1 X97.244 Y100.181 E.01858
G1 X97.244 Y79.879 E.4297
M204 S250
G1 X96.835 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.532 Y79.41 E.03337
G1 X98.532 Y79.919 E.01001
G1 X98.511 Y82.8 E.05667
G1 X98.531 Y85.238 E.04795
G1 X98.531 Y94.762 E.18733
G1 X98.511 Y97.201 E.04797
G1 X98.53 Y98.379 E.02317
G1 X98.531 Y100.59 E.04349
G1 X96.835 Y100.59 E.03337
G1 X96.835 Y79.47 E.41541
; WIPE_START
M204 S6000
G1 X98.532 Y79.41 E-.32258
G1 X98.532 Y79.712 E-.05742
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.683 Y80.031 Z7.44 F18000
G1 Z7.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.473387
G1 F1500
M204 S6000
G1 X97.683 Y99.969 E.44525
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.683 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 59/74
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.44 I.94 J-.773 P1  F18000
G1 X82.745 Y79.819 Z7.44
G1 Z7.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.744 Y100.181 E.43097
G1 X81.885 Y100.181 E.01818
G1 X81.898 Y93.599 E.1393
G1 X81.883 Y91.798 E.03812
G1 X81.898 Y86.4 E.11427
G1 X81.885 Y79.819 E.13928
G1 X82.685 Y79.819 E.01693
M204 S250
G1 X83.154 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.153 Y100.59 E.41659
G1 X81.475 Y100.59 E.03301
G1 X81.488 Y93.6 E.13749
G1 X81.474 Y91.799 E.03542
G1 X81.488 Y86.4 E.1062
G1 X81.475 Y79.41 E.13748
G1 X83.094 Y79.41 E.03185
; WIPE_START
M204 S6000
G1 X83.099 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.315 Y80.031
G1 Z7.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.454495
G1 F1500
M204 S6000
G1 X82.315 Y99.969 E.42646
; WIPE_START
G1 X82.315 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.162 Y92.074 Z7.56 F18000
G1 X97.24 Y79.819 Z7.56
G1 Z7.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.116 Y79.819 E.01855
G1 X98.103 Y86.401 E.1393
G1 X98.117 Y88.202 E.03812
G1 X98.103 Y93.601 E.11427
G1 X98.116 Y100.181 E.13928
G1 X97.241 Y100.181 E.01853
G1 X97.256 Y93.016 E.15164
G1 X97.24 Y79.879 E.27806
M204 S250
G1 X96.83 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.526 Y79.41 E.03336
G1 X98.512 Y86.4 E.13749
G1 X98.527 Y88.201 E.03542
G1 X98.512 Y93.6 E.1062
G1 X98.526 Y100.59 E.13748
G1 X96.83 Y100.59 E.03335
G1 X96.846 Y93.016 E.14897
G1 X96.83 Y79.47 E.26644
; WIPE_START
M204 S6000
G1 X98.526 Y79.41 E-.32244
G1 X98.526 Y79.713 E-.05756
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.678 Y80.031 Z7.56 F18000
M73 P89 R3
G1 Z7.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.462766
G1 F1500
M204 S6000
G1 X97.678 Y99.969 E.43469
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.678 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 60/74
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.56 I1.217 J-.029 P1  F18000
G1 X97.248 Y79.819 Z7.56
G1 Z7.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.109 Y79.819 E.01823
G1 X98.11 Y80.458 E.01351
G1 X98.091 Y86.402 E.12582
G1 X98.11 Y88.203 E.03812
G1 X98.11 Y91.797 E.07606
G1 X98.091 Y93.597 E.03812
G1 X98.107 Y100.181 E.13934
G1 X97.248 Y100.181 E.01819
G1 X97.268 Y90.491 E.20508
G1 X97.248 Y79.879 E.22461
M204 S250
G1 X96.838 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.518 Y79.41 E.03305
G1 X98.519 Y80.459 E.02064
G1 X98.5 Y86.4 E.11686
G1 X98.519 Y88.201 E.03542
G1 X98.519 Y91.799 E.07076
G1 X98.5 Y93.6 E.03542
G1 X98.517 Y100.59 E.1375
G1 X96.838 Y100.59 E.03304
G1 X96.859 Y90.492 E.19863
G1 X96.838 Y79.47 E.21678
; WIPE_START
M204 S6000
G1 X98.518 Y79.41 E-.31943
G1 X98.518 Y79.729 E-.06057
; WIPE_END
G1 E-.02 F1800
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




G1 X97.679 Y80.031
G1 Z7.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.444897
G1 F1500
M204 S6000
G1 X97.677 Y99.969 E.41691
; WIPE_START
G1 X97.677 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.828 Y92.075 Z7.68 F18000
G1 X82.746 Y79.821 Z7.68
G1 Z7.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.733 Y91.015 E.23692
G1 X82.746 Y100.181 E.19401
G1 X81.893 Y100.181 E.01806
G1 X81.91 Y93.597 E.13934
G1 X81.891 Y91.797 E.03811
G1 X81.891 Y88.203 E.07606
G1 X81.91 Y86.402 E.03812
G1 X81.893 Y79.82 E.13932
G1 X82.686 Y79.821 E.01678
M204 S250
G1 X83.156 Y79.412 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.142 Y91.014 E.2282
G1 X83.156 Y100.59 E.18835
G1 X81.483 Y100.59 E.0329
G1 X81.5 Y93.6 E.1375
G1 X81.482 Y91.799 E.03542
G1 X81.482 Y88.201 E.07076
G1 X81.5 Y86.4 E.03542
G1 X81.483 Y79.41 E.13749
G1 X83.096 Y79.412 E.03172
M204 S10000
G1 X82.32 Y80.033 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.441333
G1 F1500
M204 S6000
G1 X82.32 Y99.969 E.41334
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.32 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 61/74
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.68 I1.217 J.028 P1  F18000
G1 X82.737 Y79.819 Z7.68
G1 Z7.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.724 Y90 E.21549
G1 X82.737 Y100.181 E.21548
G1 X81.902 Y100.181 E.01766
G1 X81.921 Y93.6 E.1393
G1 X81.9 Y90.878 E.0576
G1 X81.921 Y86.4 E.09479
G1 X81.902 Y79.819 E.13928
G1 X82.677 Y79.819 E.01639
M204 S250
G1 X83.146 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.133 Y90 E.2083
G1 X83.146 Y100.59 E.20829
G1 X81.492 Y100.59 E.03255
G1 X81.512 Y93.6 E.13749
G1 X81.491 Y90.879 E.05352
G1 X81.512 Y86.4 E.0881
G1 X81.492 Y79.41 E.13748
G1 X83.086 Y79.41 E.03137
; WIPE_START
M204 S6000
G1 X83.095 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.32 Y80.031
G1 Z7.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.419798
M73 P90 R3
G1 F1500
M204 S6000
G1 X82.32 Y99.969 E.39195
; WIPE_START
G1 X82.32 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.169 Y92.075 Z7.8 F18000
G1 X97.255 Y79.819 Z7.8
G1 Z7.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.1 Y79.819 E.01789
G1 X98.101 Y80.241 E.00892
G1 X98.079 Y86.401 E.13039
G1 X98.101 Y88.959 E.05414
G1 X98.079 Y93.6 E.09825
G1 X98.098 Y100.181 E.13928
G1 X97.255 Y100.181 E.01784
G1 X97.277 Y90 E.21549
G1 X97.255 Y79.879 E.21421
M204 S250
G1 X96.845 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.509 Y79.41 E.03273
G1 X98.51 Y80.242 E.01637
G1 X98.489 Y86.4 E.12112
G1 X98.51 Y88.958 E.0503
G1 X98.489 Y93.6 E.09132
G1 X98.508 Y100.59 E.13748
G1 X96.845 Y100.59 E.03272
G1 X96.868 Y90 E.2083
G1 X96.845 Y79.47 E.20711
; WIPE_START
M204 S6000
G1 X98.509 Y79.41 E-.31639
G1 X98.509 Y79.745 E-.06361
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.888 Y80.033 Z7.8 F18000
G1 Z7.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.424801
G1 F1500
M204 S6000
G1 X97.678 Y80.242 E.0059
G1 X97.676 Y99.969 E.39274
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.677 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 62/74
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.8 I.939 J-.774 P1  F18000
G1 X82.728 Y79.819 Z7.8
G1 Z7.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.728 Y100.181 E.43097
G1 X81.913 Y100.181 E.01725
G1 X81.933 Y93.6 E.13929
G1 X81.911 Y90 E.0762
G1 X81.933 Y86.4 E.0762
G1 X81.913 Y79.819 E.13929
G1 X82.668 Y79.819 E.01598
M204 S250
G1 X83.137 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.137 Y100.59 E.41659
G1 X81.502 Y100.59 E.03216
G1 X81.524 Y93.6 E.13749
G1 X81.502 Y90 E.07081
G1 X81.524 Y86.4 E.07081
G1 X81.502 Y79.41 E.13749
G1 X83.077 Y79.41 E.03098
; WIPE_START
M204 S6000
G1 X83.083 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.321 Y80.031
G1 Z7.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.406586
G1 F1500
M204 S6000
G1 X82.321 Y99.969 E.37881
; WIPE_START
G1 X82.321 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.172 Y92.076 Z7.92 F18000
G1 X97.262 Y79.819 Z7.92
G1 Z7.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.087 Y79.819 E.01746
G1 X98.067 Y86.4 E.13929
G1 X98.09 Y90 E.0762
G1 X98.067 Y93.6 E.0762
G1 X98.088 Y100.181 E.13929
G1 X97.262 Y100.181 E.01747
G1 X97.284 Y90 E.21549
G1 X97.262 Y79.879 E.21421
M204 S250
G1 X96.852 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.498 Y79.41 E.03237
G1 X98.477 Y86.4 E.13749
G1 X98.499 Y90 E.07081
G1 X98.477 Y93.6 E.07081
G1 X98.498 Y100.59 E.13749
G1 X96.852 Y100.59 E.03238
G1 X96.875 Y90 E.2083
G1 X96.852 Y79.47 E.20711
M204 S10000
G1 X97.675 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.405248
G1 F1500
M204 S6000
G1 X97.687 Y89.999 E.18872
G1 X97.675 Y99.969 E.18875
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.677 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 63/74
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.92 I.939 J-.774 P1  F18000
G1 X82.719 Y79.819 Z7.92
G1 Z7.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.719 Y100.181 E.43097
G1 X81.925 Y100.181 E.0168
G1 X81.945 Y93.6 E.13929
G1 X81.924 Y90 E.0762
G1 X81.945 Y86.4 E.0762
G1 X81.925 Y79.819 E.13929
G1 X82.659 Y79.819 E.01553
M204 S250
G1 X83.128 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.128 Y100.59 E.41659
M73 P90 R2
G1 X81.515 Y100.59 E.03174
G1 X81.536 Y93.6 E.13749
G1 X81.514 Y90 E.07081
G1 X81.536 Y86.4 E.07081
G1 X81.515 Y79.41 E.13749
M73 P91 R2
G1 X83.068 Y79.41 E.03056
; WIPE_START
M204 S6000
G1 X83.074 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.323 Y80.031
G1 Z7.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.385418
G1 F1500
M204 S6000
G1 X82.323 Y99.969 E.35775
; WIPE_START
G1 X82.323 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.175 Y92.077 Z8.04 F18000
G1 X97.27 Y79.819 Z8.04
G1 Z7.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.072 Y79.819 E.01698
G1 X98.056 Y86.4 E.13929
G1 X98.076 Y90 E.07619
G1 X98.056 Y93.6 E.0762
G1 X98.075 Y100.181 E.13929
G1 X97.27 Y100.181 E.01704
G1 X97.292 Y90 E.21549
G1 X97.27 Y79.879 E.21421
M204 S250
G1 X96.859 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.482 Y79.41 E.03192
G1 X98.465 Y86.4 E.13749
G1 X98.486 Y90 E.07081
G1 X98.465 Y93.6 E.07081
G1 X98.485 Y100.59 E.13749
G1 X96.859 Y100.59 E.03197
G1 X96.883 Y90 E.2083
G1 X96.86 Y79.47 E.20711
M204 S10000
G1 X97.671 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.385024
G1 F1500
M204 S6000
G1 X97.684 Y89.999 E.17866
G1 X97.672 Y99.969 E.17869
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.674 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 64/74
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.04 I.939 J-.774 P1  F18000
G1 X82.71 Y79.819 Z8.04
G1 Z7.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.71 Y100.181 E.43097
G1 X81.939 Y100.181 E.01632
G1 X81.957 Y93.6 E.13929
G1 X81.937 Y90 E.07619
G1 X81.957 Y86.4 E.07621
G1 X81.939 Y79.819 E.13929
G1 X82.65 Y79.819 E.01505
M204 S250
G1 X83.119 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.119 Y100.59 E.41659
G1 X81.529 Y100.59 E.03129
G1 X81.548 Y93.6 E.13749
G1 X81.528 Y90 E.07081
G1 X81.548 Y86.4 E.07082
G1 X81.529 Y79.41 E.13749
G1 X83.059 Y79.41 E.03011
; WIPE_START
M204 S6000
G1 X83.065 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.325 Y80.031
G1 Z7.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.363602
G1 F1500
M204 S6000
G1 X82.325 Y99.969 E.33605
; WIPE_START
G1 X82.325 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.178 Y92.078 Z8.16 F18000
G1 X97.277 Y79.819 Z8.16
G1 Z7.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.057 Y79.819 E.0165
G1 X98.044 Y86.401 E.13931
G1 X98.063 Y90 E.07617
G1 X98.044 Y93.6 E.0762
G1 X98.061 Y100.181 E.13929
G1 X97.277 Y100.181 E.01661
G1 X97.3 Y90 E.21549
G1 X97.277 Y79.879 E.21421
M204 S250
G1 X96.867 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.469 Y79.41 E.03151
G1 X98.466 Y79.573 E.00321
G1 X98.453 Y86.4 E.13428
G1 X98.472 Y90 E.07081
G1 X98.453 Y93.6 E.07081
G1 X98.472 Y100.59 E.13749
G1 X96.867 Y100.59 E.03157
G1 X96.89 Y90 E.2083
G1 X96.867 Y79.47 E.20711
M204 S10000
G1 X97.667 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.364762
G1 F1500
M204 S6000
G1 X97.681 Y89.999 E.16859
G1 X97.669 Y99.969 E.16862
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.671 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 65/74
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.16 I.939 J-.774 P1  F18000
G1 X82.701 Y79.819 Z8.16
G1 Z7.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.701 Y100.181 E.43097
G1 X81.955 Y100.181 E.01579
G1 X81.969 Y93.601 E.13928
M73 P92 R2
G1 X81.954 Y79.819 E.29169
G1 X82.641 Y79.819 E.01454
M204 S250
G1 X83.11 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.11 Y100.59 E.41659
G1 X81.545 Y100.59 E.03079
G1 X81.559 Y93.601 E.13748
G1 X81.545 Y79.41 E.27912
G1 X83.05 Y79.41 E.02961
; WIPE_START
M204 S6000
G1 X83.056 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.328 Y80.031
G1 Z7.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.340684
G1 F1500
M204 S6000
G1 X82.328 Y99.969 E.31326
; WIPE_START
G1 X82.328 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.182 Y92.078 Z8.28 F18000
G1 X97.283 Y79.819 Z8.28
G1 Z7.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.046 Y79.819 E.01616
G1 X98.032 Y93.601 E.2917
G1 X98.046 Y100.181 E.13927
G1 X97.283 Y100.181 E.01614
G1 X97.283 Y94.917 E.1114
G1 X97.307 Y90 E.10409
G1 X97.283 Y85.083 E.10407
G1 X97.283 Y79.879 E.11014
M204 S250
G1 X96.874 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.456 Y79.41 E.03112
G1 X98.441 Y93.601 E.27912
G1 X98.456 Y100.59 E.13748
G1 X96.874 Y100.59 E.03111
G1 X96.874 Y94.918 E.11157
G1 X96.898 Y90 E.09673
G1 X96.874 Y85.083 E.09672
G1 X96.874 Y79.47 E.11039
M204 S10000
G1 X97.664 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.351419
G1 F1500
M204 S6000
G1 X97.664 Y99.969 E.32393
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.664 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 66/74
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.28 I.939 J-.774 P1  F18000
G1 X82.692 Y79.819 Z8.28
G1 Z8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.692 Y100.181 E.43097
G1 X81.971 Y100.181 E.01526
G1 X81.971 Y79.819 E.43097
G1 X82.632 Y79.819 E.01399
M204 S250
G1 X83.101 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.101 Y100.59 E.41659
G1 X81.562 Y100.59 E.03028
G1 X81.562 Y79.41 E.41659
G1 X83.041 Y79.41 E.0291
; WIPE_START
M204 S6000
G1 X83.047 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.331 Y80.031
G1 Z8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.322322
G1 F1500
M204 S6000
G1 X82.331 Y99.969 E.29499
; WIPE_START
G1 X82.331 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.186 Y92.079 Z8.4 F18000
G1 X97.29 Y79.819 Z8.4
G1 Z8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.028 Y79.819 E.01562
G1 X98.029 Y100.181 E.43097
G1 X97.29 Y100.181 E.01563
G1 X97.29 Y94.29 E.12469
G1 X97.311 Y90 E.0908
G1 X97.29 Y85.711 E.09078
G1 X97.29 Y79.879 E.12343
M204 S250
G1 X96.881 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.438 Y79.41 E.03062
G1 X98.437 Y79.712 E.00594
G1 X98.438 Y100.59 E.41065
G1 X96.881 Y100.59 E.03062
G1 X96.881 Y94.29 E.12392
G1 X96.902 Y90 E.08438
G1 X96.881 Y85.71 E.08437
G1 X96.881 Y79.47 E.12274
M204 S10000
G1 X97.659 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.329021
G1 F1500
M204 S6000
G1 X97.659 Y99.969 E.30165
; CHANGE_LAYER
; Z_HEIGHT: 8.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.659 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 67/74
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.4 I.939 J-.775 P1  F18000
G1 X82.684 Y79.819 Z8.4
M73 P93 R2
G1 Z8.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.684 Y89.994 E.21535
G1 X82.684 Y100.181 E.21562
G1 X81.991 Y100.181 E.01465
G1 X81.991 Y79.819 E.43097
G1 X82.624 Y79.819 E.01338
M204 S250
G1 X83.093 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.093 Y89.994 E.20817
G1 X83.093 Y100.59 E.20842
G1 X81.582 Y100.59 E.02972
G1 X81.582 Y79.41 E.41659
G1 X83.033 Y79.41 E.02854
; WIPE_START
M204 S6000
G1 X83.044 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




G1 X82.338 Y80.031
G1 Z8.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.293832
G1 F1500
M204 S6000
G1 X82.338 Y99.969 E.26665
; WIPE_START
G1 X82.338 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.192 Y92.079 Z8.52 F18000
G1 X97.298 Y79.819 Z8.52
G1 Z8.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.01 Y79.819 E.01507
G1 X98.01 Y100.181 E.43097
G1 X97.298 Y100.181 E.01507
G1 X97.315 Y90 E.21549
G1 X97.298 Y79.879 E.21421
M204 S250
G1 X96.888 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.419 Y79.41 E.03011
G1 X98.419 Y100.59 E.41659
G1 X96.888 Y100.59 E.03011
G1 X96.906 Y90 E.2083
G1 X96.888 Y79.47 E.20711
M204 S10000
G1 X97.654 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.304574
G1 F1500
M204 S6000
G1 X97.654 Y99.969 E.27734
; CHANGE_LAYER
; Z_HEIGHT: 8.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X97.654 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 68/74
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.52 I1.217 J-.023 P1  F18000
G1 X97.316 Y79.819 Z8.52
G1 Z8.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.987 Y79.819 E.01419
G1 X97.986 Y100.181 E.43097
G1 X97.316 Y100.181 E.01418
G1 X97.316 Y79.879 E.4297
M204 S250
G1 X96.907 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.396 Y79.41 E.02928
G1 X98.396 Y79.767 E.00703
G1 X98.396 Y100.59 E.40956
G1 X96.907 Y100.59 E.02928
G1 X96.907 Y79.47 E.41541
; WIPE_START
M204 S6000
G1 X98.396 Y79.41 E-.28308
G1 X98.396 Y79.767 E-.06789
G1 X98.396 Y79.92 E-.02903
; WIPE_END
G1 E-.02 F1800
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




G1 X97.651 Y80.031
G1 Z8.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.2718
G1 F1500
M204 S6000
G1 X97.651 Y99.969 E.24474
; WIPE_START
G1 X97.651 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.794 Y92.081 Z8.64 F18000
G1 X82.68 Y79.819 Z8.64
G1 Z8.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.68 Y88.143 E.17618
G1 X82.68 Y100.181 E.25479
G1 X82.013 Y100.181 E.01411
G1 X82.013 Y79.819 E.43097
G1 X82.62 Y79.819 E.01284
M204 S250
G1 X83.089 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.089 Y88.143 E.17177
G1 X83.089 Y100.59 E.24482
G1 X81.604 Y100.59 E.02921
G1 X81.604 Y79.41 E.41659
G1 X83.029 Y79.41 E.02803
M204 S10000
G1 X82.347 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.268032
G1 F1500
M204 S6000
G1 X82.347 Y99.969 E.24099
; CHANGE_LAYER
; Z_HEIGHT: 8.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M73 P93 R1
G1 X82.347 Y97.969 E-.38
; WIPE_END
M73 P94 R1
G1 E-.02 F1800
; layer num/total_layer_count: 69/74
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.64 I.939 J.774 P1  F18000
G1 X97.312 Y79.819 Z8.64
G1 Z8.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.963 Y79.819 E.01377
G1 X97.962 Y100.181 E.43097
G1 X97.321 Y100.181 E.01358
G1 X97.312 Y79.879 E.4297
M204 S250
G1 X96.903 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.372 Y79.41 E.0289
G1 X98.372 Y100.59 E.41659
G1 X96.912 Y100.59 E.02872
G1 X96.903 Y79.47 E.41541
; WIPE_START
M204 S6000
G1 X98.372 Y79.41 E-.27936
G1 X98.372 Y79.94 E-.10064
; WIPE_END
G1 E-.02 F1800
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




G1 X97.637 Y80.031
G1 Z8.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.247578
G1 F1500
M204 S6000
G1 X97.642 Y99.969 E.22064
; WIPE_START
G1 X97.641 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.786 Y92.08 Z8.76 F18000
G1 X82.676 Y79.819 Z8.76
G1 Z8.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.676 Y86.293 E.13702
G1 X82.676 Y100.181 E.29395
G1 X82.038 Y100.181 E.0135
G1 X82.038 Y79.819 E.43097
G1 X82.616 Y79.819 E.01223
M204 S250
G1 X83.085 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.085 Y86.293 E.13538
G1 X83.085 Y100.59 E.28121
G1 X81.629 Y100.59 E.02865
G1 X81.629 Y79.41 E.41659
G1 X83.025 Y79.41 E.02746
M204 S10000
G1 X82.357 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.239348
G1 F1500
M204 S6000
G1 X82.357 Y99.969 E.21246
; CHANGE_LAYER
; Z_HEIGHT: 8.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.357 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 70/74
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.76 I.939 J.774 P1  F18000
G1 X97.319 Y79.819 Z8.76
G1 Z8.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.932 Y79.819 E.01296
G1 X97.935 Y100.181 E.43097
G1 X97.326 Y100.181 E.01289
G1 X97.319 Y79.879 E.4297
M204 S250
G1 X96.91 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.341 Y79.41 E.02816
G1 X98.341 Y79.464 E.00105
G1 X98.344 Y100.59 E.41554
G1 X96.917 Y100.59 E.02808
G1 X96.91 Y79.47 E.41541
; WIPE_START
M204 S6000
G1 X98.341 Y79.41 E-.27222
G1 X98.341 Y79.464 E-.01018
G1 X98.341 Y79.977 E-.09759
; WIPE_END
G1 E-.02 F1800
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




G1 X97.625 Y80.031
G1 Z8.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.212247
G1 F1500
M204 S6000
G1 X97.63 Y99.969 E.1855
; WIPE_START
G1 X97.63 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.776 Y92.079 Z8.88 F18000
G1 X82.672 Y79.819 Z8.88
G1 Z8.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.672 Y84.443 E.09786
G1 X82.672 Y100.181 E.33311
G1 X82.065 Y100.181 E.01284
G1 X82.065 Y79.819 E.43097
M73 P95 R1
G1 X82.612 Y79.819 E.01157
M204 S250
G1 X83.081 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.081 Y84.443 E.09899
G1 X83.081 Y100.59 E.31761
G1 X81.656 Y100.59 E.02803
G1 X81.656 Y79.41 E.41659
G1 X83.021 Y79.41 E.02685
M204 S10000
G1 X82.369 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.208084
G1 F1500
M204 S6000
G1 X82.369 Y99.969 E.18136
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F1500
G1 X82.369 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 71/74
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.88 I.939 J.774 P1  F18000
G1 X97.326 Y79.819 Z8.88
G1 Z8.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.905 Y79.819 E.01224
G1 X97.905 Y100.181 E.43097
G1 X97.331 Y100.181 E.01217
G1 X97.326 Y79.879 E.4297
M204 S250
G1 X96.917 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.314 Y79.41 E.02748
G1 X98.315 Y100.59 E.41659
G1 X96.921 Y100.59 E.0274
G1 X96.917 Y79.47 E.41541
; WIPE_START
M204 S6000
G1 X98.314 Y79.41 E-.26567
G1 X98.314 Y80.012 E-.11433
; WIPE_END
G1 E-.02 F1800
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




G1 X97.616 Y80.031
G1 Z8.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.178109
G1 F1500
M204 S6000
G1 X97.618 Y99.969 E.15155
; WIPE_START
G1 X97.618 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.765 Y92.077 Z9 F18000
G1 X82.668 Y79.819 Z9
G1 Z8.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.668 Y82.592 E.05869
G1 X82.668 Y100.181 E.37228
G1 X82.095 Y100.181 E.01212
G1 X82.095 Y79.819 E.43097
G1 X82.608 Y79.819 E.01085
M204 S250
G1 X83.077 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.077 Y82.592 E.06259
G1 X83.077 Y100.59 E.354
G1 X81.686 Y100.59 E.02737
G1 X81.686 Y79.41 E.41659
G1 X83.017 Y79.41 E.02619
M204 S10000
G1 X82.382 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.174333
G1 F1500
M204 S6000
G1 X82.382 Y99.969 E.14779
; CHANGE_LAYER
; Z_HEIGHT: 8.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.382 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 72/74
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9 I.939 J.774 P1  F18000
G1 X97.334 Y79.827 Z9
G1 Z8.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.866 Y79.823 E.01126
G1 X97.871 Y100.181 E.43088
G1 X97.335 Y100.181 E.01133
G1 X97.334 Y79.887 E.42953
M204 S250
G1 X96.924 Y79.42 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.275 Y79.411 E.02656
G1 X98.28 Y100.59 E.41656
G1 X96.926 Y100.59 E.02663
G1 X96.924 Y79.48 E.41521
; WIPE_START
M204 S6000
G1 X98.275 Y79.411 E-.25691
G1 X98.275 Y80.059 E-.12309
; WIPE_END
G1 E-.02 F1800
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




G1 X97.6 Y80.037
G1 Z8.72
M73 P96 R1
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.135091
G1 F1500
M204 S6000
G1 X97.603 Y99.969 E.10872
; WIPE_START
G1 X97.603 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.752 Y92.076 Z9.12 F18000
G1 X82.664 Y79.819 Z9.12
G1 Z8.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X82.664 Y80.742 E.01953
G1 X82.664 Y100.181 E.41144
G1 X82.13 Y100.181 E.01131
G1 X82.13 Y79.819 E.43097
G1 X82.604 Y79.819 E.01004
M204 S250
G1 X83.074 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.074 Y80.742 E.0262
G1 X83.074 Y100.59 E.39039
G1 X81.721 Y100.59 E.02661
G1 X81.721 Y79.41 E.41659
G1 X83.014 Y79.41 E.02543
M204 S10000
G1 X82.397 Y80.031 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.136023
G1 F1500
M204 S6000
G1 X82.397 Y99.969 E.10968
; CHANGE_LAYER
; Z_HEIGHT: 8.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X82.397 Y97.969 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 73/74
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.12 I.939 J.775 P1  F18000
G1 X97.378 Y79.819 Z9.12
G1 Z8.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1499
M204 S500
G1 X97.767 Y79.819 E.00822
G1 X97.776 Y100.181 E.43097
G1 X97.378 Y100.181 E.00843
G1 X97.378 Y79.879 E.4297
M204 S250
G1 X96.969 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1499
M204 S500
G1 X98.176 Y79.41 E.02373
G1 X98.186 Y100.59 E.41659
G1 X96.969 Y100.59 E.02393
G1 X96.969 Y79.47 E.41541
; WIPE_START
G1 F1500
M204 S6000
G1 X98.176 Y79.41 E-.22952
G1 X98.176 Y80.202 E-.15048
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.546 Y80.014 Z9.24 F18000
G1 X82.617 Y79.819 Z9.24
G1 Z8.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1499
M204 S500
G1 X82.622 Y100.181 E.43097
G1 X82.236 Y100.181 E.00818
G1 X82.236 Y90.39 E.20723
G1 X82.223 Y90 E.00826
G1 X82.236 Y89.61 E.00826
G1 X82.236 Y79.819 E.20723
G1 X82.557 Y79.819 E.00681
M204 S250
G1 X83.026 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1499
M204 S500
G1 X83.032 Y100.59 E.41659
G1 X81.82 Y100.59 E.02382
G1 X81.82 Y79.41 E.41659
G1 X82.966 Y79.41 E.02255
; WIPE_START
G1 F1500
M204 S6000
G1 X82.973 Y81.41 E-.38
; WIPE_END
G1 E-.02 F1800
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




; CHANGE_LAYER
; Z_HEIGHT: 8.96
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 74/74
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
; OBJECT_ID: 8
G1 X97.321 Y79.41 F18000
G1 Z8.96
G1 E.4 F1800
G1 F765
M204 S500
G1 X97.708 Y79.41 E.00761
G1 X97.708 Y79.43 E.00039
G1 X97.708 Y79.49 E.00118
G1 X97.672 Y79.564 E.00162
G1 X97.707 Y81.894 E.04583
G1 X97.685 Y82.192 E.00589
G1 X97.685 Y87.008 E.09471
G1 X97.707 Y87.306 E.00589
G1 X97.672 Y89.636 E.04583
G1 X97.708 Y89.71 E.00162
G1 X97.708 Y89.772 E.00121
G1 X97.708 Y90.29 E.01019
G1 X97.672 Y90.364 E.00162
G1 X97.707 Y92.694 E.04583
M73 P96 R0
G1 X97.685 Y92.992 E.00589
M73 P97 R0
G1 X97.685 Y97.808 E.09471
G1 X97.707 Y98.106 E.00589
G1 X97.672 Y100.436 E.04583
G1 X97.707 Y100.509 E.0016
G1 X97.707 Y100.59 E.00159
G1 X97.321 Y100.59 E.00759
G1 X97.309 Y99.816 E.01523
G1 X97.339 Y99.714 E.00209
G1 X97.309 Y98.803 E.01792
G1 X97.327 Y96.858 E.03827
G1 X97.312 Y96.578 E.00552
G1 X97.329 Y96.208 E.00729
G1 X97.311 Y95.568 E.01258
G1 X97.309 Y91.853 E.07307
G1 X97.339 Y91.086 E.0151
G1 X97.309 Y90.984 E.0021
G1 X97.322 Y90.244 E.01456
G1 X97.309 Y89.017 E.02414
G1 X97.339 Y88.914 E.0021
G1 X97.309 Y88.002 E.01795
G1 X97.311 Y84.432 E.07023
G1 X97.329 Y83.792 E.01258
G1 X97.312 Y83.422 E.00729
G1 X97.327 Y83.142 E.00551
G1 X97.309 Y81.052 E.04111
G1 X97.339 Y80.286 E.01508
G1 X97.309 Y80.184 E.0021
G1 X97.32 Y79.47 E.01405
; WIPE_START
G1 F1500
M204 S6000
G1 X97.708 Y79.41 E-.07452
G1 X97.708 Y79.43 E-.00373
G1 X97.708 Y79.49 E-.01144
G1 X97.672 Y79.564 E-.01569
G1 X97.694 Y81.01 E-.27462
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.104 Y80.202 Z9.36 F18000
G1 X82.665 Y79.41 Z9.36
G1 Z8.96
G1 E.4 F1800
G1 F765
M204 S500
G1 X82.661 Y79.795 E.00758
G1 X82.691 Y79.903 E.00219
G1 X82.692 Y81.899 E.03926
G1 X82.638 Y84.11 E.04351
G1 X82.638 Y85.504 E.02742
G1 X82.684 Y85.858 E.00701
G1 X82.692 Y88.168 E.04545
G1 X82.687 Y88.31 E.00279
G1 X82.589 Y88.592 E.00587
G1 X82.692 Y89.013 E.00853
G1 X82.692 Y89.296 E.00556
G1 X82.661 Y89.405 E.00223
G1 X82.666 Y89.927 E.01028
G1 X82.684 Y90 E.00148
G1 X82.666 Y90.073 E.00148
G1 X82.661 Y90.595 E.01028
G1 X82.692 Y90.704 E.00223
G1 X82.692 Y90.987 E.00556
G1 X82.589 Y91.408 E.00853
G1 X82.687 Y91.69 E.00587
G1 X82.692 Y91.832 E.00279
G1 X82.684 Y94.142 E.04545
G1 X82.638 Y94.496 E.00701
G1 X82.638 Y95.89 E.02742
G1 X82.692 Y98.101 E.04351
G1 X82.691 Y100.097 E.03926
G1 X82.661 Y100.205 E.00219
G1 X82.665 Y100.59 E.00758
G1 X82.293 Y100.59 E.00731
G1 X82.33 Y99.954 E.01252
G1 X82.293 Y98.106 E.03636
G1 X82.315 Y97.808 E.00588
G1 X82.315 Y92.992 E.09472
G1 X82.296 Y92.738 E.00502
G1 X82.338 Y92.645 E.002
G1 X82.302 Y92.476 E.0034
G1 X82.33 Y90.845 E.03208
G1 X82.292 Y90.33 E.01017
G1 X82.292 Y89.67 E.01297
G1 X82.33 Y89.155 E.01017
G1 X82.302 Y87.524 E.03208
G1 X82.338 Y87.355 E.0034
G1 X82.296 Y87.262 E.002
G1 X82.315 Y87.008 E.00502
G1 X82.315 Y82.192 E.09472
G1 X82.293 Y81.894 E.00588
G1 X82.33 Y80.046 E.03636
G1 X82.293 Y79.41 E.01252
G1 X82.605 Y79.41 E.00613
; WIPE_START
G1 F1500
M204 S6000
G1 X82.661 Y79.795 E-.074
G1 X82.691 Y79.903 E-.02117
M73 P98 R0
G1 X82.692 Y81.402 E-.28483
; WIPE_END
G1 E-.02 F1800
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

