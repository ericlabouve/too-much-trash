; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 16m 31s; total estimated time: 24m 35s
; total layer number: 49
; total filament length [mm] : 398.44
; total filament volume [cm^3] : 958.37
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
M73 P2 R24
    G1 E50 F200
    M400
    M1002 set_filament_type:TPU

    M104 S250

    G92 E0
    G1 E50 F49.8898
    M400
    M106 P1 S178
    G92 E0
M73 P3 R23
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P7 R22
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
    G29 A1 X76.0347 Y76.1009 I27.9305 J27.7982
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
M73 P28 R17
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
G1 X91.599 Y84.164 F18000
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
G1 X91.599 Y78.865 E.20139
G1 X95.271 Y78.865 E.13955
G1 X95.271 Y88.437 E.36379
G1 X91.599 Y88.437 E.13955
G1 X91.599 Y84.224 E.16011
M204 S6000
G1 X91.142 Y84.968 F18000
G1 F900
M204 S500
G1 X91.142 Y78.408 E.24932
G1 X95.728 Y78.408 E.17429
M73 P30 R16
G1 X95.728 Y88.894 E.39853
G1 X91.142 Y88.894 E.17429
G1 X91.142 Y85.028 E.14693
; WIPE_START
G1 X91.142 Y83.028 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X95.561 Y89.251 Z.6 F18000
G1 X97.35 Y91.768 Z.6
M73 P31 R16
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
M73 P32 R16
G1 F900
M204 S500
G1 X99.858 Y90.012 E.11639
G1 X100.217 Y89.761 E.01663
G1 X102.224 Y92.628 E.13302
G1 X99.357 Y94.635 E.13302
G1 X97.384 Y91.818 E.13074
; WIPE_START
G1 X99 Y90.639 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X92.447 Y94.553 Z.6 F18000
G1 X91.031 Y95.398 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X91.099 Y95.318 E.004
G1 X91.174 Y95.275 E.00328
G1 X91.263 Y95.275 E.00339
G1 X91.845 Y95.414 E.02275
G1 X91.321 Y95.717 E.02299
G1 X90.977 Y95.76 E.0132
G1 X91.022 Y95.458 E.0116
; WIPE_START
G1 X91.099 Y95.318 E-.0303
G1 X91.174 Y95.275 E-.01639
M73 P33 R16
G1 X91.263 Y95.275 E-.01697
G1 X91.845 Y95.414 E-.11372
G1 X91.321 Y95.717 E-.11494
G1 X90.977 Y95.76 E-.066
G1 X90.994 Y95.647 E-.02167
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X96.601 Y92.293 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X98.658 Y95.23 E.13629
G1 X94.503 Y98.139 E.19276
G1 X92.397 Y95.131 E.13955
G1 X96.552 Y92.222 E.19276
G1 X96.567 Y92.244 E.00098
M204 S6000
G1 X96.975 Y92.031 F18000
G1 F900
M204 S500
G1 X99.294 Y95.342 E.15366
G1 X94.391 Y98.776 E.2275
G1 X92.245 Y95.711 E.1422
G1 X91.464 Y96.153 E.03411
G1 X91.328 Y96.186 E.00529
G1 X91.107 Y96.206 E.00844
G1 X90.751 Y96.36 E.01473
G1 X90.634 Y96.384 E.00454
G1 X90.443 Y96.385 E.00727
G1 X90.565 Y95.342 E.03989
G1 X90.62 Y95.192 E.00608
G1 X90.708 Y95.058 E.00608
G1 X90.825 Y94.948 E.00608
G1 X90.981 Y94.858 E.00687
G1 X91.142 Y94.818 E.0063
G1 X91.317 Y94.818 E.00665
G1 X91.862 Y94.948 E.0213
G1 X96.664 Y91.586 E.2228
G1 X96.941 Y91.981 E.01835
; WIPE_START
G1 X98.088 Y93.62 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X91.615 Y97.663 Z.6 F18000
G1 X86.582 Y100.807 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X86.505 Y101.012 E.00835
G1 X86.274 Y101.428 E.01807
G1 X85.965 Y101.803 E.01847
G1 X85.601 Y102.111 E.01813
G1 X85.318 Y102.286 E.01264
G1 X85.015 Y102.426 E.01271
G1 X84.559 Y102.56 E.01806
G1 X84.086 Y102.609 E.01807
G1 X83.752 Y102.594 E.0127
G1 X83.421 Y102.54 E.01273
G1 X82.97 Y102.393 E.01805
G1 X82.542 Y102.162 E.01847
G1 X82.162 Y101.859 E.01848
G1 X81.849 Y101.502 E.01804
G1 X81.669 Y101.22 E.01271
G1 X81.525 Y100.92 E.01265
G1 X81.384 Y100.464 E.01813
G1 X81.326 Y99.982 E.01847
G1 X81.355 Y99.497 E.01846
G1 X81.468 Y99.035 E.01807
G1 X81.595 Y98.726 E.01271
G1 X81.756 Y98.435 E.01264
G1 X82.048 Y98.058 E.01814
G1 X82.403 Y97.738 E.01814
G1 X82.681 Y97.555 E.01263
G1 X82.98 Y97.406 E.01271
G1 X83.432 Y97.259 E.01806
G1 X83.913 Y97.194 E.01847
G1 X84.398 Y97.215 E.01846
G1 X84.87 Y97.323 E.01838
G1 X85.309 Y97.51 E.01812
G1 X85.592 Y97.685 E.01265
G1 X85.855 Y97.895 E.01279
G1 X86.171 Y98.236 E.01767
G1 X86.36 Y98.511 E.01269
G1 X86.514 Y98.809 E.01273
G1 X86.664 Y99.248 E.01765
G1 X86.724 Y99.578 E.01272
G1 X86.744 Y99.911 E.0127
G1 X86.702 Y100.374 E.01766
G1 X86.623 Y100.699 E.0127
G1 X86.604 Y100.75 E.00209
M204 S6000
G1 X86.155 Y100.646 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X86.089 Y100.82 E.00705
G1 X85.895 Y101.169 E.0152
G1 X85.638 Y101.481 E.01534
G1 X85.332 Y101.74 E.01526
G1 X85.101 Y101.883 E.01031
G1 X84.854 Y101.997 E.01037
G1 X84.47 Y102.109 E.0152
G1 X84.072 Y102.151 E.0152
G1 X83.8 Y102.139 E.01036
G1 X83.53 Y102.094 E.01038
G1 X83.15 Y101.971 E.01519
G1 X82.795 Y101.779 E.01534
G1 X82.479 Y101.528 E.01535
G1 X82.216 Y101.227 E.01517
G1 X82.069 Y100.997 E.01038
G1 X81.952 Y100.753 E.01031
G1 X81.833 Y100.369 E.01527
G1 X81.785 Y99.968 E.01533
G1 X81.809 Y99.565 E.01534
G1 X81.904 Y99.177 E.0152
G1 X82.007 Y98.924 E.01038
G1 X82.139 Y98.688 E.01029
G1 X82.385 Y98.37 E.01527
G1 X82.683 Y98.101 E.01527
G1 X82.909 Y97.952 E.0103
G1 X83.154 Y97.83 E.01037
G1 X83.534 Y97.706 E.01519
G1 X83.934 Y97.652 E.01534
G1 X84.337 Y97.67 E.01534
G1 X84.728 Y97.76 E.01526
G1 X85.098 Y97.917 E.01526
G1 X85.328 Y98.06 E.0103
G1 X85.544 Y98.231 E.01045
G1 X85.813 Y98.521 E.01506
G1 X85.966 Y98.746 E.01035
G1 X86.092 Y98.989 E.01038
G1 X86.22 Y99.364 E.01505
G1 X86.269 Y99.632 E.01038
G1 X86.285 Y99.904 E.01036
G1 X86.25 Y100.299 E.01506
G1 X86.185 Y100.564 E.01036
G1 X86.176 Y100.59 E.00105
; WIPE_START
G1 X86.089 Y100.82 E-.04665
G1 X85.895 Y101.169 E-.076
G1 X85.638 Y101.481 E-.07668
G1 X85.332 Y101.74 E-.07628
G1 X85.101 Y101.883 E-.05152
G1 X84.854 Y101.997 E-.05183
G1 X84.848 Y101.999 E-.00105
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X85.056 Y96.208 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X85.177 Y96.208 E.00461
G1 X86.649 Y97.899 E.08522
G1 X86.962 Y98.394 E.02226
G1 X87.043 Y98.561 E.00704
G1 X87.23 Y99.112 E.02212
G1 X87.302 Y99.501 E.015
G1 X87.327 Y99.901 E.01524
G1 X87.306 Y100.27 E.01406
G1 X87.237 Y100.662 E.01511
G1 X87.123 Y101.04 E.01501
G1 X86.878 Y101.56 E.02187
G1 X86.539 Y102.038 E.02225
G1 X86.26 Y102.326 E.01526
G1 X85.949 Y102.58 E.01525
G1 X85.444 Y102.876 E.02227
G1 X85.284 Y102.947 E.00663
G1 X84.725 Y103.12 E.02226
G1 X84.324 Y103.18 E.0154
G1 X83.926 Y103.191 E.01511
G1 X83.345 Y103.12 E.02226
G1 X82.785 Y102.947 E.02227
G1 X82.274 Y102.682 E.02187
G1 X81.957 Y102.454 E.01486
G1 X81.669 Y102.19 E.01485
G1 X81.415 Y101.893 E.01485
G1 X81.197 Y101.569 E.01486
G1 X81.014 Y101.211 E.01526
G1 X80.834 Y100.669 E.02172
G1 X80.765 Y100.28 E.015
G1 X80.743 Y99.89 E.01484
G1 X80.768 Y99.501 E.01484
G1 X80.839 Y99.112 E.01501
G1 X81.023 Y98.571 E.02174
G1 X81.208 Y98.215 E.01524
G1 X81.427 Y97.892 E.01485
G1 X82.892 Y96.208 E.08482
G1 X84.996 Y96.208 E.07995
; WIPE_START
G1 X85.177 Y96.208 E-.03446
G1 X86.371 Y97.58 E-.34554
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X78.912 Y95.96 Z.6 F18000
G1 X76.733 Y95.486 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X76.945 Y95.416 E.00849
G1 X77.184 Y95.829 E.01812
G1 X77.54 Y96.11 E.01725
G1 X77.701 Y96.148 E.00629
G1 X77.656 Y96.403 E.00983
G1 X77.343 Y96.367 E.01198
G1 X77.212 Y96.323 E.00524
G1 X76.986 Y96.168 E.01043
G1 X76.855 Y96.005 E.00793
G1 X76.788 Y95.862 E.00603
G1 X76.742 Y95.545 E.01215
; WIPE_START
G1 X76.945 Y95.416 E-.04583
G1 X77.184 Y95.829 E-.0906
G1 X77.54 Y96.11 E-.08623
G1 X77.701 Y96.148 E-.03146
G1 X77.656 Y96.403 E-.04915
G1 X77.343 Y96.367 E-.05991
G1 X77.259 Y96.339 E-.01681
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X77.056 Y88.709 Z.6 F18000
G1 X76.757 Y77.454 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X76.829 Y77.246 E.00836
G1 X76.901 Y77.129 E.00524
G1 X77.062 Y76.966 E.00871
G1 X77.265 Y76.858 E.00872
G1 X77.406 Y76.82 E.00558
G1 X77.684 Y76.81 E.01056
G1 X77.732 Y77.025 E.00837
G1 X77.413 Y77.174 E.01338
G1 X77.138 Y77.434 E.01437
G1 X76.953 Y77.802 E.01567
G1 X76.742 Y77.752 E.00824
G1 X76.754 Y77.514 E.00905
; WIPE_START
G1 X76.829 Y77.246 E-.05287
G1 X76.901 Y77.129 E-.0262
G1 X77.062 Y76.966 E-.04353
G1 X77.265 Y76.858 E-.04359
G1 X77.406 Y76.82 E-.02792
G1 X77.684 Y76.81 E-.0528
G1 X77.732 Y77.025 E-.04182
G1 X77.413 Y77.174 E-.06689
G1 X77.319 Y77.262 E-.02438
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X80.513 Y84.194 Z.6 F18000
G1 X86.344 Y96.852 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X87.007 Y97.615 E.03841
G1 X87.133 Y97.789 E.00818
G1 X87.365 Y98.178 E.0172
G1 X87.46 Y98.375 E.00833
G1 X87.543 Y98.578 E.00832
G1 X87.675 Y99.003 E.01691
G1 X87.756 Y99.445 E.01707
G1 X87.785 Y99.892 E.01705
G1 X87.76 Y100.33 E.01664
G1 X87.683 Y100.768 E.01691
G1 X87.553 Y101.198 E.01707
G1 X87.375 Y101.605 E.01691
G1 X87.269 Y101.798 E.00833
G1 X87.017 Y102.174 E.0172
G1 X86.882 Y102.341 E.00818
G1 X86.57 Y102.664 E.01706
G1 X86.222 Y102.947 E.01706
G1 X86.043 Y103.067 E.00818
G1 X85.647 Y103.286 E.01721
G1 X85.45 Y103.373 E.00818
G1 X85.021 Y103.519 E.0172
G1 X84.812 Y103.569 E.00818
G1 X84.365 Y103.636 E.01721
G1 X83.92 Y103.649 E.01692
G1 X83.705 Y103.636 E.00818
G1 X83.257 Y103.569 E.0172
G1 X83.048 Y103.519 E.00818
G1 X82.619 Y103.373 E.0172
G1 X82.422 Y103.286 E.00819
G1 X82.03 Y103.069 E.01705
G1 X81.668 Y102.809 E.01693
G1 X81.34 Y102.508 E.01692
G1 X81.05 Y102.17 E.01692
G1 X80.802 Y101.801 E.01692
G1 X80.598 Y101.401 E.01706
G1 X80.518 Y101.201 E.00818
G1 X80.389 Y100.775 E.01691
G1 X80.31 Y100.333 E.01707
G1 X80.285 Y99.889 E.01692
G1 X80.313 Y99.445 E.01691
G1 X80.394 Y99.003 E.01707
G1 X80.525 Y98.581 E.01677
G1 X80.608 Y98.379 E.00833
G1 X80.815 Y97.98 E.01706
G1 X81.065 Y97.612 E.01691
G1 X81.727 Y96.851 E.03835
G1 X77.549 Y96.851 E.15878
G1 X77.243 Y96.815 E.01171
G1 X77.036 Y96.747 E.00828
G1 X76.917 Y96.686 E.0051
G1 X76.675 Y96.507 E.01144
G1 X76.53 Y96.344 E.00827
G1 X76.455 Y96.229 E.00524
G1 X76.359 Y96.025 E.00856
G1 X76.321 Y95.896 E.0051
G1 X76.285 Y95.586 E.01185
G1 X76.285 Y77.612 E.68315
G1 X76.305 Y77.382 E.00878
G1 X76.337 Y77.246 E.0053
G1 X76.419 Y77.04 E.00841
G1 X76.533 Y76.855 E.00828
G1 X76.68 Y76.69 E.0084
G1 X76.788 Y76.599 E.00539
G1 X76.907 Y76.521 E.00539
G1 X77.108 Y76.427 E.00841
G1 X77.32 Y76.37 E.00836
G1 X77.462 Y76.353 E.00544
G1 X90.522 Y76.351 E.49634
G1 X90.826 Y76.387 E.01166
G1 X91.029 Y76.454 E.00814
G1 X91.218 Y76.556 E.00813
G1 X91.446 Y76.747 E.0113
G1 X91.576 Y76.912 E.00799
G1 X91.709 Y77.177 E.01129
G1 X91.764 Y77.381 E.00802
G1 X91.8 Y77.951 E.0217
G1 X96.185 Y77.951 E.16665
G1 X96.185 Y89.351 E.43327
G1 X90.685 Y89.351 E.20904
G1 X90.685 Y77.451 E.45228
G1 X78.017 Y77.451 E.48147
G1 X77.848 Y77.476 E.00648
G1 X77.673 Y77.557 E.00734
G1 X77.51 Y77.711 E.0085
G1 X77.41 Y77.91 E.00848
G1 X77.385 Y78.083 E.00663
G1 X77.385 Y95.123 E.64763
G1 X77.42 Y95.324 E.00778
G1 X77.536 Y95.524 E.00878
G1 X77.744 Y95.689 E.01007
G1 X78.005 Y95.751 E.01023
G1 X90.057 Y95.751 E.45804
G1 X90.117 Y95.236 E.01971
G1 X90.209 Y94.985 E.01015
G1 X90.356 Y94.762 E.01015
G1 X90.55 Y94.579 E.01014
G1 X90.788 Y94.442 E.01043
G1 X91.095 Y94.361 E.01209
G1 X91.371 Y94.361 E.01047
M73 P34 R16
G1 X91.768 Y94.456 E.01553
G1 X100.462 Y88.368 E.40338
G1 X103.617 Y92.874 E.20903
G1 X94.279 Y99.412 E.43327
G1 X92.111 Y96.316 E.14364
G1 X91.719 Y96.543 E.0172
G1 X91.603 Y96.59 E.00475
G1 X91.404 Y96.638 E.0078
G1 X91.222 Y96.655 E.00694
G1 X90.89 Y96.798 E.01376
G1 X90.682 Y96.841 E.00807
G1 X86.404 Y96.852 E.16259
; WIPE_START
G1 X87.007 Y97.615 E-.18478
G1 X87.133 Y97.789 E-.04091
G1 X87.365 Y98.178 E-.08597
G1 X87.46 Y98.375 E-.04163
G1 X87.514 Y98.505 E-.0267
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




G1 X86.055 Y97.672
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.200132
G1 F900
M204 S500
G1 X85.921 Y97.544 E.00241
; LINE_WIDTH: 0.234883
G1 X85.779 Y97.408 E.00315
; LINE_WIDTH: 0.271949
G1 X85.685 Y97.329 E.00233
; LINE_WIDTH: 0.308779
G1 X85.592 Y97.249 E.00271
; LINE_WIDTH: 0.349493
G1 X85.479 Y97.155 E.00376
M204 S6000
G1 X85.406 Y96.819 F18000
; LINE_WIDTH: 0.67451
G1 F900
M204 S500
G1 X84.948 Y96.767 E.02416
; LINE_WIDTH: 0.62585
G1 X84.491 Y96.716 E.0223
; LINE_WIDTH: 0.58338
G1 X83.867 Y96.702 E.02805
; LINE_WIDTH: 0.591063
G1 X83.604 Y96.719 E.01204
; LINE_WIDTH: 0.630729
G1 X83.286 Y96.743 E.01559
; LINE_WIDTH: 0.678789
G1 X82.64 Y96.846 E.03454
M204 S6000
G1 X82.795 Y96.999 F18000
; LINE_WIDTH: 0.486103
G1 F900
M204 S500
G1 X82.823 Y96.979 E.00126
M204 S6000
G1 X82.795 Y96.999 F18000
; LINE_WIDTH: 0.454138
G1 F900
M204 S500
G1 X82.697 Y97.075 E.00424
; LINE_WIDTH: 0.40592
G1 X82.599 Y97.151 E.00375
; LINE_WIDTH: 0.357702
G1 X82.501 Y97.227 E.00325
; LINE_WIDTH: 0.330704
G1 X82.488 Y97.238 E.00042
; LINE_WIDTH: 0.303032
G1 X82.35 Y97.359 E.00396
; LINE_WIDTH: 0.253393
G1 X82.212 Y97.48 E.00321
; LINE_WIDTH: 0.22722
G1 X82.202 Y97.489 E.00021
; LINE_WIDTH: 0.210091
G1 X82.021 Y97.673 E.00359
; LINE_WIDTH: 0.168614
G1 X81.662 Y98.073 E.00561
G1 X81.46 Y98.365 E.00372
G1 X81.291 Y98.692 E.00385
G1 X81.127 Y99.184 E.00542
G1 X81.059 Y99.536 E.00375
G1 X81.038 Y99.996 E.00481
G1 X81.102 Y100.53 E.00562
G1 X81.257 Y101.03 E.00547
G1 X81.418 Y101.364 E.00388
G1 X81.648 Y101.716 E.00439
G1 X81.966 Y102.072 E.00499
G1 X82.387 Y102.407 E.00562
G1 X82.861 Y102.661 E.00562
G1 X83.348 Y102.82 E.00536
G1 X83.725 Y102.879 E.00399
G1 X84.09 Y102.898 E.00382
G1 X84.62 Y102.843 E.00557
G1 X85.112 Y102.699 E.00536
G1 X85.451 Y102.54 E.00391
G1 X85.776 Y102.344 E.00397
G1 X86.174 Y102.002 E.00549
G1 X86.507 Y101.593 E.00551
G1 X86.624 Y101.407 E.00229
G1 X86.847 Y100.937 E.00544
G1 X86.986 Y100.426 E.00554
G1 X87.035 Y99.92 E.00531
G1 X87.013 Y99.539 E.00399
G1 X86.948 Y99.183 E.00378
G1 X86.78 Y98.69 E.00544
G1 X86.607 Y98.367 E.00382
G1 X86.402 Y98.058 E.00388
G1 X86.055 Y97.672 E.00543
; WIPE_START
G1 X86.402 Y98.058 E-.09862
G1 X86.607 Y98.367 E-.0706
G1 X86.78 Y98.69 E-.0695
G1 X86.948 Y99.183 E-.09895
G1 X86.988 Y99.402 E-.04232
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X85.563 Y96.303 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.683099
G1 F900
M204 S500
G1 X90.223 Y96.297 E.2481
M204 S6000
G1 X90.71 Y96.069 F18000
; LINE_WIDTH: 0.11987
G1 F900
M204 S500
G1 X90.893 Y96.022 E.00121
; WIPE_START
G1 X90.71 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.299 Y95.254 Z.6 F18000
G1 X98.306 Y95.253 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52126
G1 F900
M204 S500
G1 X96.08 Y93.027 E.12523
G1 X95.682 Y93.306 E.01932
G1 X97.76 Y95.384 E.11692
G1 X97.363 Y95.663 E.01932
G1 X95.284 Y93.584 E.11692
G1 X94.886 Y93.863 E.01932
G1 X96.965 Y95.941 E.11692
G1 X96.567 Y96.22 E.01932
G1 X94.488 Y94.141 E.11692
G1 X94.09 Y94.42 E.01932
G1 X96.169 Y96.499 E.11692
G1 X95.771 Y96.777 E.01932
G1 X93.692 Y94.699 E.11692
G1 X93.295 Y94.977 E.01932
G1 X95.373 Y97.056 E.11692
G1 X94.975 Y97.334 E.01932
G1 X92.749 Y95.108 E.12523
; WIPE_START
G1 X94.163 Y96.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X96.876 Y91.49 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.585885
G1 F900
M204 S500
G1 X100.117 Y89.22 E.17865
; LINE_WIDTH: 0.640218
G1 X100.328 Y89.129 E.01141
G1 X100.412 Y89.208 E.0057
; LINE_WIDTH: 0.60916
G1 X100.495 Y89.287 E.00541
; LINE_WIDTH: 0.585854
G1 X102.765 Y92.528 E.17864
; LINE_WIDTH: 0.640207
G1 X102.856 Y92.739 E.01141
G1 X102.777 Y92.823 E.0057
; LINE_WIDTH: 0.609157
G1 X102.698 Y92.906 E.00541
; LINE_WIDTH: 0.585863
G1 X99.457 Y95.176 E.17864
; WIPE_START
G1 X101.095 Y94.029 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X97.881 Y87.106 Z.6 F18000
G1 X94.138 Y79.048 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51198
G1 F900
M204 S500
G1 X94.882 Y79.791 E.04102
G1 X94.882 Y80.455 E.02587
G1 X93.681 Y79.253 E.06627
G1 X93.017 Y79.253 E.02587
G1 X94.882 Y81.118 E.10285
G1 X94.882 Y81.782 E.02587
G1 X92.354 Y79.253 E.13944
G1 X91.987 Y79.253 E.01431
G1 X91.987 Y79.55 E.01157
G1 X94.882 Y82.445 E.15968
M73 P34 R15
G1 X94.882 Y83.108 E.02587
G1 X91.987 Y80.213 E.15968
G1 X91.987 Y80.877 E.02587
G1 X94.882 Y83.772 E.15968
G1 X94.882 Y84.435 E.02587
G1 X91.987 Y81.54 E.15968
G1 X91.987 Y82.203 E.02587
M73 P35 R15
G1 X94.882 Y85.098 E.15968
G1 X94.882 Y85.762 E.02587
G1 X91.987 Y82.867 E.15968
G1 X91.987 Y83.53 E.02587
G1 X94.882 Y86.425 E.15968
G1 X94.882 Y87.088 E.02587
G1 X91.987 Y84.193 E.15968
G1 X91.987 Y84.857 E.02587
G1 X94.882 Y87.752 E.15968
G1 X94.882 Y88.048 E.01157
G1 X94.516 Y88.048 E.0143
G1 X91.987 Y85.52 E.13945
G1 X91.987 Y86.183 E.02587
G1 X93.852 Y88.048 E.10286
G1 X93.189 Y88.048 E.02587
G1 X91.987 Y86.847 E.06627
G1 X91.987 Y87.51 E.02587
G1 X92.731 Y88.254 E.04103
; WIPE_START
G1 X91.987 Y87.51 E-.19987
G1 X91.987 Y86.847 E-.12604
G1 X92.189 Y87.048 E-.05409
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X91.385 Y79.458 Z.6 F18000
G1 X91.249 Y78.179 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.681764
G1 F900
M204 S500
G1 X91.227 Y77.469 E.03774
; LINE_WIDTH: 0.656051
G1 X91.137 Y76.786 E.03515
M204 S6000
G1 X91.371 Y77.02 F18000
; LINE_WIDTH: 0.641799
G1 F900
M204 S500
G1 X90.709 Y76.914 E.03336
; LINE_WIDTH: 0.687412
G1 X90.489 Y76.901 E.0118
G1 X77.939 Y76.905 E.67255
; WIPE_START
G1 X79.939 Y76.904 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X76.84 Y78.01 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.690714
G1 F900
M204 S500
G1 X76.835 Y95.212 E.92654
; WIPE_START
G1 X76.835 Y93.212 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X77.906 Y96.301 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X82.508 Y96.301 E.24604
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X80.508 Y96.301 E-.38
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
G3 Z.6 I.894 J.826 P1  F18000
G1 X91.478 Y84.428 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.1203
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.488 E.08613
M204 S10000
G1 X91.054 Y85.172 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.132 E.17017
G1 X91.228 Y77.074 E.00389
G1 X91.298 Y77.167 E.00246
G1 X91.36 Y77.301 E.00311
G1 X91.398 Y77.444 E.00314
G1 X91.453 Y78.32 E.01858
G1 X95.816 Y78.32 E.09234
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.232 E.07937
; WIPE_START
M204 S6000
G1 X91.054 Y83.232 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.864 Z.72 F18000
G1 X90.895 Y95.42 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.923 Y95.344 E.00172
G1 X91.026 Y95.22 E.00341
G1 X91.122 Y95.165 E.00234
G1 X91.279 Y95.155 E.00332
G1 X92.167 Y95.367 E.01933
G1 X91.367 Y95.83 E.01957
G1 X91.023 Y95.876 E.00734
G1 X90.832 Y95.959 E.00441
G1 X90.888 Y95.48 E.01021
; WIPE_START
M204 S6000
G1 X90.923 Y95.344 E-.02668
G1 X91.026 Y95.22 E-.03064
G1 X91.122 Y95.165 E-.02104
G1 X91.279 Y95.155 E-.02981
G1 X92.167 Y95.367 E-.17348
G1 X91.719 Y95.627 E-.09834
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X99.401 Y89.881 E.05762
G1 X100.307 Y89.247 E.02342
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.636 Y90.217 E.05355
G1 X100.207 Y89.817 E.01372
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X99.053 Y90.644 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.141 Y93.882 Z.72 F18000
G1 X85.262 Y97.103 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01026
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00804
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.045 Y96.544 E.01174
G1 X85.023 Y96.544 E.04185
G1 X85.369 Y96.942 E.01115
G1 X85.295 Y97.053 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09577
G1 X84.428 Y96.88 E-.07222
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07219
G1 X83.32 Y96.946 E-.042
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.509 Y100.751 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.492 Y100.813 E.00137
G1 X86.361 Y101.108 E.00683
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00976
G1 X85.546 Y102.042 E.00986
G1 X85.276 Y102.208 E.00671
G1 X84.984 Y102.344 E.00683
G1 X84.541 Y102.473 E.00975
G1 X84.083 Y102.521 E.00976
G1 X83.761 Y102.507 E.00682
G1 X83.448 Y102.455 E.00671
G1 X83.005 Y102.312 E.00986
G1 X82.59 Y102.089 E.00996
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00974
G1 X81.746 Y101.177 E.00683
G1 X81.608 Y100.892 E.00671
G1 X81.47 Y100.447 E.00986
M73 P36 R15
G1 X81.414 Y99.979 E.00996
G1 X81.442 Y99.51 E.00995
G1 X81.552 Y99.063 E.00975
G1 X81.674 Y98.764 E.00683
G1 X81.828 Y98.487 E.00671
G1 X82.112 Y98.118 E.00986
G1 X82.462 Y97.803 E.00996
G1 X82.862 Y97.556 E.00995
G1 X83.291 Y97.388 E.00975
G1 X83.605 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.789 Y97.953 E.00995
G1 X86.102 Y98.29 E.00975
G1 X86.284 Y98.557 E.00683
G1 X86.429 Y98.835 E.00664
G1 X86.539 Y99.129 E.00663
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.614 Y100.369 E.00995
G1 X86.525 Y100.693 E.00711
M204 S250
G1 X86.115 Y100.642 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.105 Y100.675 E.00067
G1 X85.997 Y100.919 E.00526
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.453 E.00774
G1 X85.305 Y101.71 E.00784
G1 X85.082 Y101.847 E.00515
G1 X84.84 Y101.96 E.00526
G1 X84.462 Y102.07 E.00773
G1 X84.071 Y102.111 E.00774
G1 X83.804 Y102.099 E.00526
G1 X83.545 Y102.056 E.00516
G1 X83.166 Y101.934 E.00784
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.977 E.00526
G1 X81.99 Y100.741 E.00516
G1 X81.872 Y100.361 E.00783
G1 X81.825 Y99.967 E.0078
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00526
G1 X82.171 Y98.713 E.00516
G1 X82.414 Y98.397 E.00783
G1 X82.709 Y98.132 E.0078
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00773
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00527
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00773
G1 X85.514 Y98.258 E.0078
G1 X85.782 Y98.546 E.00773
G1 X85.932 Y98.767 E.00526
G1 X86.054 Y99.002 E.0052
G1 X86.147 Y99.249 E.0052
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.296 E.0078
G1 X86.131 Y100.584 E.00588
; WIPE_START
M204 S6000
G1 X86.105 Y100.675 E-.0179
G1 X85.997 Y100.919 E-.05082
G1 X85.859 Y101.149 E-.05085
G1 X85.61 Y101.453 E-.07473
G1 X85.305 Y101.71 E-.07569
G1 X85.082 Y101.847 E-.0498
G1 X84.84 Y101.96 E-.05083
G1 X84.792 Y101.974 E-.00939
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.277 Y96.12 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.10814
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.944 Y94.778 E.00421
G1 X91.127 Y94.731 E.00399
G1 X91.328 Y94.73 E.00427
G1 X91.844 Y94.854 E.01122
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.219 Y95.827 E.07934
G1 X91.557 Y96.21 E.01618
G1 X91.343 Y96.273 E.00472
G1 X91.129 Y96.293 E.00454
G1 X90.778 Y96.444 E.00809
G1 X90.642 Y96.472 E.00295
G1 X85.534 Y96.485 E.10811
G1 X86.712 Y97.838 E.03797
G1 X86.825 Y97.993 E.00407
G1 X87.119 Y98.517 E.01272
G1 X87.267 Y98.91 E.00888
G1 X87.389 Y99.489 E.01254
G1 X87.41 Y100.091 E.01273
G1 X87.324 Y100.676 E.01253
G1 X87.206 Y101.07 E.0087
G1 X86.954 Y101.606 E.01253
G1 X86.605 Y102.097 E.01275
G1 X86.32 Y102.391 E.00867
G1 X86.009 Y102.644 E.00849
G1 X85.678 Y102.855 E.0083
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00869
G1 X83.725 Y103.266 E.01274
G1 X83.142 Y103.161 E.01253
G1 X82.587 Y102.955 E.01253
G1 X82.227 Y102.756 E.00871
G1 X81.902 Y102.522 E.00848
G1 X81.606 Y102.251 E.00849
G1 X81.338 Y101.94 E.00869
G1 X81.025 Y101.437 E.01253
G1 X80.864 Y101.07 E.00849
G1 X80.747 Y100.686 E.0085
G1 X80.678 Y100.291 E.00849
G1 X80.655 Y99.89 E.00849
G1 X80.68 Y99.49 E.00848
G1 X80.755 Y99.086 E.00871
G1 X80.943 Y98.534 E.01234
G1 X81.132 Y98.17 E.00869
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.323 Y96.453 E.00527
G1 X77.178 Y96.405 E.00324
G1 X76.919 Y96.228 E.00664
G1 X76.769 Y96.033 E.00521
G1 X76.683 Y95.812 E.00501
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00578
G1 X76.796 Y77.125 E.00521
G1 X76.896 Y76.998 E.00343
G1 X77.015 Y76.892 E.00336
G1 X77.235 Y76.775 E.00527
G1 X77.484 Y76.723 E.0054
G1 X90.502 Y76.72 E.27553
G1 X90.746 Y76.749 E.00519
G1 X90.883 Y76.794 E.00306
G1 X91.059 Y76.889 E.00424
G1 X91.01 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.731 Y77.12 E.00553
G1 X77.429 Y77.271 E.00716
G1 X77.212 Y77.488 E.0065
G1 X77.066 Y77.758 E.00649
G1 X77.016 Y78.047 E.0062
G1 X77.016 Y95.155 E.36211
G1 X77.068 Y95.453 E.00639
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.217 Y96.12 E.15354
; WIPE_START
M204 S6000
G1 X87.217 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.032 Y97.582 E.018
G1 X87.167 Y97.767 E.00451
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.0043
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.0043
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00873
G1 X87.723 Y100.771 E.00871
G1 X87.59 Y101.212 E.00905
G1 X87.409 Y101.627 E.00891
G1 X87.304 Y101.819 E.0043
G1 X87.055 Y102.189 E.00877
G1 X86.912 Y102.368 E.00451
G1 X86.597 Y102.693 E.0089
G1 X86.253 Y102.973 E.00871
G1 X86.061 Y103.103 E.00457
G1 X85.871 Y103.216 E.00436
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.00431
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.151 Y103.689 E.0043
G1 X83.688 Y103.674 E.00911
G1 X83.25 Y103.609 E.00871
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.411 Y103.325 E.00872
G1 X82.008 Y103.103 E.00905
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.016 Y102.192 E.00891
G1 X80.889 Y102.014 E.00431
G1 X80.659 Y101.624 E.00891
G1 X80.479 Y101.212 E.00885
G1 X80.349 Y100.781 E.00885
G1 X80.27 Y100.338 E.00885
G1 X80.245 Y99.889 E.00885
G1 X80.273 Y99.44 E.00884
G1 X80.357 Y98.987 E.00905
G1 X80.488 Y98.564 E.00871
G1 X80.572 Y98.362 E.0043
G1 X80.78 Y97.96 E.00891
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.895 Y96.721 E.00277
G1 X76.646 Y96.535 E.00612
G1 X76.547 Y96.429 E.00284
G1 X76.417 Y96.243 E.00447
G1 X76.352 Y96.114 E.00283
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.382 Y77.023 E.00441
G1 X76.456 Y76.895 E.0029
G1 X76.597 Y76.716 E.00448
G1 X76.764 Y76.567 E.00441
G1 X76.887 Y76.486 E.0029
G1 X77.094 Y76.389 E.00448
G1 X77.31 Y76.331 E.00441
G1 X77.46 Y76.313 E.00296
G1 X90.526 Y76.311 E.257
G1 X90.835 Y76.347 E.00611
G1 X91.045 Y76.417 E.00436
G1 X91.241 Y76.522 E.00436
G1 X91.472 Y76.717 E.00595
G1 X91.651 Y76.956 E.00587
G1 X91.746 Y77.16 E.00443
G1 X91.804 Y77.378 E.00444
G1 X91.837 Y77.911 E.0105
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.019 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.672 Y77.607 E.00406
G1 X77.544 Y77.735 E.00356
G1 X77.458 Y77.894 E.00355
G1 X77.425 Y78.083 E.00376
G1 X77.425 Y95.119 E.3351
G1 X77.458 Y95.31 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X90.022 Y95.711 E.23625
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00544
G1 X90.526 Y94.547 E.00543
G1 X90.771 Y94.406 E.00556
G1 X91.084 Y94.322 E.00637
G1 X91.376 Y94.321 E.00575
G1 X91.76 Y94.413 E.00777
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.0744
G1 X91.737 Y96.579 E.00824
G1 X91.615 Y96.628 E.00257
G1 X91.41 Y96.677 E.00415
G1 X91.232 Y96.694 E.00353
G1 X90.902 Y96.836 E.00708
G1 X90.684 Y96.881 E.00438
G1 X86.491 Y96.892 E.08247
; WIPE_START
M204 S6000
G1 X87.032 Y97.582 E-.16667
G1 X87.167 Y97.767 E-.04352
G1 X87.401 Y98.159 E-.08662
G1 X87.495 Y98.356 E-.04157
G1 X87.573 Y98.561 E-.04162
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




G1 X86.037 Y97.654
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.395338
G1 F1500
M204 S6000
G1 X85.912 Y97.538 E.00314
; LINE_WIDTH: 0.431198
G1 X85.787 Y97.422 E.00345
; LINE_WIDTH: 0.467447
G1 X85.66 Y97.303 E.00384
; LINE_WIDTH: 0.469046
G1 X85.498 Y97.339 E.00366
; LINE_WIDTH: 0.435528
G1 X85.337 Y97.375 E.00339
M204 S10000
G1 X86.037 Y97.654 F18000
; LINE_WIDTH: 0.360135
G1 F1500
M204 S6000
G1 X86.407 Y98.064 E.00921
M73 P37 R15
G1 X86.6 Y98.357 E.00586
G1 X86.767 Y98.674 E.00597
G1 X86.904 Y99.025 E.00629
G1 X86.987 Y99.393 E.00629
G1 X87.036 Y99.903 E.00856
G1 X86.982 Y100.451 E.00917
G1 X86.85 Y100.937 E.00841
G1 X86.689 Y101.289 E.00646
G1 X86.493 Y101.61 E.00626
G1 X86.18 Y101.995 E.00828
G1 X85.779 Y102.342 E.00885
G1 X85.465 Y102.537 E.00617
G1 X85.105 Y102.702 E.0066
G1 X84.629 Y102.841 E.00827
G1 X84.107 Y102.899 E.00876
G1 X83.732 Y102.884 E.00627
G1 X83.347 Y102.82 E.0065
G1 X82.843 Y102.652 E.00885
G1 X82.395 Y102.412 E.00849
G1 X81.973 Y102.078 E.00897
G1 X81.642 Y101.709 E.00828
G1 X81.413 Y101.352 E.00707
G1 X81.253 Y101.018 E.00617
G1 X81.105 Y100.54 E.00836
G1 X81.038 Y100.005 E.00899
G1 X81.059 Y99.537 E.00782
G1 X81.128 Y99.18 E.00606
G1 X81.292 Y98.69 E.00863
G1 X81.46 Y98.365 E.0061
G1 X81.663 Y98.073 E.00594
G1 X82.025 Y97.669 E.00905
; LINE_WIDTH: 0.401742
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438138
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473062
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.463 Y96.247 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.144732
G1 F1500
M204 S6000
G1 X77.256 Y96.13 E.0014
G1 X77.081 Y95.991 E.00133
G1 X76.983 Y95.85 E.00102
G1 X76.882 Y95.626 E.00145
; WIPE_START
G1 X76.983 Y95.85 E-.10599
G1 X77.081 Y95.991 E-.07449
G1 X77.256 Y96.13 E-.09704
G1 X77.463 Y96.247 E-.10247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.083 Y95.818 Z.72 F18000
G1 X91.25 Y95.472 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X91.186 Y95.509 E.00125
G1 X91.234 Y95.537 E.00095
; WIPE_START
G1 X91.186 Y95.509 E-.16436
G1 X91.25 Y95.472 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.799 Y95.202 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X94.446 Y95.493 F18000
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X94.954 Y95.582 F18000
; LINE_WIDTH: 0.360612
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.681 Y88.057 Z.72 F18000
G1 X93.435 Y86.601 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.449 Y81.99 Z.72 F18000
G1 X77.539 Y76.955 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0893953
G1 F1500
M204 S6000
G1 X77.431 Y76.991 E.00036
; LINE_WIDTH: 0.128602
G1 X77.226 Y77.084 E.00116
; LINE_WIDTH: 0.15334
G1 X76.998 Y77.318 E.00208
G1 X76.947 Y77.423 E.00074
; LINE_WIDTH: 0.115884
G1 X76.918 Y77.509 E.00041
; LINE_WIDTH: 0.0899267
G1 X76.889 Y77.596 E.00029
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.918 Y77.509 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/49
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-.522 J1.099 P1  F18000
G1 X91.478 Y84.426 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.12025
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.486 E.08618
M204 S10000
G1 X91.054 Y85.17 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17014
G1 X91.25 Y77.085 E.00426
G1 X91.363 Y77.309 E.00532
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.23 E.07941
; WIPE_START
M204 S6000
G1 X91.054 Y83.23 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.862 Z.84 F18000
G1 X90.895 Y95.42 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.923 Y95.344 E.00172
G1 X91.026 Y95.22 E.00341
G1 X91.123 Y95.165 E.00235
G1 X91.28 Y95.155 E.00334
G1 X92.167 Y95.367 E.0193
G1 X91.367 Y95.83 E.01957
G1 X91.023 Y95.876 E.00734
G1 X90.832 Y95.959 E.00441
G1 X90.888 Y95.48 E.01021
; WIPE_START
M204 S6000
G1 X90.923 Y95.344 E-.02668
G1 X91.026 Y95.22 E-.03064
G1 X91.123 Y95.165 E-.02112
G1 X91.28 Y95.155 E-.02997
G1 X92.167 Y95.367 E-.17325
G1 X91.719 Y95.627 E-.09833
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11246
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X99.217 Y90.011 E.05286
G1 X100.307 Y89.247 E.02819
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.451 Y90.346 E.04912
G1 X100.207 Y89.817 E.01814
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X99.05 Y90.641 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.14 Y93.883 Z.84 F18000
G1 X85.251 Y97.114 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01013
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.166 Y96.981 E.00804
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.046 Y96.544 E.01174
G1 X85.022 Y96.544 E.04183
G1 X85.375 Y96.95 E.01138
G1 X85.287 Y97.066 E.00309
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09492
G1 X84.428 Y96.88 E-.0722
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07218
G1 X83.316 Y96.947 E-.04289
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.508 Y100.755 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.492 Y100.813 E.00129
G1 X86.361 Y101.108 E.00683
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00975
G1 X85.551 Y102.039 E.00975
G1 X85.277 Y102.208 E.00682
G1 X84.992 Y102.341 E.00665
G1 X84.542 Y102.473 E.00991
G1 X84.074 Y102.522 E.00997
G1 X83.605 Y102.487 E.00994
G1 X83.15 Y102.369 E.00997
G1 X82.725 Y102.171 E.00992
M73 P38 R15
G1 X82.463 Y101.997 E.00665
G1 X82.217 Y101.789 E.00682
G1 X81.914 Y101.442 E.00975
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00682
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.552 Y99.062 E.00976
G1 X81.674 Y98.764 E.00683
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.462 Y97.803 E.00995
G1 X82.862 Y97.556 E.00995
G1 X83.291 Y97.388 E.00975
G1 X83.605 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X84.992 Y97.462 E.00664
G1 X85.276 Y97.593 E.00663
G1 X85.551 Y97.763 E.00683
G1 X85.895 Y98.055 E.00955
G1 X86.108 Y98.298 E.00683
G1 X86.289 Y98.565 E.00683
G1 X86.489 Y98.98 E.00975
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.524 Y100.697 E.0072
M204 S250
G1 X86.113 Y100.646 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.105 Y100.675 E.00059
G1 X85.997 Y100.919 E.00526
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.452 E.00773
G1 X85.31 Y101.707 E.00773
G1 X85.082 Y101.847 E.00526
G1 X84.847 Y101.957 E.00511
G1 X84.462 Y102.07 E.00788
G1 X84.068 Y102.111 E.0078
G1 X83.673 Y102.082 E.00779
G1 X83.289 Y101.982 E.0078
G1 X82.925 Y101.813 E.00788
G1 X82.709 Y101.669 E.00511
G1 X82.505 Y101.497 E.00526
G1 X82.246 Y101.201 E.00773
G1 X82.044 Y100.863 E.00774
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.189 E.00774
G1 X82.043 Y98.942 E.00526
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.709 Y98.132 E.0078
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00774
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.842 Y97.843 E.0052
G1 X85.082 Y97.954 E.00519
G1 X85.31 Y98.095 E.00526
G1 X85.607 Y98.347 E.00767
G1 X85.783 Y98.549 E.00526
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00774
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.0078
G1 X86.21 Y100.296 E.0078
G1 X86.129 Y100.588 E.00596
; WIPE_START
M204 S6000
G1 X86.105 Y100.675 E-.01712
G1 X85.997 Y100.919 E-.05082
G1 X85.859 Y101.149 E-.05084
G1 X85.61 Y101.452 E-.0747
G1 X85.31 Y101.707 E-.07472
G1 X85.082 Y101.847 E-.05079
G1 X84.847 Y101.957 E-.04935
G1 X84.788 Y101.974 E-.01166
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.276 Y96.12 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.10815
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.944 Y94.778 E.00421
G1 X91.122 Y94.732 E.00389
G1 X91.329 Y94.73 E.00439
G1 X91.844 Y94.854 E.0112
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.219 Y95.827 E.07934
G1 X91.557 Y96.21 E.01619
G1 X91.343 Y96.273 E.00473
G1 X91.129 Y96.293 E.00454
G1 X90.779 Y96.444 E.00809
G1 X90.64 Y96.472 E.00299
G1 X85.533 Y96.485 E.10809
G1 X86.709 Y97.834 E.03788
G1 X86.933 Y98.161 E.00839
G1 X87.196 Y98.703 E.01274
G1 X87.313 Y99.081 E.00839
G1 X87.389 Y99.49 E.0088
G1 X87.415 Y99.899 E.00867
G1 X87.393 Y100.282 E.00812
G1 X87.325 Y100.672 E.00838
G1 X87.205 Y101.071 E.00881
G1 X86.953 Y101.607 E.01254
G1 X86.605 Y102.096 E.01271
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00869
G1 X85.483 Y102.955 E.01273
G1 X85.128 Y103.099 E.00811
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00868
G1 X83.944 Y103.28 E.00811
G1 X83.535 Y103.243 E.00869
G1 X83.142 Y103.161 E.0085
G1 X82.753 Y103.029 E.00869
G1 X82.227 Y102.757 E.01253
G1 X81.901 Y102.522 E.0085
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.935 Y101.249 E.00866
G1 X80.748 Y100.686 E.01255
G1 X80.678 Y100.29 E.0085
G1 X80.655 Y99.89 E.00849
G1 X80.68 Y99.49 E.00847
G1 X80.756 Y99.081 E.00881
G1 X80.943 Y98.534 E.01224
G1 X81.132 Y98.17 E.00869
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.133 Y96.381 E.0045
G1 X77.003 Y96.301 E.00324
G1 X76.824 Y96.119 E.00539
G1 X76.773 Y96.041 E.00196
G1 X76.683 Y95.813 E.00521
G1 X76.654 Y95.565 E.00528
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00596
G1 X76.801 Y77.118 E.0052
G1 X76.896 Y76.998 E.00325
G1 X77.014 Y76.893 E.00333
G1 X77.234 Y76.775 E.00529
G1 X77.484 Y76.723 E.0054
G1 X90.504 Y76.72 E.27558
G1 X90.746 Y76.749 E.00515
G1 X90.883 Y76.794 E.00306
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.731 Y77.12 E.00552
G1 X77.429 Y77.271 E.00717
G1 X77.212 Y77.488 E.00649
G1 X77.066 Y77.758 E.00649
G1 X77.016 Y78.046 E.0062
G1 X77.016 Y95.155 E.36212
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00883
G1 X77.962 Y96.12 E.00834
G1 X85.216 Y96.12 E.15353
; WIPE_START
M204 S6000
G1 X87.216 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.029 Y97.579 E.01791
G1 X87.288 Y97.957 E.00901
G1 X87.498 Y98.362 E.00898
G1 X87.581 Y98.564 E.0043
G1 X87.711 Y98.983 E.00862
G1 X87.796 Y99.44 E.00914
G1 X87.825 Y99.892 E.0089
G1 X87.8 Y100.335 E.00873
G1 X87.724 Y100.766 E.00862
G1 X87.59 Y101.212 E.00915
G1 X87.415 Y101.613 E.00862
G1 X87.303 Y101.819 E.0046
G1 X87.05 Y102.197 E.00896
G1 X86.912 Y102.368 E.00431
G1 X86.597 Y102.693 E.00891
G1 X86.245 Y102.979 E.00891
G1 X86.064 Y103.102 E.0043
G1 X85.665 Y103.322 E.00898
G1 X85.254 Y103.489 E.00873
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X83.925 Y103.689 E.00873
G1 X83.474 Y103.649 E.00891
G1 X83.034 Y103.556 E.00885
G1 X82.605 Y103.41 E.00891
G1 X82.404 Y103.322 E.0043
G1 X82.008 Y103.103 E.00891
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.562 Y101.418 E.0089
G1 X80.475 Y101.201 E.0046
G1 X80.349 Y100.781 E.00862
G1 X80.27 Y100.338 E.00885
G1 X80.245 Y99.889 E.00885
G1 X80.273 Y99.44 E.00884
G1 X80.358 Y98.983 E.00914
G1 X80.488 Y98.564 E.00862
G1 X80.572 Y98.362 E.00431
G1 X80.78 Y97.96 E.00891
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01817
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.954 Y96.751 E.00594
G1 X76.762 Y96.633 E.00442
G1 X76.652 Y96.541 E.00283
G1 X76.499 Y96.369 E.00454
G1 X76.418 Y96.246 E.00289
G1 X76.35 Y96.11 E.003
G1 X76.281 Y95.901 E.00431
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.349 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.597 Y76.716 E.00442
G1 X76.763 Y76.568 E.00438
G1 X76.888 Y76.486 E.00294
G1 X77.094 Y76.389 E.00448
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.528 Y76.311 E.25704
G1 X90.835 Y76.347 E.00608
G1 X91.045 Y76.417 E.00436
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.019 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.608 E.00406
G1 X77.544 Y77.735 E.00355
G1 X77.458 Y77.894 E.00355
G1 X77.425 Y78.082 E.00376
G1 X77.425 Y95.119 E.3351
G1 X77.458 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.761 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X90.022 Y95.711 E.23626
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00543
G1 X90.526 Y94.547 E.00544
G1 X90.771 Y94.406 E.00556
G1 X91.078 Y94.323 E.00626
G1 X91.376 Y94.321 E.00586
G1 X91.76 Y94.413 E.00776
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.0744
G1 X91.737 Y96.579 E.00824
G1 X91.615 Y96.628 E.00257
G1 X91.41 Y96.677 E.00415
G1 X91.232 Y96.694 E.00352
G1 X90.902 Y96.836 E.00708
G1 X90.682 Y96.881 E.00441
G1 X86.491 Y96.892 E.08244
; WIPE_START
M204 S6000
G1 X87.029 Y97.579 E-.16581
G1 X87.288 Y97.957 E-.08705
G1 X87.498 Y98.362 E-.08671
G1 X87.579 Y98.559 E-.04043
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
G1 X86.153 Y97.775
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380166
G1 F1500
M204 S6000
G1 X85.981 Y97.605 E.00428
; LINE_WIDTH: 0.419454
G1 X85.782 Y97.411 E.00544
; LINE_WIDTH: 0.468065
G1 X85.482 Y97.161 E.00863
M204 S10000
G1 X86.153 Y97.775 F18000
; LINE_WIDTH: 0.359903
G1 F1500
M204 S6000
G1 X86.411 Y98.069 E.00652
G1 X86.623 Y98.386 E.00636
G1 X86.835 Y98.835 E.00826
M73 P39 R15
G1 X86.981 Y99.351 E.00895
M73 P39 R14
G1 X87.036 Y99.903 E.00925
G1 X87.012 Y100.235 E.00554
G1 X86.952 Y100.584 E.0059
G1 X86.85 Y100.938 E.00615
G1 X86.689 Y101.289 E.00644
G1 X86.493 Y101.61 E.00626
G1 X86.181 Y101.994 E.00826
G1 X85.779 Y102.342 E.00885
G1 X85.446 Y102.543 E.00648
G1 X85.113 Y102.698 E.00612
G1 X84.63 Y102.841 E.00839
G1 X84.065 Y102.899 E.00948
G1 X83.589 Y102.867 E.00795
G1 X83.244 Y102.79 E.0059
G1 X82.897 Y102.673 E.00609
G1 X82.43 Y102.433 E.00877
G1 X82.143 Y102.226 E.0059
G1 X81.961 Y102.066 E.00403
G1 X81.648 Y101.716 E.00783
G1 X81.453 Y101.418 E.00594
G1 X81.285 Y101.095 E.00607
G1 X81.118 Y100.595 E.00879
G1 X81.038 Y100.005 E.00993
G1 X81.059 Y99.537 E.00781
G1 X81.129 Y99.174 E.00618
G1 X81.232 Y98.837 E.00586
G1 X81.461 Y98.363 E.00878
G1 X81.662 Y98.073 E.00589
G1 X82.025 Y97.669 E.00905
; LINE_WIDTH: 0.401751
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438135
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473049
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.463 Y96.245 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.134217
G1 F1500
M204 S6000
G1 X77.256 Y96.13 E.00128
; LINE_WIDTH: 0.149204
G1 X77.043 Y95.953 E.0017
G1 X76.882 Y95.627 E.00224
; WIPE_START
G1 X77.043 Y95.953 E-.21589
G1 X77.256 Y96.13 E-.16411
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.88 Y95.771 Z.84 F18000
G1 X91.25 Y95.472 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X91.186 Y95.509 E.00125
G1 X91.235 Y95.537 E.00095
; WIPE_START
G1 X91.186 Y95.509 E-.16436
G1 X91.25 Y95.472 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.954 Y95.582 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.446 Y95.493 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X92.799 Y95.202 F18000
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
; WIPE_START
G1 X94.487 Y94.021 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.435 Y86.601 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.449 Y81.99 Z.84 F18000
G1 X77.539 Y76.955 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0893887
G1 F1500
M204 S6000
G1 X77.431 Y76.991 E.00036
; LINE_WIDTH: 0.128548
G1 X77.226 Y77.084 E.00115
; LINE_WIDTH: 0.154252
G1 X77.105 Y77.193 E.00104
G1 X76.971 Y77.37 E.00143
; LINE_WIDTH: 0.122676
G1 X76.93 Y77.483 E.00058
; LINE_WIDTH: 0.0914252
G1 X76.889 Y77.596 E.00039
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.93 Y77.483 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 4/49
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-.524 J1.098 P1  F18000
G1 X91.478 Y84.428 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.12029
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.488 E.08614
M204 S10000
G1 X91.054 Y85.172 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17018
G1 X91.25 Y77.085 E.00426
G1 X91.363 Y77.309 E.00531
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.232 E.07937
; WIPE_START
M204 S6000
G1 X91.054 Y83.232 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.863 Z.96 F18000
G1 X90.895 Y95.42 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.923 Y95.344 E.00172
G1 X91.026 Y95.22 E.00342
G1 X91.123 Y95.165 E.00236
G1 X91.282 Y95.155 E.00336
G1 X92.149 Y95.363 E.01888
G1 X91.403 Y95.812 E.01844
G1 X91.273 Y95.853 E.00287
G1 X91.023 Y95.876 E.00531
G1 X90.832 Y95.959 E.00441
G1 X90.888 Y95.48 E.01021
; WIPE_START
M204 S6000
G1 X90.923 Y95.344 E-.02668
G1 X91.026 Y95.22 E-.03066
G1 X91.123 Y95.165 E-.02119
G1 X91.282 Y95.155 E-.03014
G1 X92.149 Y95.363 E-.16948
G1 X91.69 Y95.639 E-.10185
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X99.032 Y90.14 E.0481
G1 X100.308 Y89.247 E.03295
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.267 Y90.475 E.0447
G1 X100.207 Y89.817 E.02257
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X99.047 Y90.637 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.139 Y93.882 Z.96 F18000
G1 X85.254 Y97.115 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
M73 P40 R14
G1 X84.639 Y96.915 E.0109
G1 X84.262 Y96.864 E.00804
G1 X83.882 Y96.858 E.00804
G1 X83.372 Y96.928 E.0109
G1 X83.008 Y97.034 E.00804
G1 X82.874 Y97.091 E.00308
G1 X82.755 Y96.924 E.00435
G1 X83.102 Y96.544 E.01088
G1 X85.024 Y96.544 E.04068
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02987
G1 X84.639 Y96.915 E-.09783
G1 X84.262 Y96.864 E-.07219
G1 X83.882 Y96.858 E-.0722
G1 X83.372 Y96.928 E-.09788
G1 X83.321 Y96.942 E-.01004
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.495 Y100.789 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.425 Y100.975 E.00422
G1 X86.201 Y101.378 E.00975
G1 X85.902 Y101.741 E.00995
G1 X85.551 Y102.039 E.00975
G1 X85.277 Y102.208 E.00682
G1 X84.994 Y102.34 E.0066
G1 X84.542 Y102.473 E.00997
G1 X84.083 Y102.521 E.00977
G1 X83.761 Y102.507 E.00683
G1 X83.443 Y102.454 E.00683
G1 X83.004 Y102.312 E.00975
G1 X82.59 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.746 Y101.177 E.00682
G1 X81.611 Y100.897 E.0066
G1 X81.47 Y100.447 E.00997
G1 X81.414 Y99.979 E.00997
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.204 E.00682
G1 X81.609 Y98.909 E.0066
G1 X81.825 Y98.49 E.00997
G1 X82.113 Y98.118 E.00997
G1 X82.462 Y97.803 E.00995
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.46 Y97.344 E.00683
G1 X83.908 Y97.283 E.00956
G1 X84.231 Y97.288 E.00683
G1 X84.55 Y97.331 E.00683
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.195 Y98.417 E.00975
G1 X86.361 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00683
G1 X86.516 Y100.733 E.00134
M204 S250
G1 X86.112 Y100.645 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.053 Y100.803 E.00332
G1 X85.861 Y101.146 E.00773
G1 X85.61 Y101.452 E.0078
G1 X85.31 Y101.707 E.00773
G1 X85.082 Y101.847 E.00526
G1 X84.849 Y101.956 E.00506
G1 X84.462 Y102.07 E.00793
G1 X84.071 Y102.111 E.00774
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00526
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.977 E.00526
G1 X81.992 Y100.746 E.00506
G1 X81.872 Y100.361 E.00793
G1 X81.825 Y99.967 E.0078
G1 X81.848 Y99.574 E.00774
G1 X81.904 Y99.313 E.00526
G1 X81.987 Y99.069 E.00506
G1 X82.171 Y98.711 E.00793
G1 X82.414 Y98.397 E.0078
G1 X82.709 Y98.132 E.0078
G1 X83.043 Y97.925 E.00773
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.932 Y97.693 E.00767
G1 X84.2 Y97.697 E.00526
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.859 Y98.653 E.00773
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00773
G1 X86.246 Y99.901 E.0078
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.133 Y100.589 E.00076
; WIPE_START
M204 S6000
G1 X86.053 Y100.803 E-.04343
G1 X85.861 Y101.146 E-.07471
G1 X85.61 Y101.452 E-.07532
G1 X85.31 Y101.707 E-.0747
G1 X85.082 Y101.847 E-.0508
G1 X84.849 Y101.956 E-.04888
G1 X84.788 Y101.974 E-.01216
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.278 Y96.12 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.1081
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.944 Y94.778 E.00421
G1 X91.117 Y94.732 E.00379
G1 X91.33 Y94.731 E.0045
G1 X91.844 Y94.854 E.01119
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.214 Y95.819 E.07955
G1 X91.596 Y96.191 E.01526
G1 X91.484 Y96.239 E.00257
G1 X91.343 Y96.273 E.00307
G1 X91.129 Y96.293 E.00454
G1 X90.779 Y96.444 E.00808
G1 X90.639 Y96.472 E.00303
G1 X85.535 Y96.485 E.10803
G1 X86.712 Y97.838 E.03795
G1 X87.036 Y98.345 E.01273
G1 X87.266 Y98.91 E.01292
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.091 E.01273
G1 X87.326 Y100.668 E.01235
G1 X87.205 Y101.071 E.00891
G1 X86.953 Y101.607 E.01254
G1 X86.604 Y102.097 E.01272
G1 X86.319 Y102.391 E.00867
G1 X86.016 Y102.639 E.00829
G1 X85.678 Y102.855 E.00849
G1 X85.307 Y103.032 E.0087
G1 X84.936 Y103.158 E.0083
G1 X84.74 Y103.207 E.00427
G1 X84.326 Y103.269 E.00885
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.755 Y103.029 E.00886
G1 X82.228 Y102.757 E.01255
G1 X81.902 Y102.522 E.0085
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.934 Y101.248 E.00869
G1 X80.752 Y100.703 E.01215
G1 X80.678 Y100.289 E.0089
G1 X80.655 Y99.89 E.00847
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.871 Y98.712 E.00849
G1 X81.035 Y98.345 E.00849
G1 X81.24 Y98 E.0085
G1 X81.479 Y97.689 E.0083
G1 X82.584 Y96.482 E.03464
G1 X77.571 Y96.482 E.10611
G1 X77.323 Y96.453 E.00528
G1 X77.184 Y96.407 E.00311
G1 X76.922 Y96.229 E.0067
G1 X76.773 Y96.041 E.00508
G1 X76.683 Y95.812 E.0052
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.628 E.37966
G1 X76.69 Y77.356 E.0058
G1 X76.796 Y77.124 E.00539
G1 X76.964 Y76.933 E.00539
G1 X77.096 Y76.84 E.00341
G1 X77.235 Y76.775 E.00325
G1 X77.485 Y76.723 E.00541
G1 X90.505 Y76.72 E.27559
G1 X90.745 Y76.749 E.00512
G1 X90.882 Y76.794 E.00304
G1 X91.058 Y76.89 E.00425
G1 X91.009 Y77.082 E.00419
G1 X77.99 Y77.082 E.27557
G1 X77.741 Y77.118 E.00533
G1 X77.463 Y77.248 E.00649
G1 X77.216 Y77.48 E.00716
G1 X77.066 Y77.758 E.00669
G1 X77.016 Y78.046 E.0062
G1 X77.016 Y95.155 E.36212
G1 X77.068 Y95.452 E.00639
G1 X77.256 Y95.778 E.00796
G1 X77.616 Y96.047 E.00952
G1 X77.972 Y96.12 E.00768
G1 X85.218 Y96.12 E.15338
; WIPE_START
M204 S6000
G1 X87.218 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.036 Y97.588 E.01814
G1 X87.291 Y97.962 E.00891
G1 X87.496 Y98.356 E.00873
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00873
G1 X87.725 Y100.762 E.00853
G1 X87.59 Y101.212 E.00924
G1 X87.417 Y101.609 E.00852
G1 X87.303 Y101.819 E.00469
G1 X87.061 Y102.182 E.00858
G1 X86.912 Y102.368 E.00469
G1 X86.597 Y102.693 E.00891
G1 X86.261 Y102.967 E.00853
G1 X86.061 Y103.103 E.00475
G1 X85.871 Y103.216 E.00436
G1 X85.462 Y103.412 E.00891
G1 X85.051 Y103.551 E.00853
G1 X84.819 Y103.609 E.00469
G1 X84.369 Y103.676 E.00896
G1 X84.15 Y103.689 E.00431
G1 X83.697 Y103.675 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.605 Y103.411 E.00897
G1 X82.388 Y103.313 E.00469
G1 X82.008 Y103.103 E.00853
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.562 Y101.417 E.00891
G1 X80.48 Y101.215 E.0043
G1 X80.354 Y100.8 E.00853
G1 X80.27 Y100.337 E.00923
G1 X80.245 Y99.889 E.00884
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.567 E.00885
G1 X80.671 Y98.156 E.00885
G1 X80.901 Y97.77 E.00886
G1 X81.166 Y97.426 E.00853
G1 X81.655 Y96.891 E.01426
G1 X77.547 Y96.891 E.0808
G1 X77.234 Y96.854 E.00619
G1 X77.027 Y96.786 E.00428
G1 X76.895 Y96.72 E.0029
G1 X76.643 Y96.531 E.0062
G1 X76.499 Y96.369 E.00428
G1 X76.418 Y96.246 E.0029
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35362
G1 X76.264 Y77.381 E.00453
G1 X76.299 Y77.233 E.00297
G1 X76.381 Y77.025 E.0044
G1 X76.456 Y76.894 E.00297
G1 X76.594 Y76.719 E.0044
G1 X76.704 Y76.615 E.00297
G1 X76.89 Y76.484 E.00447
G1 X77.094 Y76.389 E.00443
G1 X77.307 Y76.332 E.00434
G1 X77.46 Y76.313 E.00303
G1 X90.53 Y76.311 E.25706
G1 X90.835 Y76.347 E.00605
G1 X91.045 Y76.417 E.00436
G1 X91.246 Y76.526 E.0045
G1 X91.474 Y76.718 E.00587
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.006
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.02 Y77.491 E.24833
G1 X77.859 Y77.514 E.00319
G1 X77.695 Y77.591 E.00355
G1 X77.545 Y77.732 E.00406
G1 X77.458 Y77.894 E.00362
G1 X77.425 Y78.082 E.00376
G1 X77.425 Y95.119 E.3351
G1 X77.458 Y95.31 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00453
G1 X90.022 Y95.711 E.23619
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00544
G1 X90.526 Y94.547 E.00543
G1 X90.771 Y94.406 E.00556
G1 X91.073 Y94.323 E.00615
G1 X91.376 Y94.321 E.00598
G1 X91.76 Y94.413 E.00776
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.097 Y96.367 E.07447
G1 X91.783 Y96.556 E.00723
G1 X91.613 Y96.628 E.00362
G1 X91.41 Y96.677 E.0041
G1 X91.232 Y96.694 E.00353
G1 X90.902 Y96.836 E.00707
G1 X90.68 Y96.881 E.00445
G1 X86.491 Y96.892 E.08239
; WIPE_START
M204 S6000
G1 X87.036 Y97.588 E-.16794
G1 X87.291 Y97.962 E-.08609
G1 X87.496 Y98.356 E-.08432
M73 P41 R14
G1 X87.573 Y98.561 E-.04166
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




G1 X86.162 Y97.784
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378806
G1 F1500
M204 S6000
G1 X85.985 Y97.609 E.00438
; LINE_WIDTH: 0.419299
G1 X85.783 Y97.411 E.00557
; LINE_WIDTH: 0.46811
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.359733
G1 F1500
M204 S6000
G1 X86.406 Y98.07 E.00627
G1 X86.701 Y98.524 E.00901
G1 X86.848 Y98.874 E.00632
G1 X86.982 Y99.351 E.00826
G1 X87.036 Y99.903 E.00925
G1 X87.012 Y100.235 E.00554
G1 X86.954 Y100.58 E.00583
G1 X86.847 Y100.938 E.00622
G1 X86.622 Y101.41 E.00872
G1 X86.501 Y101.6 E.00374
G1 X86.181 Y101.994 E.00847
G1 X85.79 Y102.333 E.00861
G1 X85.496 Y102.52 E.00581
G1 X85.139 Y102.689 E.00658
G1 X84.629 Y102.836 E.00884
G1 X84.289 Y102.886 E.00573
G1 X83.768 Y102.888 E.00869
G1 X83.365 Y102.822 E.0068
G1 X82.737 Y102.602 E.0111
G1 X82.395 Y102.412 E.00652
G1 X81.974 Y102.078 E.00896
G1 X81.648 Y101.716 E.00811
G1 X81.451 Y101.422 E.0059
G1 X81.256 Y101.024 E.00739
G1 X81.123 Y100.614 E.00718
G1 X81.059 Y100.244 E.00625
G1 X81.037 Y99.891 E.0059
G1 X81.066 Y99.481 E.00685
G1 X81.148 Y99.094 E.00658
G1 X81.267 Y98.75 E.00607
G1 X81.376 Y98.522 E.00422
G1 X81.556 Y98.214 E.00594
; LINE_WIDTH: 0.373507
G1 X81.825 Y97.871 E.00757
G1 X82.207 Y97.491 E.00934
; LINE_WIDTH: 0.432386
G1 X82.439 Y97.299 E.0061
; LINE_WIDTH: 0.477268
G1 X82.643 Y97.132 E.00594
; WIPE_START
G1 X82.439 Y97.299 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.424 Y96.245 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.149899
G1 F1500
M204 S6000
G1 X77.043 Y95.954 E.00297
G1 X76.882 Y95.626 E.00226
; WIPE_START
G1 X77.043 Y95.954 E-.16418
G1 X77.424 Y96.245 E-.21582
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.044 Y95.818 Z.96 F18000
G1 X91.249 Y95.469 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X91.185 Y95.506 E.00125
G1 X91.234 Y95.534 E.00095
; WIPE_START
G1 X91.185 Y95.506 E-.16436
G1 X91.249 Y95.469 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.799 Y95.202 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X94.446 Y95.493 F18000
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X94.954 Y95.582 F18000
; LINE_WIDTH: 0.360622
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.681 Y88.057 Z.96 F18000
G1 X93.435 Y86.601 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.448 Y81.99 Z.96 F18000
G1 X77.536 Y76.956 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0875279
G1 F1500
M204 S6000
G1 X77.431 Y76.989 E.00034
; LINE_WIDTH: 0.11482
G1 X77.308 Y77.033 E.00058
; LINE_WIDTH: 0.148468
G1 X77.147 Y77.153 E.00123
G1 X77.006 Y77.307 E.00128
G1 X76.943 Y77.432 E.00086
; LINE_WIDTH: 0.10307
G1 X76.892 Y77.59 E.00064
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.943 Y77.432 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/49
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.528 J1.096 P1  F18000
G1 X91.478 Y84.432 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.12039
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.492 E.08604
M204 S10000
G1 X91.054 Y85.176 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17028
G1 X91.25 Y77.085 E.00426
G1 X91.363 Y77.309 E.00532
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.236 E.07928
; WIPE_START
M204 S6000
G1 X91.054 Y83.236 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.868 Z1.08 F18000
G1 X90.895 Y95.42 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.923 Y95.344 E.00172
G1 X91.026 Y95.22 E.00342
G1 X91.124 Y95.165 E.00237
G1 X91.283 Y95.156 E.00337
G1 X92.167 Y95.367 E.01925
G1 X91.367 Y95.83 E.01957
G1 X91.023 Y95.876 E.00734
G1 X90.832 Y95.959 E.00441
G1 X90.888 Y95.48 E.01021
; WIPE_START
M204 S6000
G1 X90.923 Y95.344 E-.02665
G1 X91.026 Y95.22 E-.03067
G1 X91.124 Y95.165 E-.02128
G1 X91.283 Y95.156 E-.03028
G1 X92.167 Y95.367 E-.17279
G1 X91.719 Y95.627 E-.09834
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
M73 P42 R14
G1 X98.848 Y90.269 E.04334
G1 X100.307 Y89.247 E.03771
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.083 Y90.604 E.04027
G1 X100.207 Y89.817 E.027
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X99.044 Y90.633 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.135 Y93.877 Z1.08 F18000
G1 X85.263 Y97.104 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.0103
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00805
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.045 Y96.544 E.01174
G1 X85.024 Y96.544 E.04188
G1 X85.37 Y96.942 E.01117
G1 X85.297 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09609
G1 X84.428 Y96.88 E-.07221
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07217
G1 X83.322 Y96.946 E-.04171
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.506 Y100.756 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.486 Y100.826 E.00154
G1 X86.36 Y101.108 E.00654
G1 X86.195 Y101.385 E.00682
G1 X85.902 Y101.741 E.00975
G1 X85.551 Y102.039 E.00975
G1 X85.277 Y102.208 E.00682
G1 X84.997 Y102.338 E.00654
G1 X84.543 Y102.473 E.01002
G1 X84.083 Y102.521 E.00978
G1 X83.761 Y102.507 E.00682
G1 X83.456 Y102.457 E.00654
G1 X83.005 Y102.312 E.01002
G1 X82.59 Y102.089 E.00998
G1 X82.23 Y101.802 E.00975
G1 X82.011 Y101.565 E.00683
G1 X81.821 Y101.304 E.00683
G1 X81.609 Y100.895 E.00975
G1 X81.47 Y100.446 E.00995
G1 X81.415 Y99.989 E.00975
G1 X81.425 Y99.666 E.00683
G1 X81.473 Y99.347 E.00683
G1 X81.609 Y98.907 E.00975
G1 X81.825 Y98.489 E.00995
G1 X82.113 Y98.118 E.00995
G1 X82.462 Y97.803 E.00995
G1 X82.862 Y97.556 E.00995
G1 X83.291 Y97.388 E.00975
G1 X83.606 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.789 Y97.953 E.00995
G1 X86.102 Y98.29 E.00974
G1 X86.277 Y98.545 E.00654
G1 X86.428 Y98.834 E.0069
G1 X86.539 Y99.129 E.00667
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.614 Y100.37 E.00997
G1 X86.522 Y100.698 E.00722
M204 S250
G1 X86.112 Y100.646 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.101 Y100.687 E.00084
G1 X85.997 Y100.919 E.00501
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.452 E.00773
G1 X85.31 Y101.707 E.00773
G1 X85.082 Y101.847 E.00526
G1 X84.851 Y101.955 E.00501
G1 X84.462 Y102.07 E.00798
G1 X84.071 Y102.111 E.00774
G1 X83.804 Y102.099 E.00525
G1 X83.553 Y102.058 E.00501
G1 X83.166 Y101.934 E.00798
G1 X82.817 Y101.746 E.00781
G1 X82.509 Y101.501 E.00773
G1 X82.327 Y101.305 E.00526
G1 X82.17 Y101.088 E.00526
G1 X81.989 Y100.739 E.00773
G1 X81.872 Y100.361 E.0078
G1 X81.825 Y99.97 E.00773
G1 X81.833 Y99.703 E.00526
G1 X81.873 Y99.438 E.00526
G1 X81.989 Y99.062 E.00773
G1 X82.172 Y98.711 E.00779
G1 X82.414 Y98.397 E.00779
G1 X82.709 Y98.132 E.0078
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00773
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.514 Y98.258 E.00779
G1 X85.781 Y98.546 E.00773
G1 X85.925 Y98.756 E.00501
G1 X86.054 Y99.001 E.00545
G1 X86.147 Y99.249 E.00521
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.296 E.0078
G1 X86.128 Y100.588 E.00596
; WIPE_START
M204 S6000
G1 X86.101 Y100.687 E-.01947
G1 X85.997 Y100.919 E-.0484
G1 X85.859 Y101.149 E-.05082
G1 X85.61 Y101.452 E-.07469
G1 X85.31 Y101.707 E-.07472
G1 X85.082 Y101.847 E-.05078
G1 X84.851 Y101.955 E-.04841
G1 X84.787 Y101.974 E-.01271
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.278 Y96.12 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.1081
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.944 Y94.778 E.00421
G1 X91.112 Y94.733 E.00369
G1 X91.33 Y94.731 E.00462
G1 X91.844 Y94.854 E.01117
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.219 Y95.827 E.07934
G1 X91.557 Y96.21 E.01618
G1 X91.343 Y96.273 E.00473
G1 X91.129 Y96.293 E.00454
G1 X90.778 Y96.444 E.0081
G1 X90.645 Y96.472 E.00288
G1 X85.535 Y96.485 E.10815
G1 X86.718 Y97.845 E.03815
G1 X87.035 Y98.345 E.01254
G1 X87.194 Y98.699 E.00821
G1 X87.315 Y99.086 E.00858
G1 X87.389 Y99.49 E.00869
G1 X87.415 Y99.899 E.00869
G1 X87.393 Y100.282 E.00812
G1 X87.327 Y100.664 E.0082
G1 X87.205 Y101.071 E.00901
G1 X86.953 Y101.607 E.01253
G1 X86.725 Y101.947 E.00865
G1 X86.327 Y102.385 E.01254
G1 X86.001 Y102.65 E.00888
G1 X85.678 Y102.855 E.00811
G1 X85.307 Y103.032 E.00869
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01253
G1 X83.151 Y103.164 E.01254
G1 X82.753 Y103.029 E.00888
G1 X82.227 Y102.757 E.01254
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.0085
G1 X81.121 Y101.613 E.00849
G1 X80.934 Y101.248 E.00869
G1 X80.753 Y100.708 E.01205
G1 X80.678 Y100.289 E.009
G1 X80.655 Y99.89 E.00846
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.00849
G1 X80.874 Y98.704 E.00865
G1 X80.953 Y98.514 E.00436
G1 X81.132 Y98.17 E.0082
G1 X81.358 Y97.838 E.0085
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.133 Y96.381 E.0045
G1 X77.003 Y96.301 E.00324
G1 X76.824 Y96.119 E.00539
G1 X76.774 Y96.042 E.00195
G1 X76.683 Y95.813 E.00521
G1 X76.654 Y95.565 E.00528
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.896 Y76.998 E.00326
G1 X77.011 Y76.895 E.00327
G1 X77.235 Y76.775 E.00536
G1 X77.485 Y76.723 E.00541
G1 X90.507 Y76.72 E.27562
G1 X90.745 Y76.749 E.00508
G1 X90.882 Y76.794 E.00304
G1 X91.058 Y76.89 E.00425
G1 X91.009 Y77.082 E.00419
G1 X77.99 Y77.082 E.27557
G1 X77.732 Y77.119 E.00552
G1 X77.429 Y77.271 E.00717
G1 X77.205 Y77.495 E.00669
G1 X77.053 Y77.798 E.00717
G1 X77.016 Y78.056 E.00552
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00795
G1 X77.617 Y96.047 E.00951
G1 X77.972 Y96.12 E.00767
G1 X85.218 Y96.12 E.15339
; WIPE_START
M204 S6000
G1 X87.218 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.0182
G1 X87.167 Y97.767 E.0043
G1 X87.399 Y98.156 E.00891
G1 X87.574 Y98.548 E.00844
G1 X87.714 Y98.994 E.0092
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00873
G1 X87.726 Y100.758 E.00844
G1 X87.59 Y101.212 E.00933
G1 X87.419 Y101.605 E.00843
G1 X87.303 Y101.819 E.00478
G1 X87.051 Y102.195 E.0089
G1 X86.756 Y102.538 E.00891
G1 X86.599 Y102.691 E.0043
G1 X86.246 Y102.979 E.00897
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00437
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.0043
G1 X83.697 Y103.675 E.00892
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.605 Y103.411 E.00897
G1 X82.405 Y103.322 E.0043
G1 X82.008 Y103.103 E.00891
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.562 Y101.417 E.00891
G1 X80.48 Y101.214 E.0043
G1 X80.355 Y100.804 E.00844
G1 X80.27 Y100.337 E.00933
G1 X80.245 Y99.889 E.00884
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.565 E.0089
G1 X80.582 Y98.34 E.00478
G1 X80.78 Y97.96 E.00844
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01817
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.953 Y96.751 E.00595
G1 X76.762 Y96.633 E.00442
G1 X76.652 Y96.541 E.00283
G1 X76.499 Y96.368 E.00454
G1 X76.418 Y96.246 E.00288
G1 X76.349 Y96.107 E.00306
G1 X76.281 Y95.901 E.00425
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.349 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.597 Y76.716 E.00443
G1 X76.761 Y76.57 E.00431
G1 X76.888 Y76.486 E.003
G1 X77.094 Y76.389 E.00448
G1 X77.306 Y76.332 E.00431
G1 X77.46 Y76.313 E.00306
G1 X90.531 Y76.311 E.25709
G1 X90.835 Y76.347 E.00601
G1 X91.045 Y76.417 E.00436
G1 X91.247 Y76.527 E.00453
G1 X91.474 Y76.718 E.00584
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.019 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.672 Y77.607 E.00406
G1 X77.541 Y77.737 E.00362
G1 X77.449 Y77.922 E.00407
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00383
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00452
G1 X90.022 Y95.711 E.23619
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00543
G1 X90.325 Y94.736 E.00544
G1 X90.526 Y94.547 E.00544
G1 X90.771 Y94.406 E.00556
G1 X91.067 Y94.324 E.00604
G1 X91.377 Y94.321 E.00609
G1 X91.76 Y94.413 E.00775
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.0744
G1 X91.737 Y96.579 E.00824
G1 X91.615 Y96.628 E.00257
G1 X91.41 Y96.677 E.00415
G1 X91.232 Y96.694 E.00353
G1 X90.901 Y96.837 E.00708
G1 X90.687 Y96.881 E.00431
G1 X86.491 Y96.892 E.08253
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16854
G1 X87.167 Y97.767 E-.04153
G1 X87.399 Y98.156 E-.08611
M73 P43 R14
G1 X87.574 Y98.548 E-.08155
G1 X87.578 Y98.56 E-.00227
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
M73 P43 R13
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




G1 X86.037 Y97.654
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.395482
G1 F1500
M204 S6000
G1 X85.912 Y97.538 E.00314
; LINE_WIDTH: 0.431438
G1 X85.788 Y97.422 E.00345
; LINE_WIDTH: 0.46763
G1 X85.661 Y97.304 E.0038
; LINE_WIDTH: 0.468447
G1 X85.5 Y97.34 E.00365
; LINE_WIDTH: 0.433641
G1 X85.338 Y97.375 E.00337
M204 S10000
G1 X86.037 Y97.654 F18000
; LINE_WIDTH: 0.360178
G1 F1500
M204 S6000
G1 X86.406 Y98.063 E.0092
G1 X86.602 Y98.36 E.00594
G1 X86.776 Y98.689 E.00621
G1 X86.943 Y99.174 E.00856
G1 X87.008 Y99.536 E.00614
G1 X87.036 Y99.903 E.00614
G1 X86.982 Y100.453 E.00921
G1 X86.849 Y100.939 E.0084
G1 X86.623 Y101.413 E.00877
G1 X86.42 Y101.714 E.00606
G1 X86.183 Y101.996 E.00614
G1 X85.775 Y102.345 E.00895
G1 X85.465 Y102.537 E.00608
G1 X85.119 Y102.696 E.00636
G1 X84.631 Y102.84 E.00849
G1 X84.107 Y102.9 E.0088
G1 X83.732 Y102.884 E.00626
G1 X83.356 Y102.821 E.00636
G1 X82.872 Y102.666 E.00849
G1 X82.395 Y102.412 E.00901
G1 X81.983 Y102.086 E.00876
G1 X81.713 Y101.797 E.0066
G1 X81.494 Y101.492 E.00627
G1 X81.265 Y101.052 E.00827
G1 X81.105 Y100.539 E.00897
G1 X81.039 Y100.018 E.00876
G1 X81.05 Y99.622 E.0066
G1 X81.108 Y99.251 E.00627
G1 X81.255 Y98.777 E.00827
G1 X81.461 Y98.364 E.00771
G1 X81.662 Y98.073 E.00591
G1 X82.025 Y97.669 E.00906
; LINE_WIDTH: 0.401747
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438138
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473055
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.139308
G1 F1500
M204 S6000
G1 X77.257 Y96.128 E.00144
; LINE_WIDTH: 0.148671
G1 X77.042 Y95.954 E.0017
G1 X76.882 Y95.627 E.00223
; WIPE_START
G1 X77.042 Y95.954 E-.21601
G1 X77.257 Y96.128 E-.16399
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.881 Y95.771 Z1.08 F18000
G1 X91.25 Y95.472 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X91.186 Y95.509 E.00125
G1 X91.235 Y95.537 E.00095
; WIPE_START
G1 X91.186 Y95.509 E-.16436
G1 X91.25 Y95.472 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.954 Y95.582 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.360622
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.446 Y95.493 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X92.799 Y95.202 F18000
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
; WIPE_START
G1 X94.487 Y94.021 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.435 Y86.601 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.449 Y81.99 Z1.08 F18000
G1 X77.539 Y76.955 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.089387
G1 F1500
M204 S6000
G1 X77.432 Y76.991 E.00036
; LINE_WIDTH: 0.12846
G1 X77.227 Y77.083 E.00115
; LINE_WIDTH: 0.153837
G1 X77.106 Y77.192 E.00104
G1 X76.97 Y77.369 E.00143
; LINE_WIDTH: 0.120653
G1 X76.929 Y77.487 E.00059
; LINE_WIDTH: 0.0908527
G1 X76.889 Y77.604 E.0004
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.929 Y77.487 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/49
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-.524 J1.098 P1  F18000
G1 X91.478 Y84.433 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.1204
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.493 E.08604
M204 S10000
G1 X91.054 Y85.176 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17028
G1 X91.25 Y77.085 E.00426
G1 X91.363 Y77.309 E.00532
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.236 E.07928
; WIPE_START
M204 S6000
G1 X91.054 Y83.236 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.868 Z1.2 F18000
G1 X90.895 Y95.42 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.923 Y95.344 E.00172
G1 X91.026 Y95.22 E.00341
G1 X91.135 Y95.158 E.00266
G1 X91.284 Y95.156 E.00314
G1 X92.167 Y95.367 E.01922
G1 X91.367 Y95.83 E.01957
G1 X90.839 Y95.894 E.01124
G1 X90.888 Y95.48 E.00881
; WIPE_START
M204 S6000
G1 X90.923 Y95.344 E-.02669
G1 X91.026 Y95.22 E-.03065
G1 X91.135 Y95.158 E-.02387
G1 X91.284 Y95.156 E-.0282
G1 X92.167 Y95.367 E-.17256
G1 X91.72 Y95.626 E-.09802
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
M73 P44 R13
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11246
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X98.664 Y90.398 E.03857
G1 X100.308 Y89.247 E.04247
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.898 Y90.733 E.03585
G1 X100.207 Y89.817 E.03142
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X98.898 Y90.733 E-.34646
G1 X99.043 Y90.632 E-.03354
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.135 Y93.876 Z1.2 F18000
G1 X85.264 Y97.104 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.0103
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.357 Y96.93 E.01157
G1 X82.8 Y97.11 E.01238
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.37 Y96.942 E.01117
G1 X85.297 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09612
G1 X84.428 Y96.88 E-.07219
G1 X83.898 Y96.856 E-.1008
G1 X83.357 Y96.93 E-.10383
G1 X83.321 Y96.941 E-.00706
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.506 Y100.76 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.492 Y100.813 E.00117
G1 X86.361 Y101.107 E.00682
G1 X86.204 Y101.371 E.00649
G1 X85.904 Y101.74 E.01007
G1 X85.551 Y102.039 E.00978
G1 X85.277 Y102.208 E.00682
G1 X84.999 Y102.337 E.00649
G1 X84.543 Y102.473 E.01007
G1 X84.083 Y102.521 E.00978
G1 X83.762 Y102.507 E.00681
G1 X83.459 Y102.457 E.00649
G1 X83.006 Y102.312 E.01007
G1 X82.59 Y102.089 E.00998
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.746 Y101.178 E.00682
G1 X81.613 Y100.902 E.00649
G1 X81.47 Y100.448 E.01007
G1 X81.414 Y99.979 E.00998
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00976
G1 X81.915 Y98.361 E.00683
G1 X82.121 Y98.11 E.00686
G1 X82.469 Y97.8 E.00988
G1 X82.725 Y97.631 E.00649
G1 X83.013 Y97.487 E.00682
G1 X83.451 Y97.345 E.00975
G1 X83.917 Y97.282 E.00995
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00976
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.205 Y98.432 E.00683
G1 X86.425 Y98.826 E.00955
G1 X86.538 Y99.128 E.00682
G1 X86.612 Y99.426 E.00648
G1 X86.657 Y99.899 E.01007
G1 X86.614 Y100.369 E.00998
G1 X86.522 Y100.702 E.00731
M204 S250
G1 X86.112 Y100.651 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.105 Y100.675 E.00048
G1 X85.997 Y100.919 E.00526
G1 X85.868 Y101.136 E.00496
G1 X85.61 Y101.452 E.00803
G1 X85.31 Y101.707 E.00774
G1 X85.082 Y101.847 E.00526
G1 X84.854 Y101.954 E.00496
G1 X84.463 Y102.07 E.00803
G1 X84.071 Y102.111 E.00775
G1 X83.804 Y102.099 E.00525
G1 X83.555 Y102.058 E.00496
G1 X83.166 Y101.934 E.00802
G1 X82.817 Y101.746 E.00781
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.978 E.00526
G1 X81.994 Y100.75 E.00496
G1 X81.872 Y100.361 E.00802
G1 X81.825 Y99.967 E.00781
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.00779
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.417 Y98.395 E.00527
G1 X82.719 Y98.125 E.00797
G1 X82.93 Y97.987 E.00496
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00773
G1 X83.936 Y97.692 E.0078
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.512 Y98.256 E.00773
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.053 Y98.999 E.00767
G1 X86.147 Y99.249 E.00526
G1 X86.207 Y99.494 E.00496
G1 X86.246 Y99.9 E.00803
G1 X86.21 Y100.296 E.0078
G1 X86.128 Y100.593 E.00607
; WIPE_START
M204 S6000
G1 X86.105 Y100.675 E-.01605
G1 X85.997 Y100.919 E-.0508
G1 X85.868 Y101.136 E-.04794
G1 X85.61 Y101.452 E-.07753
G1 X85.31 Y101.707 E-.07477
G1 X85.082 Y101.847 E-.05083
G1 X84.854 Y101.954 E-.04793
G1 X84.782 Y101.975 E-.01415
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.278 Y96.12 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.1081
G1 X90.479 Y95.322 E.01701
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.944 Y94.778 E.00421
G1 X91.108 Y94.734 E.00359
G1 X91.331 Y94.731 E.00473
G1 X91.844 Y94.854 E.01116
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.219 Y95.827 E.07934
G1 X91.557 Y96.21 E.01619
G1 X91.343 Y96.273 E.00473
G1 X91.122 Y96.293 E.0047
G1 X90.835 Y96.425 E.00667
G1 X90.637 Y96.472 E.00432
G1 X85.535 Y96.485 E.10798
G1 X86.718 Y97.845 E.03814
G1 X87.04 Y98.353 E.01273
G1 X87.196 Y98.703 E.00812
G1 X87.31 Y99.069 E.0081
G1 X87.389 Y99.491 E.0091
G1 X87.415 Y99.899 E.00865
G1 X87.393 Y100.282 E.00812
G1 X87.328 Y100.659 E.0081
G1 X87.205 Y101.072 E.00911
G1 X86.948 Y101.615 E.01273
G1 X86.599 Y102.103 E.01269
G1 X86.319 Y102.392 E.00851
G1 X86.023 Y102.634 E.00811
G1 X85.848 Y102.753 E.00447
G1 X85.483 Y102.955 E.00884
G1 X84.944 Y103.156 E.01217
G1 X84.739 Y103.207 E.00447
G1 X84.326 Y103.269 E.00884
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.603 Y102.962 E.01215
G1 X82.226 Y102.756 E.0091
G1 X81.902 Y102.522 E.00846
G1 X81.606 Y102.251 E.00849
G1 X81.338 Y101.94 E.00869
G1 X81.038 Y101.461 E.01196
G1 X80.863 Y101.068 E.0091
G1 X80.747 Y100.686 E.00846
G1 X80.678 Y100.291 E.00849
G1 X80.655 Y99.89 E.00849
G1 X80.68 Y99.491 E.00846
G1 X80.76 Y99.069 E.0091
G1 X80.943 Y98.534 E.01196
G1 X81.132 Y98.17 E.00869
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00627
G1 X76.867 Y96.173 E.00539
G1 X76.769 Y96.033 E.00362
G1 X76.683 Y95.812 E.00501
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.348 E.00579
G1 X76.797 Y77.123 E.00524
G1 X76.964 Y76.932 E.00538
G1 X77.096 Y76.84 E.0034
G1 X77.235 Y76.775 E.00326
G1 X77.485 Y76.723 E.00541
G1 X90.509 Y76.72 E.27565
G1 X90.745 Y76.749 E.00504
G1 X90.881 Y76.794 E.00304
G1 X91.058 Y76.89 E.00425
G1 X91.009 Y77.082 E.00419
G1 X77.99 Y77.082 E.27556
G1 X77.732 Y77.119 E.00551
G1 X77.433 Y77.269 E.00708
G1 X77.207 Y77.493 E.00675
G1 X77.055 Y77.793 E.0071
G1 X77.016 Y78.054 E.00561
G1 X77.016 Y95.155 E.36195
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.616 Y96.047 E.00951
G1 X77.971 Y96.12 E.00768
G1 X85.218 Y96.12 E.15339
; WIPE_START
M204 S6000
G1 X87.218 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01819
G1 X87.167 Y97.767 E.0043
G1 X87.4 Y98.159 E.00897
G1 X87.497 Y98.359 E.00437
G1 X87.581 Y98.564 E.00437
G1 X87.707 Y98.97 E.00835
G1 X87.796 Y99.44 E.00942
G1 X87.825 Y99.892 E.0089
G1 X87.8 Y100.335 E.00873
G1 X87.727 Y100.753 E.00834
G1 X87.59 Y101.212 E.00942
G1 X87.421 Y101.601 E.00834
G1 X87.184 Y102.009 E.00928
G1 X86.91 Y102.37 E.00891
G1 X86.597 Y102.693 E.00885
G1 X86.268 Y102.962 E.00835
G1 X86.063 Y103.102 E.00488
G1 X85.665 Y103.322 E.00895
G1 X85.465 Y103.411 E.00431
G1 X85.06 Y103.549 E.00841
G1 X84.819 Y103.609 E.00488
G1 X84.369 Y103.676 E.00895
G1 X84.15 Y103.689 E.00431
G1 X83.697 Y103.675 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.821 Y103.491 E.00437
G1 X82.428 Y103.332 E.00835
G1 X82.008 Y103.103 E.00942
G1 X81.643 Y102.84 E.00884
G1 X81.311 Y102.536 E.00885
G1 X81.016 Y102.192 E.00891
G1 X80.889 Y102.014 E.00431
G1 X80.673 Y101.649 E.00835
G1 X80.479 Y101.211 E.00942
G1 X80.349 Y100.781 E.00884
G1 X80.27 Y100.338 E.00885
G1 X80.245 Y99.889 E.00885
G1 X80.273 Y99.44 E.00884
G1 X80.362 Y98.97 E.00942
G1 X80.488 Y98.564 E.00835
G1 X80.571 Y98.362 E.00431
G1 X80.78 Y97.96 E.00891
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.648 Y96.537 E.00454
G1 X76.549 Y96.432 E.00283
G1 X76.416 Y96.243 E.00454
G1 X76.352 Y96.114 E.00283
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00449
G1 X76.38 Y77.028 E.00428
G1 X76.456 Y76.894 E.00304
G1 X76.592 Y76.721 E.00433
G1 X76.704 Y76.615 E.00304
G1 X76.89 Y76.484 E.00447
G1 X77.094 Y76.389 E.00443
G1 X77.304 Y76.332 E.00428
G1 X77.46 Y76.313 E.0031
G1 X90.533 Y76.311 E.25713
G1 X90.835 Y76.347 E.00598
G1 X91.045 Y76.417 E.00435
G1 X91.249 Y76.528 E.00456
G1 X91.474 Y76.718 E.00581
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.02 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.674 Y77.606 E.004
G1 X77.542 Y77.737 E.00367
G1 X77.45 Y77.919 E.00401
G1 X77.425 Y78.085 E.00331
G1 X77.425 Y95.119 E.33505
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00453
G1 X90.022 Y95.711 E.23619
G1 X90.078 Y95.227 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00544
M73 P45 R13
G1 X90.526 Y94.547 E.00543
G1 X90.771 Y94.406 E.00556
G1 X91.061 Y94.325 E.00592
G1 X91.377 Y94.321 E.00621
G1 X91.76 Y94.413 E.00775
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.0744
G1 X91.737 Y96.579 E.00824
G1 X91.615 Y96.628 E.00257
G1 X91.41 Y96.677 E.00415
G1 X91.229 Y96.694 E.00358
G1 X90.969 Y96.814 E.00564
G1 X90.684 Y96.881 E.00575
G1 X86.491 Y96.892 E.08247
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16851
G1 X87.167 Y97.767 E-.04157
G1 X87.4 Y98.159 E-.08666
G1 X87.497 Y98.359 E-.04222
G1 X87.579 Y98.559 E-.04104
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




G1 X86.028 Y97.645
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397731
G1 F1500
M204 S6000
G1 X85.906 Y97.532 E.00308
; LINE_WIDTH: 0.432783
G1 X85.785 Y97.419 E.00337
; LINE_WIDTH: 0.468079
G1 X85.661 Y97.304 E.00371
; LINE_WIDTH: 0.46848
G1 X85.5 Y97.34 E.00365
; LINE_WIDTH: 0.433729
G1 X85.338 Y97.375 E.00337
M204 S10000
G1 X86.028 Y97.645 F18000
; LINE_WIDTH: 0.360616
G1 F1500
M204 S6000
G1 X86.298 Y97.936 E.00664
G1 X86.524 Y98.236 E.00627
G1 X86.773 Y98.679 E.00848
G1 X86.939 Y99.161 E.00852
G1 X87.008 Y99.539 E.00642
G1 X87.036 Y99.903 E.00611
G1 X86.982 Y100.451 E.00918
G1 X86.849 Y100.939 E.00846
G1 X86.689 Y101.288 E.00641
G1 X86.504 Y101.595 E.00598
G1 X86.183 Y101.992 E.00854
G1 X85.784 Y102.338 E.00882
G1 X85.318 Y102.61 E.00902
G1 X84.833 Y102.787 E.00862
G1 X84.602 Y102.846 E.00399
G1 X84.082 Y102.895 E.00872
G1 X83.732 Y102.884 E.00585
G1 X83.359 Y102.823 E.00632
G1 X82.845 Y102.653 E.00904
G1 X82.395 Y102.412 E.00853
G1 X81.974 Y102.078 E.00898
G1 X81.641 Y101.708 E.0083
G1 X81.413 Y101.353 E.00706
G1 X81.258 Y101.029 E.00599
G1 X81.105 Y100.542 E.00854
G1 X81.038 Y100.005 E.00903
G1 X81.059 Y99.539 E.0078
G1 X81.132 Y99.164 E.00638
G1 X81.294 Y98.691 E.00835
G1 X81.46 Y98.365 E.00611
G1 X81.66 Y98.071 E.00595
G1 X82.033 Y97.662 E.00924
; LINE_WIDTH: 0.404241
G1 X82.208 Y97.484 E.00472
; LINE_WIDTH: 0.441662
G1 X82.408 Y97.312 E.00547
; LINE_WIDTH: 0.477838
G1 X82.582 Y97.165 E.00514
; WIPE_START
G1 X82.408 Y97.312 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.144844
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00157
G1 X77.06 Y95.967 E.00145
G1 X76.982 Y95.849 E.00085
G1 X76.882 Y95.627 E.00145
; WIPE_START
G1 X76.982 Y95.849 E-.10361
G1 X77.06 Y95.967 E-.06051
G1 X77.247 Y96.123 E-.10353
G1 X77.48 Y96.249 E-.11235
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.112 Y96.218 Z1.2 F18000
G1 X90.59 Y96.197 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.135214
G1 F1500
M204 S6000
G1 X90.842 Y96.146 E.0014
; LINE_WIDTH: 0.0939511
G1 X90.937 Y96.12 E.00033
M204 S10000
G1 X91.255 Y95.469 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X91.192 Y95.506 E.00125
G1 X91.24 Y95.534 E.00095
; WIPE_START
G1 X91.192 Y95.506 E-.16436
G1 X91.255 Y95.469 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.203 Y93.463 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X93.812 Y94.436 E.03592
G1 X93.986 Y94.552 E.00442
G1 X94.42 Y95.007 E.01331
G1 X94.701 Y95.462 E.01132
G1 X95.017 Y96.373 E.0204
G1 X95.047 Y96.828 E.00966
G1 X94.767 Y97.283 E.01131
G1 X94.363 Y97.517 E.00988
G1 X94.563 Y97.802 E.00737
G1 X95.668 Y97.028 E.02855
; WIPE_START
G1 X94.563 Y97.802 E-.2563
G1 X94.363 Y97.517 E-.06612
G1 X94.625 Y97.365 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.301 Y89.849 Z1.2 F18000
G1 X93.009 Y88.195 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X94.706 Y88.195 E.03592
G1 X94.42 Y87.724 E.01166
G1 X93.986 Y87.269 E.01331
G1 X93.304 Y86.814 E.01737
G1 X92.516 Y86.359 E.01926
G1 X92.236 Y85.903 E.01131
G1 X92.266 Y85.448 E.00966
G1 X92.582 Y84.538 E.0204
G1 X92.863 Y84.083 E.01132
G1 X93.297 Y83.627 E.01331
G1 X93.98 Y83.172 E.01737
G1 X94.767 Y82.717 E.01926
G1 X95.028 Y82.293 E.01054
G1 X95.017 Y81.807 E.01029
G1 X94.701 Y80.896 E.0204
G1 X94.42 Y80.441 E.01132
G1 X93.986 Y79.986 E.01331
G1 X93.304 Y79.531 E.01737
G1 X92.571 Y79.107 E.01791
G1 X91.841 Y79.107 E.01544
G1 X91.841 Y80.075 E.02047
; WIPE_START
G1 X91.841 Y79.107 E-.18379
G1 X92.571 Y79.107 E-.13864
G1 X92.833 Y79.259 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.286 Y78.122 Z1.2 F18000
G1 X77.539 Y76.955 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0890713
G1 F1500
M204 S6000
G1 X77.433 Y76.99 E.00035
; LINE_WIDTH: 0.121867
G1 X77.271 Y77.057 E.00084
; LINE_WIDTH: 0.148786
G1 X77.147 Y77.152 E.00096
G1 X76.992 Y77.326 E.00143
G1 X76.947 Y77.423 E.00066
; LINE_WIDTH: 0.115376
G1 X76.918 Y77.513 E.00042
; LINE_WIDTH: 0.0898409
G1 X76.889 Y77.603 E.0003
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.918 Y77.513 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/49
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-.517 J1.102 P1  F18000
G1 X91.478 Y84.34 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.11843
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.4 E.088
M204 S10000
G1 X91.054 Y85.089 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.16842
G1 X91.228 Y77.073 E.00388
G1 X91.294 Y77.161 E.00233
G1 X91.361 Y77.302 E.00329
G1 X91.398 Y77.441 E.00305
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.149 E.08113
; WIPE_START
M204 S6000
G1 X91.054 Y83.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.955 Y90.78 Z1.32 F18000
G1 X90.895 Y95.42 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.967 Y95.276 E.00342
G1 X91.09 Y95.184 E.00325
G1 X91.233 Y95.144 E.00315
G1 X92.137 Y95.36 E.01967
G1 X91.416 Y95.805 E.01792
G1 X91.328 Y95.843 E.00204
G1 X90.838 Y95.903 E.01044
G1 X90.888 Y95.48 E.00903
; WIPE_START
M204 S6000
G1 X90.967 Y95.276 E-.04157
G1 X91.09 Y95.184 E-.02915
G1 X91.233 Y95.144 E-.02823
G1 X92.137 Y95.36 E-.17656
G1 X91.669 Y95.649 E-.10449
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X98.479 Y90.527 E.03381
G1 X100.308 Y89.247 E.04724
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.714 Y90.862 E.03142
G1 X100.207 Y89.817 E.03585
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X98.714 Y90.862 E-.30374
G1 X99.043 Y90.632 E-.07626
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.124 Y93.854 Z1.32 F18000
G1 X85.194 Y97.081 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.954 E.00874
G1 X84.428 Y96.88 E.00805
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00804
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.046 Y96.544 E.01174
G1 X84.957 Y96.544 E.04046
G1 X85.3 Y96.916 E.01069
G1 X85.226 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X84.801 Y96.954 E-.08206
G1 X84.428 Y96.88 E-.07225
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07219
G1 X83.25 Y96.962 E-.05568
; WIPE_END
M73 P46 R13
G1 E-.02 F1800
M204 S10000
G1 X86.505 Y100.764 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.492 Y100.813 E.00107
G1 X86.361 Y101.107 E.00681
G1 X86.206 Y101.368 E.00643
G1 X85.904 Y101.74 E.01013
G1 X85.551 Y102.039 E.00979
G1 X85.277 Y102.208 E.00682
G1 X85.002 Y102.336 E.00643
G1 X84.543 Y102.473 E.01013
G1 X84.083 Y102.521 E.00979
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00683
G1 X83.004 Y102.312 E.00975
G1 X82.591 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.747 Y101.178 E.00681
G1 X81.614 Y100.904 E.00643
G1 X81.47 Y100.448 E.01013
G1 X81.414 Y99.979 E.00998
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.204 E.00682
G1 X81.606 Y98.917 E.00643
G1 X81.824 Y98.491 E.01013
G1 X82.114 Y98.116 E.01002
G1 X82.478 Y97.792 E.01033
G1 X82.863 Y97.556 E.00955
G1 X83.291 Y97.388 E.00973
G1 X83.605 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00684
G1 X84.992 Y97.462 E.00663
G1 X85.276 Y97.593 E.00662
G1 X85.535 Y97.752 E.00643
G1 X85.894 Y98.054 E.00993
G1 X86.108 Y98.298 E.00687
G1 X86.289 Y98.565 E.00683
G1 X86.489 Y98.98 E.00975
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.521 Y100.707 E.00742
M204 S250
G1 X86.111 Y100.656 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.105 Y100.675 E.00039
G1 X85.997 Y100.919 E.00525
G1 X85.869 Y101.134 E.00492
G1 X85.61 Y101.452 E.00807
G1 X85.31 Y101.707 E.00774
G1 X85.082 Y101.847 E.00526
G1 X84.856 Y101.953 E.00491
G1 X84.463 Y102.07 E.00807
G1 X84.071 Y102.111 E.00775
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.977 E.00526
G1 X81.995 Y100.753 E.00491
G1 X81.872 Y100.361 E.00807
G1 X81.825 Y99.967 E.00781
G1 X81.848 Y99.575 E.00773
G1 X81.904 Y99.313 E.00526
G1 X81.984 Y99.076 E.00491
G1 X82.171 Y98.711 E.00807
G1 X82.414 Y98.397 E.00782
G1 X82.723 Y98.122 E.00814
G1 X83.046 Y97.923 E.00745
G1 X83.412 Y97.78 E.00773
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00527
G1 X84.842 Y97.843 E.00519
G1 X85.082 Y97.954 E.0052
G1 X85.295 Y98.085 E.00491
G1 X85.607 Y98.347 E.00801
G1 X85.783 Y98.549 E.00528
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00773
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.127 Y100.598 E.00617
; WIPE_START
M204 S6000
G1 X86.105 Y100.675 E-.01517
G1 X85.997 Y100.919 E-.05076
G1 X85.869 Y101.134 E-.04748
G1 X85.61 Y101.452 E-.078
G1 X85.31 Y101.707 E-.07481
G1 X85.082 Y101.847 E-.05079
G1 X84.856 Y101.953 E-.04746
G1 X84.778 Y101.976 E-.01553
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.205 Y96.12 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.10966
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.924 Y94.79 E.00372
G1 X91.14 Y94.729 E.00474
G1 X91.242 Y94.722 E.00218
G1 X91.844 Y94.854 E.01304
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.21 Y95.814 E.0797
G1 X91.613 Y96.182 E.01484
G1 X91.474 Y96.243 E.00322
G1 X91.121 Y96.296 E.00755
G1 X90.778 Y96.444 E.00791
G1 X90.645 Y96.472 E.00288
G1 X85.48 Y96.485 E.10932
G1 X86.579 Y97.675 E.03428
G1 X86.835 Y98.008 E.00888
G1 X87.108 Y98.497 E.01187
G1 X87.267 Y98.912 E.00939
G1 X87.389 Y99.49 E.0125
G1 X87.41 Y100.091 E.01273
G1 X87.328 Y100.655 E.01207
G1 X87.205 Y101.072 E.00921
G1 X86.952 Y101.608 E.01254
G1 X86.605 Y102.096 E.01268
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00869
G1 X85.511 Y102.941 E.01207
G1 X85.314 Y103.03 E.00456
G1 X84.919 Y103.163 E.00884
G1 X84.326 Y103.269 E.01273
G1 X83.727 Y103.267 E.01269
G1 X83.143 Y103.161 E.01257
G1 X82.586 Y102.955 E.01255
G1 X82.227 Y102.757 E.00869
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.754 Y99.086 E.00889
G1 X80.947 Y98.526 E.01254
G1 X81.132 Y98.17 E.00849
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.334 Y96.454 E.00504
G1 X77.124 Y96.376 E.00474
G1 X77.003 Y96.301 E.00301
G1 X76.861 Y96.165 E.00417
G1 X76.769 Y96.034 E.0034
G1 X76.683 Y95.812 E.00503
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.627 E.37966
G1 X76.691 Y77.356 E.0058
G1 X76.75 Y77.207 E.00339
G1 X76.83 Y77.076 E.00324
G1 X77.009 Y76.895 E.00539
G1 X77.234 Y76.775 E.0054
G1 X77.484 Y76.723 E.00539
G1 X90.51 Y76.72 E.27572
G1 X90.745 Y76.749 E.005
G1 X90.883 Y76.794 E.00307
G1 X91.059 Y76.889 E.00424
G1 X91.01 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.731 Y77.12 E.00553
G1 X77.429 Y77.272 E.00717
G1 X77.212 Y77.488 E.00649
G1 X77.066 Y77.758 E.00649
G1 X77.016 Y78.047 E.0062
G1 X77.016 Y95.155 E.36211
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.145 Y96.12 E.15183
; WIPE_START
M204 S6000
G1 X87.145 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.413 Y96.892 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01389
G1 X87.17 Y97.772 E.00897
G1 X87.288 Y97.957 E.00431
G1 X87.482 Y98.329 E.00825
G1 X87.656 Y98.784 E.00957
G1 X87.714 Y98.994 E.0043
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00873
G1 X87.728 Y100.748 E.00825
G1 X87.59 Y101.212 E.00952
G1 X87.423 Y101.597 E.00825
G1 X87.303 Y101.819 E.00497
G1 X87.05 Y102.197 E.00896
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.693 E.00891
G1 X86.245 Y102.979 E.00891
G1 X86.064 Y103.102 E.00431
G1 X85.694 Y103.307 E.00831
G1 X85.464 Y103.411 E.00497
G1 X85.033 Y103.557 E.00896
G1 X84.82 Y103.609 E.00431
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.695 Y103.675 E.00896
G1 X83.445 Y103.644 E.00497
G1 X83.034 Y103.556 E.00826
G1 X82.605 Y103.411 E.00891
G1 X82.404 Y103.322 E.00431
G1 X82.008 Y103.103 E.00891
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.355 Y98.994 E.00897
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01817
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00612
G1 X76.943 Y96.746 E.00618
G1 X76.763 Y96.634 E.00418
G1 X76.65 Y96.539 E.00288
G1 X76.542 Y96.423 E.00313
G1 X76.417 Y96.243 E.0043
G1 X76.352 Y96.114 E.00284
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35363
G1 X76.264 Y77.385 E.00443
G1 X76.299 Y77.233 E.00307
G1 X76.383 Y77.022 E.00447
G1 X76.501 Y76.831 E.00442
G1 X76.652 Y76.661 E.00448
G1 X76.765 Y76.566 E.00289
G1 X76.887 Y76.486 E.00289
G1 X77.094 Y76.389 E.00448
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.535 Y76.311 E.25717
G1 X90.835 Y76.347 E.00594
G1 X91.045 Y76.417 E.00437
G1 X91.241 Y76.522 E.00436
G1 X91.472 Y76.717 E.00595
G1 X91.646 Y76.949 E.00571
G1 X91.746 Y77.16 E.0046
G1 X91.804 Y77.375 E.00436
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.02 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.608 E.00406
G1 X77.544 Y77.735 E.00355
G1 X77.458 Y77.894 E.00356
G1 X77.425 Y78.082 E.00376
G1 X77.425 Y95.119 E.3351
G1 X77.458 Y95.31 E.00382
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X90.022 Y95.711 E.23619
G1 X90.078 Y95.227 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00544
G1 X90.526 Y94.547 E.00544
G1 X90.764 Y94.41 E.0054
G1 X91.068 Y94.324 E.00621
G1 X91.369 Y94.319 E.00592
G1 X91.76 Y94.413 E.0079
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.096 Y96.365 E.07451
G1 X91.803 Y96.546 E.00677
G1 X91.61 Y96.63 E.00415
G1 X91.484 Y96.664 E.00257
G1 X91.229 Y96.695 E.00504
G1 X90.901 Y96.837 E.00702
G1 X90.687 Y96.881 E.00431
G1 X86.473 Y96.892 E.08289
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12678
G1 X87.17 Y97.772 E-.08665
G1 X87.288 Y97.957 E-.04162
G1 X87.482 Y98.329 E-.07973
G1 X87.567 Y98.551 E-.04522
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




G1 X86.151 Y97.773
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.35978
G1 F1500
M204 S6000
G1 X86.398 Y98.061 E.00633
M73 P47 R13
G1 X86.623 Y98.386 E.00659
G1 X86.846 Y98.861 E.00874
G1 X86.985 Y99.38 E.00896
G1 X87.031 Y99.915 E.00895
G1 X86.985 Y100.421 E.00847
G1 X86.848 Y100.942 E.00897
G1 X86.712 Y101.252 E.00563
G1 X86.508 Y101.594 E.00665
G1 X86.16 Y102.012 E.00906
G1 X85.779 Y102.342 E.0084
G1 X85.447 Y102.543 E.00647
G1 X85.147 Y102.686 E.00553
G1 X84.631 Y102.836 E.00896
G1 X84.29 Y102.886 E.00574
G1 X83.759 Y102.887 E.00884
G1 X83.244 Y102.791 E.00873
G1 X82.843 Y102.651 E.00707
G1 X82.431 Y102.435 E.00776
G1 X82.144 Y102.224 E.00593
M73 P47 R12
G1 X81.881 Y101.985 E.00593
G1 X81.61 Y101.665 E.00697
G1 X81.45 Y101.42 E.00489
G1 X81.288 Y101.103 E.00593
G1 X81.168 Y100.768 E.00593
G1 X81.083 Y100.422 E.00593
G1 X81.039 Y100.005 E.00699
G1 X81.058 Y99.548 E.00763
G1 X81.168 Y99.023 E.00893
G1 X81.297 Y98.682 E.00609
G1 X81.498 Y98.302 E.00716
G1 X81.828 Y97.871 E.00905
G1 X82.034 Y97.66 E.0049
; LINE_WIDTH: 0.405553
G1 X82.219 Y97.473 E.005
; LINE_WIDTH: 0.441998
G1 X82.408 Y97.311 E.00516
; LINE_WIDTH: 0.473926
G1 X82.57 Y97.174 E.00476
; WIPE_START
G1 X82.408 Y97.311 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.416 Y97.128 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.480465
G1 F1500
M204 S6000
G1 X85.588 Y97.265 E.005
; LINE_WIDTH: 0.449436
G1 X85.761 Y97.403 E.00466
; LINE_WIDTH: 0.412651
G1 X85.969 Y97.6 E.00554
; LINE_WIDTH: 0.378185
G1 X86.151 Y97.773 E.00442
; WIPE_START
G1 X85.969 Y97.6 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.59 Y96.203 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.12713
G1 F1500
M204 S6000
G1 X90.803 Y96.16 E.0011
; LINE_WIDTH: 0.0931803
G1 X90.907 Y96.132 E.00036
; WIPE_START
G1 X90.803 Y96.16 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.479 Y96.254 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X94.452 Y97.644 E.03592
G1 X95.007 Y97.457 E.0124
G1 X95.05 Y97.46 E.00092
G1 X95.589 Y97.083 E.01393
G1 X95.462 Y97.073 E.0027
G1 X95.007 Y95.967 E.0253
G1 X94.552 Y95.155 E.0197
G1 X94.097 Y94.672 E.01405
G1 X93.783 Y94.457 E.00806
G1 X95.173 Y93.483 E.03592
; WIPE_START
G1 X93.783 Y94.457 E-.32243
G1 X94.033 Y94.628 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.995 Y87.057 Z1.32 F18000
G1 X95.028 Y86.793 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X95.028 Y88.195 E.02966
G1 X94.733 Y88.195 E.00626
G1 X94.552 Y87.872 E.00782
G1 X94.097 Y87.389 E.01405
G1 X93.642 Y87.076 E.01169
G1 X92.731 Y86.675 E.02106
G1 X92.276 Y86.532 E.0101
G1 X91.841 Y86.567 E.00923
G1 X91.841 Y86.099 E.00992
G1 X92.276 Y85.043 E.02417
G1 X92.731 Y84.231 E.0197
G1 X93.186 Y83.748 E.01405
G1 X93.642 Y83.435 E.01169
G1 X94.552 Y83.033 E.02106
G1 X95.028 Y82.892 E.01052
G1 X95.028 Y81.453 E.03047
G1 X94.552 Y80.589 E.02088
G1 X94.097 Y80.106 E.01405
G1 X93.642 Y79.793 E.01169
G1 X92.731 Y79.392 E.02106
G1 X92.276 Y79.249 E.0101
G1 X91.841 Y79.284 E.00923
G1 X91.841 Y80.981 E.03592
; WIPE_START
G1 X91.841 Y79.284 E-.32243
G1 X92.143 Y79.26 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.604 Y78.07 Z1.32 F18000
G1 X77.539 Y76.955 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0894027
G1 F1500
M204 S6000
G1 X77.431 Y76.991 E.00036
; LINE_WIDTH: 0.124312
G1 X77.263 Y77.058 E.00089
; LINE_WIDTH: 0.1512
G1 X77.138 Y77.16 E.00101
G1 X76.999 Y77.319 E.00132
G1 X76.943 Y77.432 E.00079
; LINE_WIDTH: 0.102969
G1 X76.891 Y77.59 E.00064
; WIPE_START
G1 X76.943 Y77.432 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.918 Y85.065 Z1.32 F18000
G1 X76.882 Y95.626 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.146189
G1 F1500
M204 S6000
G1 X76.982 Y95.848 E.00146
G1 X77.047 Y95.949 E.00072
G1 X77.129 Y96.037 E.00072
G1 X77.25 Y96.124 E.00089
; LINE_WIDTH: 0.139337
G1 X77.48 Y96.249 E.00149
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.25 Y96.124 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/49
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I.773 J.94 P1  F18000
G1 X91.478 Y84.433 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.1204
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.493 E.08603
M204 S10000
G1 X91.054 Y85.176 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17028
G1 X91.25 Y77.085 E.00426
G1 X91.363 Y77.309 E.00532
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.236 E.07927
; WIPE_START
M204 S6000
G1 X91.054 Y83.236 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.868 Z1.44 F18000
G1 X90.895 Y95.42 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.967 Y95.276 E.00342
G1 X91.091 Y95.183 E.00327
G1 X91.246 Y95.147 E.00337
G1 X92.136 Y95.36 E.01936
G1 X91.416 Y95.805 E.01791
G1 X91.328 Y95.843 E.00203
G1 X90.838 Y95.903 E.01044
G1 X90.888 Y95.48 E.00902
; WIPE_START
M204 S6000
G1 X90.967 Y95.276 E-.04157
G1 X91.091 Y95.183 E-.02938
G1 X91.246 Y95.147 E-.03029
G1 X92.136 Y95.36 E-.1738
G1 X91.666 Y95.651 E-.10496
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11246
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X98.295 Y90.656 E.02905
G1 X100.308 Y89.247 E.052
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.53 Y90.991 E.027
G1 X100.207 Y89.817 E.04027
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X98.53 Y90.991 E-.26102
G1 X99.043 Y90.632 E-.11898
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.136 Y93.88 Z1.44 F18000
G1 X85.254 Y97.115 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01018
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01124
G1 X83.008 Y97.034 E.00803
G1 X82.807 Y97.12 E.00462
G1 X82.687 Y96.956 E.00429
G1 X83.045 Y96.544 E.01155
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09542
G1 X84.428 Y96.88 E-.07221
G1 X83.898 Y96.856 E-.10079
G1 X83.372 Y96.928 E-.10088
G1 X83.318 Y96.943 E-.0107
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.504 Y100.769 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.492 Y100.813 E.00097
G1 X86.361 Y101.107 E.00681
G1 X86.207 Y101.366 E.00638
G1 X85.904 Y101.74 E.01018
G1 X85.551 Y102.039 E.00979
G1 X85.277 Y102.208 E.00681
G1 X85.004 Y102.335 E.00638
G1 X84.543 Y102.473 E.01018
G1 X84.074 Y102.522 E.00999
G1 X83.615 Y102.488 E.00975
G1 X83.3 Y102.416 E.00683
G1 X82.996 Y102.307 E.00683
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00976
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.462 Y97.803 E.00975
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.46 Y97.344 E.00683
G1 X83.917 Y97.282 E.00976
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X84.992 Y97.462 E.00663
G1 X85.276 Y97.593 E.00663
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.202 Y98.426 E.00999
G1 X86.434 Y98.847 E.01018
G1 X86.539 Y99.129 E.00638
G1 X86.615 Y99.442 E.00681
G1 X86.656 Y99.901 E.00975
G1 X86.614 Y100.369 E.00995
G1 X86.52 Y100.711 E.00752
M204 S250
G1 X86.109 Y100.66 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.105 Y100.675 E.0003
G1 X85.997 Y100.919 E.00526
G1 X85.87 Y101.132 E.00486
G1 X85.61 Y101.452 E.00812
G1 X85.31 Y101.707 E.00774
G1 X85.082 Y101.847 E.00526
G1 X84.858 Y101.952 E.00487
G1 X84.463 Y102.07 E.00812
G1 X84.068 Y102.111 E.00781
G1 X83.676 Y102.082 E.00773
G1 X83.415 Y102.023 E.00526
G1 X83.163 Y101.932 E.00526
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.863 E.00773
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.00779
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.709 Y98.132 E.00773
G1 X83.043 Y97.925 E.00774
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00774
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.842 Y97.843 E.0052
G1 X85.082 Y97.954 E.0052
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.862 Y98.656 E.00781
G1 X86.061 Y99.018 E.00812
G1 X86.147 Y99.25 E.00487
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.295 E.00779
G1 X86.125 Y100.602 E.00626
; WIPE_START
M204 S6000
G1 X86.105 Y100.675 E-.01425
G1 X85.997 Y100.919 E-.05078
G1 X85.87 Y101.132 E-.04698
G1 X85.61 Y101.452 E-.07845
G1 X85.31 Y101.707 E-.07481
G1 X85.082 Y101.847 E-.05079
G1 X84.858 Y101.952 E-.047
G1 X84.773 Y101.977 E-.01693
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.278 Y96.12 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.1081
M73 P48 R12
G1 X90.479 Y95.322 E.01701
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.925 Y94.789 E.00374
G1 X91.135 Y94.73 E.00462
G1 X91.243 Y94.722 E.00229
G1 X91.844 Y94.854 E.01303
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.209 Y95.813 E.07971
G1 X91.613 Y96.182 E.01484
G1 X91.474 Y96.243 E.00321
G1 X91.121 Y96.296 E.00755
G1 X90.778 Y96.444 E.00791
G1 X90.645 Y96.472 E.00287
G1 X85.535 Y96.485 E.10816
G1 X86.718 Y97.845 E.03814
G1 X86.83 Y98 E.00405
G1 X87.106 Y98.494 E.01197
G1 X87.264 Y98.903 E.00929
G1 X87.389 Y99.48 E.01249
G1 X87.41 Y100.091 E.01292
G1 X87.329 Y100.651 E.01198
G1 X87.205 Y101.072 E.00931
G1 X86.952 Y101.608 E.01253
G1 X86.605 Y102.096 E.01268
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00869
G1 X85.514 Y102.939 E.01199
G1 X85.313 Y103.03 E.00468
G1 X84.953 Y103.153 E.00806
G1 X84.739 Y103.207 E.00467
G1 X84.326 Y103.269 E.00882
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01273
G1 X82.611 Y102.965 E.01198
G1 X82.226 Y102.755 E.00929
G1 X81.902 Y102.522 E.00845
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.866 Y101.078 E.01255
G1 X80.757 Y100.72 E.00791
G1 X80.678 Y100.289 E.00929
G1 X80.655 Y99.89 E.00845
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.944 Y98.533 E.01255
G1 X81.115 Y98.201 E.00791
G1 X81.359 Y97.836 E.00929
G1 X82.538 Y96.482 E.038
G1 X77.571 Y96.482 E.10513
G1 X77.334 Y96.454 E.00504
G1 X77.123 Y96.376 E.00478
G1 X77.003 Y96.301 E.00298
G1 X76.824 Y96.119 E.00542
G1 X76.774 Y96.042 E.00193
G1 X76.683 Y95.813 E.00522
G1 X76.654 Y95.565 E.0053
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00578
G1 X76.75 Y77.207 E.00324
G1 X76.834 Y77.07 E.00339
G1 X77.016 Y76.891 E.00542
G1 X77.234 Y76.775 E.00522
G1 X77.484 Y76.723 E.00539
G1 X90.512 Y76.721 E.27575
G1 X90.745 Y76.749 E.00497
G1 X90.883 Y76.794 E.00307
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.741 Y77.118 E.00533
G1 X77.463 Y77.248 E.00649
G1 X77.21 Y77.486 E.00734
G1 X77.056 Y77.791 E.00724
G1 X77.016 Y78.054 E.00563
G1 X77.016 Y95.155 E.36196
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.218 Y96.12 E.15358
; WIPE_START
M204 S6000
G1 X87.218 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01819
G1 X87.288 Y97.957 E.00873
G1 X87.48 Y98.325 E.00816
G1 X87.655 Y98.781 E.0096
G1 X87.763 Y99.22 E.0089
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.335 E.00873
G1 X87.728 Y100.744 E.00816
G1 X87.59 Y101.212 E.00961
G1 X87.425 Y101.593 E.00815
G1 X87.303 Y101.819 E.00506
G1 X87.05 Y102.197 E.00895
G1 X86.912 Y102.368 E.00431
G1 X86.597 Y102.693 E.00891
G1 X86.246 Y102.979 E.00891
G1 X86.064 Y103.102 E.00431
G1 X85.698 Y103.305 E.00823
G1 X85.464 Y103.411 E.00506
G1 X85.069 Y103.546 E.00821
G1 X84.819 Y103.609 E.00506
G1 X84.369 Y103.676 E.00895
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.034 Y103.556 E.00436
G1 X82.821 Y103.491 E.00437
G1 X82.436 Y103.336 E.00816
G1 X82.007 Y103.103 E.0096
G1 X81.643 Y102.84 E.00884
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.562 Y101.417 E.00891
G1 X80.48 Y101.214 E.00431
G1 X80.359 Y100.817 E.00816
G1 X80.27 Y100.337 E.0096
G1 X80.245 Y99.889 E.00884
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.564 E.00891
G1 X80.572 Y98.361 E.00431
G1 X80.762 Y97.993 E.00816
G1 X81.034 Y97.587 E.00961
G1 X81.639 Y96.891 E.01815
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00612
G1 X76.942 Y96.745 E.00622
G1 X76.763 Y96.634 E.00415
G1 X76.652 Y96.541 E.00284
G1 X76.499 Y96.368 E.00454
G1 X76.418 Y96.246 E.00287
G1 X76.347 Y96.102 E.00316
G1 X76.281 Y95.902 E.00415
G1 X76.245 Y95.589 E.0062
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.383 Y77.022 E.00442
G1 X76.502 Y76.829 E.00447
G1 X76.604 Y76.709 E.0031
G1 X76.767 Y76.565 E.00428
G1 X76.887 Y76.486 E.00284
G1 X77.094 Y76.389 E.00448
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.536 Y76.311 E.2572
G1 X90.835 Y76.347 E.00591
G1 X91.046 Y76.417 E.00437
G1 X91.241 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.019 Y77.491 E.24833
G1 X77.859 Y77.514 E.00319
G1 X77.695 Y77.591 E.00356
G1 X77.543 Y77.734 E.00412
G1 X77.45 Y77.918 E.00404
G1 X77.425 Y78.085 E.00333
G1 X77.425 Y95.119 E.33505
G1 X77.458 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X90.022 Y95.711 E.23625
G1 X90.078 Y95.227 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00543
G1 X90.526 Y94.547 E.00544
G1 X90.765 Y94.409 E.00541
G1 X91.063 Y94.325 E.00609
G1 X91.369 Y94.319 E.00603
G1 X91.76 Y94.413 E.0079
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.096 Y96.365 E.07452
G1 X91.803 Y96.546 E.00677
G1 X91.61 Y96.63 E.00415
G1 X91.484 Y96.664 E.00257
G1 X91.229 Y96.695 E.00504
G1 X90.901 Y96.837 E.00702
G1 X90.687 Y96.881 E.0043
G1 X86.491 Y96.892 E.08253
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16851
G1 X87.288 Y97.957 E-.08436
G1 X87.48 Y98.325 E-.07883
G1 X87.571 Y98.562 E-.04829
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




G1 X86.162 Y97.784
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360288
G1 F1500
M204 S6000
G1 X86.506 Y98.202 E.00902
G1 X86.759 Y98.65 E.0086
G1 X86.901 Y99.015 E.00653
G1 X86.983 Y99.369 E.00606
G1 X87.036 Y99.903 E.00897
G1 X87.012 Y100.235 E.00555
G1 X86.957 Y100.564 E.00556
G1 X86.849 Y100.94 E.00654
G1 X86.623 Y101.412 E.00873
G1 X86.313 Y101.845 E.00888
G1 X86.06 Y102.109 E.0061
G1 X85.779 Y102.342 E.0061
G1 X85.447 Y102.543 E.00648
G1 X85.127 Y102.693 E.0059
G1 X84.633 Y102.84 E.00861
G1 X84.065 Y102.9 E.00953
G1 X83.571 Y102.862 E.00827
G1 X83.185 Y102.776 E.0066
G1 X82.831 Y102.647 E.00627
G1 X82.395 Y102.412 E.00827
G1 X81.974 Y102.078 E.00897
G1 X81.648 Y101.716 E.00813
G1 X81.453 Y101.418 E.00594
G1 X81.284 Y101.094 E.0061
G1 X81.103 Y100.521 E.01002
G1 X81.038 Y100.005 E.00868
G1 X81.059 Y99.536 E.00784
G1 X81.126 Y99.186 E.00594
G1 X81.232 Y98.837 E.0061
G1 X81.444 Y98.392 E.00821
G1 X81.662 Y98.068 E.00653
G1 X82.029 Y97.664 E.00911
; LINE_WIDTH: 0.402119
G1 X82.203 Y97.487 E.00466
; LINE_WIDTH: 0.438794
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.475192
G1 X82.578 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
M73 P49 R12
G1 E-.02 F1800
M204 S10000
G1 X85.484 Y97.162 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.46813
G1 F1500
M204 S6000
G1 X85.782 Y97.411 E.00857
; LINE_WIDTH: 0.419312
G1 X85.985 Y97.609 E.00557
; LINE_WIDTH: 0.378821
G1 X86.162 Y97.784 E.00438
; WIPE_START
G1 X85.985 Y97.609 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.59 Y96.203 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.127211
G1 F1500
M204 S6000
G1 X90.803 Y96.16 E.0011
; LINE_WIDTH: 0.0932066
G1 X90.908 Y96.132 E.00036
; WIPE_START
G1 X90.803 Y96.16 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.703 Y97.684 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.378297
G1 F1200
M204 S6000
G1 X94.638 Y97.712 E.00124
; LINE_WIDTH: 0.395023
G1 X94.574 Y97.74 E.0013
G1 X94.471 Y97.643 E.0026
; LINE_WIDTH: 0.365752
G1 X92.852 Y95.331 E.04788
; LINE_WIDTH: 0.378297
G1 X92.824 Y95.266 E.00124
; LINE_WIDTH: 0.395023
G1 X92.796 Y95.202 E.0013
G1 X92.893 Y95.099 E.0026
; LINE_WIDTH: 0.365752
G1 X96.352 Y92.677 E.07163
; LINE_WIDTH: 0.378297
G1 X96.417 Y92.649 E.00124
; LINE_WIDTH: 0.395023
G1 X96.481 Y92.621 E.0013
G1 X96.584 Y92.718 E.0026
; LINE_WIDTH: 0.365752
G1 X98.203 Y95.03 E.04788
; LINE_WIDTH: 0.378302
G1 X98.231 Y95.095 E.00124
; LINE_WIDTH: 0.395688
G1 X98.259 Y95.16 E.0013
G1 X98.185 Y95.245 E.00207
; LINE_WIDTH: 0.365752
G1 X94.752 Y97.65 E.0711
; WIPE_START
G1 X96.39 Y96.502 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.969 Y95.636 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.579 Y96.609 E.03592
G1 X95.462 Y96.534 E.00293
G1 X95.007 Y95.774 E.01875
G1 X94.552 Y95.11 E.01702
G1 X94.117 Y94.704 E.0126
G1 X95.507 Y93.731 E.03592
; WIPE_START
G1 X94.117 Y94.704 E-.32243
G1 X94.338 Y94.911 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.598 Y87.283 Z1.44 F18000
G1 X94.634 Y86.231 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X94.634 Y87.8 E.03321
G1 X94.506 Y87.8 E.00271
G1 X94.139 Y87.434 E.01096
G1 X93.642 Y87.128 E.01237
G1 X92.731 Y86.826 E.0203
G1 X92.276 Y86.813 E.00964
G1 X92.235 Y86.839 E.00102
G1 X92.235 Y84.917 E.04069
G1 X92.276 Y84.849 E.00167
G1 X92.731 Y84.186 E.01702
G1 X93.186 Y83.761 E.01318
G1 X93.642 Y83.486 E.01126
G1 X94.139 Y83.287 E.01134
G1 X94.634 Y83.173 E.01075
G1 X94.634 Y80.645 E.0535
G1 X94.139 Y80.151 E.01479
G1 X93.642 Y79.844 E.01237
G1 X92.731 Y79.543 E.0203
G1 X92.276 Y79.529 E.00964
G1 X92.235 Y79.556 E.00102
G1 X92.235 Y81.253 E.03592
; WIPE_START
G1 X92.235 Y79.556 E-.32243
G1 X92.276 Y79.529 E-.00918
G1 X92.531 Y79.537 E-.04839
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.023 Y79.123 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.378302
G1 F1200
M204 S6000
G1 X91.954 Y79.137 E.00124
; LINE_WIDTH: 0.395035
G1 X91.885 Y79.152 E.0013
G1 X91.857 Y79.29 E.0026
; LINE_WIDTH: 0.365752
G1 X91.857 Y88.012 E.14796
; LINE_WIDTH: 0.378302
G1 X91.871 Y88.081 E.00124
; LINE_WIDTH: 0.395036
G1 X91.885 Y88.15 E.0013
G1 X92.023 Y88.179 E.0026
; LINE_WIDTH: 0.365752
G1 X94.846 Y88.179 E.04788
; LINE_WIDTH: 0.378302
G1 X94.915 Y88.164 E.00124
; LINE_WIDTH: 0.395036
G1 X94.984 Y88.15 E.0013
G1 X95.013 Y88.012 E.0026
; LINE_WIDTH: 0.365752
G1 X95.013 Y79.29 E.14796
; LINE_WIDTH: 0.378302
G1 X94.998 Y79.221 E.00124
; LINE_WIDTH: 0.395035
G1 X94.984 Y79.152 E.0013
G1 X94.846 Y79.123 E.0026
; LINE_WIDTH: 0.365752
G1 X92.083 Y79.123 E.04686
; WIPE_START
G1 X94.083 Y79.123 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.516 Y78.132 Z1.44 F18000
G1 X77.536 Y76.956 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0876583
G1 F1500
M204 S6000
G1 X77.429 Y76.99 E.00035
; LINE_WIDTH: 0.115184
G1 X77.307 Y77.033 E.00058
; LINE_WIDTH: 0.151511
G1 X77.103 Y77.195 E.00164
G1 X76.99 Y77.329 E.0011
G1 X76.947 Y77.424 E.00065
; LINE_WIDTH: 0.115225
G1 X76.918 Y77.513 E.00042
; LINE_WIDTH: 0.0897986
G1 X76.889 Y77.603 E.0003
; WIPE_START
G1 X76.918 Y77.513 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.909 Y85.146 Z1.44 F18000
G1 X76.896 Y95.622 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.094456
G1 F1500
M204 S6000
G1 X76.938 Y95.734 E.00041
; LINE_WIDTH: 0.128542
G1 X76.981 Y95.845 E.00061
; LINE_WIDTH: 0.155367
G1 X77.043 Y95.953 E.00081
G1 X77.134 Y96.04 E.00081
G1 X77.321 Y96.165 E.00145
; LINE_WIDTH: 0.121258
G1 X77.394 Y96.206 E.0004
; LINE_WIDTH: 0.0939587
G1 X77.467 Y96.236 E.00027
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.394 Y96.206 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/49
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I.781 J.933 P1  F18000
G1 X91.478 Y84.423 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.12019
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.483 E.08624
M204 S10000
G1 X91.054 Y85.167 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17009
G1 X91.25 Y77.085 E.00426
G1 X91.362 Y77.309 E.00531
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.227 E.07947
; WIPE_START
M204 S6000
G1 X91.054 Y83.227 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.859 Z1.56 F18000
G1 X90.895 Y95.42 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.967 Y95.276 E.00342
G1 X91.097 Y95.18 E.00342
G1 X91.284 Y95.151 E.00402
G1 X92.113 Y95.375 E.01816
G1 X91.416 Y95.805 E.01733
G1 X91.328 Y95.843 E.00204
G1 X90.838 Y95.903 E.01044
G1 X90.888 Y95.48 E.00903
; WIPE_START
M204 S6000
G1 X90.967 Y95.276 E-.04155
G1 X91.097 Y95.18 E-.03067
G1 X91.284 Y95.151 E-.03608
G1 X92.113 Y95.375 E-.16306
G1 X91.626 Y95.675 E-.10864
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.171 Y91.443 F18000
G1 F1500
M204 S500
G1 X98.111 Y90.785 E.02429
G1 X100.308 Y89.247 E.05676
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X96.836 Y91.678 E.08971
G1 X97.122 Y91.477 E.00739
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.345 Y91.12 E.02257
G1 X100.207 Y89.817 E.0447
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X98.345 Y91.12 E-.21832
G1 X99.043 Y90.632 E-.16168
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.134 Y93.877 Z1.56 F18000
G1 X85.246 Y97.112 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01124
G1 X83.008 Y97.034 E.00803
G1 X82.807 Y97.12 E.00462
G1 X82.687 Y96.956 E.00429
G1 X83.045 Y96.544 E.01155
G1 X85.017 Y96.544 E.04174
G1 X85.37 Y96.947 E.01132
G1 X85.282 Y97.064 E.00309
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09377
G1 X84.428 Y96.88 E-.07221
G1 X83.898 Y96.856 E-.1008
G1 X83.372 Y96.928 E-.10087
G1 X83.31 Y96.946 E-.01236
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.499 Y100.776 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.482 Y100.836 E.00133
G1 X86.36 Y101.109 E.00632
G1 X86.195 Y101.385 E.00681
G1 X85.902 Y101.741 E.00975
G1 X85.551 Y102.039 E.00975
G1 X85.277 Y102.208 E.00681
G1 X85.007 Y102.334 E.00632
G1 X84.544 Y102.473 E.01023
G1 X84.083 Y102.521 E.0098
G1 X83.762 Y102.507 E.00681
G1 X83.467 Y102.459 E.00632
G1 X83.006 Y102.313 E.01023
G1 X82.591 Y102.089 E.00999
G1 X82.23 Y101.802 E.00976
G1 X82.011 Y101.566 E.00681
G1 X81.835 Y101.325 E.00632
G1 X81.609 Y100.897 E.01023
G1 X81.47 Y100.446 E.00999
G1 X81.414 Y99.979 E.00995
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.205 E.00681
G1 X81.604 Y98.922 E.00632
G1 X81.824 Y98.491 E.01023
G1 X82.113 Y98.118 E.00999
G1 X82.462 Y97.803 E.00995
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.46 Y97.344 E.00683
G1 X83.917 Y97.282 E.00975
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X84.992 Y97.462 E.00663
G1 X85.276 Y97.593 E.00663
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.195 Y98.417 E.00975
G1 X86.36 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00994
G1 X86.614 Y100.371 E.00999
G1 X86.516 Y100.718 E.00763
M204 S250
G1 X86.106 Y100.664 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.097 Y100.696 E.00065
G1 X85.996 Y100.919 E.00482
G1 X85.859 Y101.149 E.00525
G1 X85.61 Y101.452 E.00773
G1 X85.31 Y101.707 E.00773
G1 X85.082 Y101.847 E.00526
G1 X84.861 Y101.951 E.00482
G1 X84.463 Y102.07 E.00817
G1 X84.071 Y102.111 E.00775
G1 X83.804 Y102.099 E.00525
G1 X83.562 Y102.06 E.00482
G1 X83.167 Y101.934 E.00817
G1 X82.817 Y101.746 E.00781
G1 X82.509 Y101.501 E.00774
G1 X82.328 Y101.305 E.00525
G1 X82.183 Y101.107 E.00482
G1 X81.989 Y100.74 E.00817
G1 X81.872 Y100.361 E.00781
G1 X81.825 Y99.967 E.0078
G1 X81.848 Y99.575 E.00773
G1 X81.904 Y99.313 E.00526
G1 X81.982 Y99.081 E.00482
G1 X82.171 Y98.711 E.00817
G1 X82.414 Y98.397 E.00781
G1 X82.709 Y98.132 E.0078
G1 X83.043 Y97.925 E.00773
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00774
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.842 Y97.843 E.0052
G1 X85.082 Y97.954 E.0052
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.859 Y98.653 E.00773
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00774
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00781
G1 X86.122 Y100.607 E.00634
; WIPE_START
M204 S6000
G1 X86.097 Y100.696 E-.01764
G1 X85.996 Y100.919 E-.04654
G1 X85.859 Y101.149 E-.05076
G1 X85.61 Y101.452 E-.07471
G1 X85.31 Y101.707 E-.07471
G1 X85.082 Y101.847 E-.05077
G1 X84.861 Y101.951 E-.04652
G1 X84.768 Y101.978 E-.01835
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.271 Y96.12 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.10825
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.928 Y94.787 E.00382
G1 X91.101 Y94.736 E.00382
G1 X91.3 Y94.725 E.00421
G1 X91.835 Y94.86 E.01168
G1 X100.372 Y88.882 E.22058
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.21 Y95.814 E.0797
G1 X91.613 Y96.182 E.01484
G1 X91.474 Y96.243 E.00322
G1 X91.121 Y96.296 E.00755
G1 X90.778 Y96.444 E.00791
G1 X90.645 Y96.472 E.00288
G1 X85.529 Y96.485 E.10827
G1 X86.693 Y97.814 E.03737
G1 X86.832 Y98.002 E.00496
G1 X87.105 Y98.49 E.01182
G1 X87.264 Y98.904 E.00939
G1 X87.389 Y99.48 E.01249
G1 X87.41 Y100.091 E.01292
G1 X87.33 Y100.646 E.01188
G1 X87.205 Y101.073 E.00941
G1 X86.948 Y101.616 E.01272
G1 X86.624 Y102.071 E.01182
G1 X86.318 Y102.392 E.00939
G1 X86.001 Y102.65 E.00864
G1 X85.678 Y102.855 E.00811
G1 X85.307 Y103.032 E.00871
G1 X84.957 Y103.152 E.00783
G1 X84.739 Y103.207 E.00476
G1 X84.326 Y103.269 E.00883
G1 X83.734 Y103.267 E.01253
G1 X83.151 Y103.163 E.01254
G1 X82.753 Y103.029 E.00888
G1 X82.227 Y102.757 E.01254
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.88 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.662 Y99.688 E.00851
G1 X80.751 Y99.101 E.01258
G1 X80.874 Y98.703 E.00882
G1 X81.113 Y98.205 E.01169
G1 X81.359 Y97.836 E.00939
G1 X82.538 Y96.482 E.038
M73 P50 R12
G1 X77.571 Y96.482 E.10513
G1 X77.322 Y96.453 E.0053
G1 X77.111 Y96.37 E.0048
G1 X76.917 Y96.224 E.00515
G1 X76.825 Y96.12 E.00294
G1 X76.684 Y95.821 E.00699
G1 X76.654 Y95.565 E.00547
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00596
G1 X76.801 Y77.118 E.0052
G1 X76.897 Y76.997 E.00327
G1 X77.007 Y76.898 E.00314
G1 X77.235 Y76.775 E.00549
G1 X77.486 Y76.723 E.00541
G1 X90.513 Y76.721 E.27574
G1 X90.745 Y76.749 E.00493
G1 X90.881 Y76.794 E.00303
G1 X91.057 Y76.89 E.00425
G1 X91.008 Y77.082 E.00418
G1 X77.99 Y77.082 E.27554
G1 X77.731 Y77.119 E.00553
G1 X77.429 Y77.271 E.00717
G1 X77.205 Y77.495 E.00669
G1 X77.053 Y77.798 E.00717
G1 X77.016 Y78.056 E.00552
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.971 Y96.12 E.00767
G1 X85.211 Y96.12 E.15323
; WIPE_START
M204 S6000
G1 X87.211 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.429 Y96.892 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.012 Y97.557 E.01739
G1 X87.288 Y97.957 E.00956
G1 X87.478 Y98.321 E.00807
G1 X87.655 Y98.781 E.00969
G1 X87.763 Y99.22 E.0089
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.335 E.00873
G1 X87.729 Y100.739 E.00807
G1 X87.59 Y101.213 E.0097
G1 X87.427 Y101.588 E.00806
G1 X87.184 Y102.009 E.00956
G1 X86.936 Y102.337 E.00807
G1 X86.596 Y102.694 E.0097
G1 X86.246 Y102.979 E.0089
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00437
G1 X85.461 Y103.412 E.00892
G1 X85.073 Y103.545 E.00807
G1 X84.819 Y103.609 E.00515
G1 X84.369 Y103.676 E.00896
G1 X84.15 Y103.689 E.0043
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.605 Y103.411 E.00897
G1 X82.405 Y103.322 E.00431
G1 X82.008 Y103.103 E.00891
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.663 E.00885
G1 X80.301 Y99.256 E.00808
G1 X80.354 Y98.999 E.00515
G1 X80.488 Y98.564 E.00895
G1 X80.572 Y98.362 E.00431
G1 X80.759 Y97.997 E.00807
G1 X81.034 Y97.587 E.00969
G1 X81.639 Y96.891 E.01815
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.0062
G1 X77.035 Y96.789 E.00412
G1 X76.895 Y96.72 E.00306
G1 X76.637 Y96.526 E.00636
G1 X76.499 Y96.369 E.00412
G1 X76.42 Y96.248 E.00284
G1 X76.322 Y96.039 E.00454
G1 X76.282 Y95.904 E.00276
G1 X76.245 Y95.589 E.00625
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.597 Y76.716 E.00443
G1 X76.756 Y76.574 E.00418
G1 X76.888 Y76.485 E.00314
G1 X77.094 Y76.389 E.00447
G1 X77.299 Y76.333 E.00418
G1 X77.461 Y76.313 E.0032
G1 X90.538 Y76.311 E.25722
G1 X90.835 Y76.347 E.00588
G1 X91.045 Y76.417 E.00436
G1 X91.253 Y76.531 E.00466
G1 X91.474 Y76.718 E.00571
G1 X91.61 Y76.89 E.00431
G1 X91.747 Y77.163 E.006
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.02 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.608 E.00406
G1 X77.541 Y77.738 E.00362
G1 X77.449 Y77.922 E.00406
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X90.022 Y95.711 E.23619
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00543
G1 X90.526 Y94.547 E.00544
G1 X90.766 Y94.409 E.00544
G1 X91.031 Y94.33 E.00543
G1 X91.313 Y94.314 E.00556
G1 X91.441 Y94.329 E.00254
G1 X91.757 Y94.415 E.00644
G1 X100.472 Y88.312 E.20927
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.096 Y96.365 E.07451
G1 X91.803 Y96.546 E.00677
G1 X91.61 Y96.63 E.00415
G1 X91.484 Y96.664 E.00257
G1 X91.229 Y96.695 E.00504
G1 X90.901 Y96.837 E.00702
G1 X90.687 Y96.881 E.00431
G1 X86.489 Y96.892 E.08256
; WIPE_START
M204 S6000
G1 X87.012 Y97.557 E-.16069
G1 X87.288 Y97.957 E-.09235
G1 X87.478 Y98.321 E-.07798
G1 X87.571 Y98.561 E-.04897
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




G1 X86.162 Y97.784
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378551
G1 F1500
M204 S6000
G1 X85.985 Y97.61 E.00438
; LINE_WIDTH: 0.418278
G1 X85.782 Y97.412 E.00556
; LINE_WIDTH: 0.455035
G1 X85.629 Y97.285 E.00425
; LINE_WIDTH: 0.480812
G1 X85.476 Y97.158 E.00451
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.360327
G1 F1500
M204 S6000
G1 X86.496 Y98.19 E.00877
G1 X86.691 Y98.511 E.00627
G1 X86.85 Y98.873 E.0066
G1 X86.98 Y99.352 E.00828
G1 X87.036 Y99.903 E.00925
G1 X87.012 Y100.236 E.00556
G1 X86.958 Y100.559 E.00548
G1 X86.842 Y100.954 E.00687
G1 X86.617 Y101.423 E.00868
G1 X86.33 Y101.825 E.00824
G1 X86.058 Y102.111 E.00659
G1 X85.777 Y102.344 E.00609
G1 X85.466 Y102.537 E.00611
G1 X85.13 Y102.692 E.00617
G1 X84.633 Y102.84 E.00866
G1 X84.082 Y102.9 E.00925
G1 X83.733 Y102.884 E.00584
G1 X83.367 Y102.824 E.00618
G1 X82.873 Y102.667 E.00866
G1 X82.395 Y102.412 E.00904
G1 X81.983 Y102.086 E.00877
G1 X81.714 Y101.798 E.00657
G1 X81.509 Y101.514 E.00585
G1 X81.267 Y101.056 E.00866
G1 X81.105 Y100.539 E.00904
G1 X81.041 Y100.069 E.00791
G1 X81.066 Y99.481 E.00983
G1 X81.121 Y99.196 E.00485
G1 X81.252 Y98.786 E.00718
G1 X81.499 Y98.303 E.00906
G1 X81.827 Y97.872 E.00904
G1 X82.025 Y97.669 E.00474
; LINE_WIDTH: 0.401767
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438827
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.475192
G1 X82.578 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P51 R12
G1 X77.426 Y96.246 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.153076
G1 F1500
M204 S6000
G1 X77.108 Y96.017 E.00249
G1 X77.044 Y95.952 E.00059
G1 X76.959 Y95.801 E.0011
; LINE_WIDTH: 0.123725
G1 X76.927 Y95.711 E.00046
; LINE_WIDTH: 0.0937308
G1 X76.896 Y95.622 E.00032
; WIPE_START
G1 X76.927 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.555 Y95.986 Z1.56 F18000
G1 X90.59 Y96.203 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.12716
G1 F1500
M204 S6000
G1 X90.803 Y96.16 E.0011
; LINE_WIDTH: 0.0931912
G1 X90.907 Y96.132 E.00036
M204 S10000
G1 X91.262 Y95.474 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X91.198 Y95.51 E.00125
G1 X91.247 Y95.538 E.00095
; WIPE_START
G1 X91.198 Y95.51 E-.16436
G1 X91.262 Y95.474 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.922 Y94.128 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42989
; LAYER_HEIGHT: 0.4
G1 F826.755
M204 S6000
G1 X93.017 Y95.572 E.10282
G1 X93.316 Y95.999 E.03144
G1 X94.655 Y93.862 E.15216
G1 X95.664 Y93.156 E.07432
G1 X93.615 Y96.426 E.23286
G1 X93.914 Y96.853 E.03144
G1 X96.543 Y92.655 E.29889
G1 X96.842 Y93.082 E.03144
G1 X94.213 Y97.279 E.29889
G1 X94.511 Y97.706 E.03144
G1 X97.141 Y93.509 E.29889
G1 X97.44 Y93.936 E.03144
G1 X95.391 Y97.206 E.23287
G1 X96.4 Y96.5 E.07432
G1 X97.739 Y94.363 E.15217
G1 X98.038 Y94.789 E.03144
G1 X97.133 Y96.234 E.10283
; WIPE_START
G1 X98.038 Y94.789 E-.32377
G1 X97.868 Y94.547 E-.05623
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.944 Y88.716 Z1.56 F18000
G1 X91.651 Y87.185 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.40603
G1 F926.777
M204 S6000
G1 X92.299 Y88.182 E.06397
G1 X92.842 Y88.182 E.02927
G1 X91.854 Y86.659 E.0977
G1 X91.854 Y85.822 E.04508
G1 X93.386 Y88.182 E.15145
G1 X93.93 Y88.182 E.02927
G1 X91.854 Y84.985 E.2052
G1 X91.854 Y84.147 E.04508
G1 X94.473 Y88.182 E.25895
G1 X95.016 Y88.182 E.02919
G1 X91.854 Y83.31 E.31265
G1 X91.854 Y82.472 E.04508
G1 X95.016 Y87.342 E.31255
G1 X95.016 Y86.504 E.04508
G1 X91.854 Y81.635 E.31255
G1 X91.854 Y80.797 E.04508
G1 X95.016 Y85.667 E.31255
G1 X95.016 Y84.829 E.04508
G1 X91.854 Y79.96 E.31255
G1 X91.854 Y79.122 E.04508
G1 X95.016 Y83.992 E.31255
G1 X95.016 Y83.155 E.04508
G1 X92.396 Y79.12 E.25894
G1 X92.94 Y79.12 E.02927
G1 X95.016 Y82.317 E.20519
G1 X95.016 Y81.48 E.04508
G1 X93.484 Y79.12 E.15144
G1 X94.027 Y79.12 E.02927
G1 X95.016 Y80.642 E.09769
G1 X95.016 Y79.805 E.04508
G1 X94.44 Y78.918 E.05694
; WIPE_START
G1 X95.016 Y79.805 E-.20096
M73 P51 R11
G1 X95.016 Y80.642 E-.15912
G1 X94.958 Y80.554 E-.01992
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.484 Y79.01 Z1.56 F18000
G1 X77.539 Y76.955 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.089426
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S6000
G1 X77.432 Y76.991 E.00036
; LINE_WIDTH: 0.128417
G1 X77.228 Y77.083 E.00115
; LINE_WIDTH: 0.153817
G1 X77.106 Y77.192 E.00104
G1 X76.97 Y77.369 E.00143
; LINE_WIDTH: 0.120628
G1 X76.929 Y77.487 E.00059
; LINE_WIDTH: 0.0908292
G1 X76.889 Y77.604 E.0004
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.929 Y77.487 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/49
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.519 J1.101 P1  F18000
G1 X91.478 Y84.34 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.11843
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.4 E.088
M204 S10000
G1 X91.054 Y85.089 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.16842
G1 X91.25 Y77.085 E.00426
G1 X91.363 Y77.309 E.00531
G1 X91.398 Y77.441 E.00289
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.149 E.08113
; WIPE_START
M204 S6000
G1 X91.054 Y83.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.955 Y90.78 Z1.68 F18000
G1 X90.895 Y95.42 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.967 Y95.276 E.00342
G1 X91.093 Y95.182 E.00333
G1 X91.247 Y95.147 E.00334
G1 X92.162 Y95.366 E.01991
G1 X91.343 Y95.839 E.02001
G1 X90.838 Y95.903 E.01077
G1 X90.888 Y95.48 E.00903
; WIPE_START
M204 S6000
G1 X90.967 Y95.276 E-.04158
G1 X91.093 Y95.182 E-.02986
G1 X91.247 Y95.147 E-.02996
G1 X92.162 Y95.366 E-.17872
G1 X91.706 Y95.629 E-.09988
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.07761
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.07 Y92.013 F18000
G1 F1500
M204 S500
G1 X96.836 Y91.678 E.00866
G1 X97.926 Y90.914 E.02819
G1 X100.308 Y89.247 E.06152
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X97.105 Y92.062 E.07978
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.161 Y91.249 E.01814
G1 X100.207 Y89.817 E.04912
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X98.161 Y91.249 E-.17564
G1 X99.042 Y90.632 E-.20436
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.123 Y93.854 Z1.68 F18000
G1 X85.194 Y97.081 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.00874
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01124
G1 X83.008 Y97.034 E.00803
G1 X82.807 Y97.12 E.00462
G1 X82.687 Y96.956 E.00429
G1 X83.045 Y96.544 E.01155
G1 X84.957 Y96.544 E.04046
G1 X85.3 Y96.916 E.01069
G1 X85.226 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.08209
G1 X84.428 Y96.88 E-.07221
G1 X83.898 Y96.856 E-.1008
G1 X83.372 Y96.928 E-.10088
G1 X83.251 Y96.963 E-.02401
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.488 Y100.808 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.425 Y100.975 E.00377
G1 X86.201 Y101.378 E.00975
G1 X85.902 Y101.741 E.00995
G1 X85.551 Y102.039 E.00975
G1 X85.277 Y102.208 E.00681
G1 X85.009 Y102.333 E.00627
G1 X84.544 Y102.473 E.01028
G1 X84.083 Y102.521 E.0098
G1 X83.762 Y102.507 E.0068
M73 P52 R11
G1 X83.47 Y102.459 E.00627
G1 X83.007 Y102.313 E.01028
G1 X82.59 Y102.089 E.01
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.747 Y101.178 E.00681
G1 X81.617 Y100.912 E.00627
G1 X81.471 Y100.448 E.01029
G1 X81.414 Y99.979 E.01
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.205 E.00681
G1 X81.603 Y98.924 E.00626
G1 X81.824 Y98.491 E.01028
G1 X82.113 Y98.118 E.01
G1 X82.462 Y97.803 E.00995
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.46 Y97.344 E.00683
G1 X83.917 Y97.282 E.00976
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00976
G1 X85.789 Y97.952 E.00994
G1 X86.102 Y98.29 E.00973
G1 X86.269 Y98.533 E.00626
G1 X86.428 Y98.833 E.00717
G1 X86.539 Y99.129 E.00669
G1 X86.615 Y99.442 E.00683
G1 X86.657 Y99.903 E.0098
G1 X86.609 Y100.387 E.01029
G1 X86.538 Y100.674 E.00626
G1 X86.509 Y100.752 E.00177
M204 S250
G1 X86.105 Y100.665 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.053 Y100.803 E.0029
G1 X85.861 Y101.146 E.00773
G1 X85.61 Y101.452 E.0078
G1 X85.31 Y101.707 E.00773
G1 X85.083 Y101.847 E.00526
G1 X84.863 Y101.95 E.00477
G1 X84.463 Y102.07 E.00821
G1 X84.071 Y102.111 E.00775
G1 X83.804 Y102.099 E.00525
G1 X83.565 Y102.06 E.00477
G1 X83.167 Y101.934 E.00821
G1 X82.817 Y101.746 E.00781
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.978 E.00526
G1 X81.998 Y100.76 E.00477
G1 X81.872 Y100.361 E.00822
G1 X81.825 Y99.967 E.00781
G1 X81.848 Y99.574 E.00774
G1 X81.904 Y99.313 E.00525
G1 X81.982 Y99.084 E.00477
G1 X82.171 Y98.711 E.00822
G1 X82.414 Y98.397 E.00781
G1 X82.709 Y98.132 E.0078
G1 X83.043 Y97.925 E.00773
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00774
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.514 Y98.258 E.00779
G1 X85.781 Y98.546 E.00773
G1 X85.918 Y98.746 E.00477
G1 X86.054 Y99.001 E.00569
G1 X86.147 Y99.249 E.00522
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.902 E.00775
G1 X86.205 Y100.317 E.00822
G1 X86.147 Y100.553 E.00477
G1 X86.126 Y100.609 E.00117
; WIPE_START
M204 S6000
G1 X86.053 Y100.803 E-.03945
G1 X85.861 Y101.146 E-.0747
G1 X85.61 Y101.452 E-.07531
G1 X85.31 Y101.707 E-.0747
G1 X85.083 Y101.847 E-.05076
G1 X84.863 Y101.95 E-.04606
G1 X84.767 Y101.979 E-.01901
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.205 Y96.12 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.10965
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00382
G1 X90.772 Y94.877 E.00382
G1 X90.926 Y94.789 E.00377
G1 X91.125 Y94.731 E.00438
G1 X91.244 Y94.722 E.00252
G1 X91.844 Y94.854 E.013
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.218 Y95.825 E.0794
G1 X91.571 Y96.204 E.01587
G1 X91.404 Y96.261 E.00372
G1 X91.121 Y96.296 E.00604
G1 X90.778 Y96.444 E.00791
G1 X90.645 Y96.472 E.00288
G1 X85.48 Y96.485 E.10932
G1 X86.579 Y97.675 E.03428
G1 X86.835 Y98.008 E.00888
G1 X87.103 Y98.486 E.01159
G1 X87.264 Y98.904 E.00949
G1 X87.389 Y99.48 E.01248
G1 X87.41 Y100.091 E.01292
G1 X87.331 Y100.642 E.01179
G1 X87.205 Y101.073 E.00951
G1 X86.952 Y101.608 E.01253
G1 X86.605 Y102.096 E.01267
G1 X86.32 Y102.391 E.00868
G1 X86.002 Y102.65 E.00868
G1 X85.522 Y102.935 E.0118
G1 X85.312 Y103.03 E.00488
G1 X84.961 Y103.151 E.00786
G1 X84.738 Y103.207 E.00486
G1 X84.326 Y103.269 E.00881
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.619 Y102.969 E.01178
G1 X82.225 Y102.755 E.00949
G1 X81.902 Y102.522 E.00844
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.88 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01254
G1 X80.753 Y99.095 E.00869
G1 X80.874 Y98.703 E.00869
G1 X81.11 Y98.209 E.01159
G1 X81.36 Y97.836 E.00949
G1 X82.538 Y96.482 E.03799
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00343
G1 X76.824 Y96.119 E.00343
G1 X76.731 Y95.957 E.00394
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.627 E.37967
G1 X76.693 Y77.346 E.00599
G1 X76.801 Y77.117 E.00537
G1 X76.965 Y76.932 E.00523
G1 X77.097 Y76.839 E.00341
G1 X77.23 Y76.777 E.00311
G1 X77.493 Y76.723 E.00569
G1 X90.515 Y76.721 E.27563
G1 X90.745 Y76.749 E.0049
G1 X90.883 Y76.794 E.00308
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.731 Y77.119 E.00552
G1 X77.429 Y77.272 E.00717
G1 X77.212 Y77.488 E.00649
G1 X77.066 Y77.758 E.00649
G1 X77.016 Y78.047 E.0062
G1 X77.016 Y95.155 E.36211
G1 X77.068 Y95.453 E.0064
G1 X77.255 Y95.777 E.00792
G1 X77.609 Y96.043 E.00937
G1 X77.97 Y96.12 E.0078
G1 X85.145 Y96.12 E.15187
; WIPE_START
M204 S6000
G1 X87.145 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.413 Y96.892 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01389
G1 X87.17 Y97.772 E.00897
G1 X87.288 Y97.957 E.00431
G1 X87.476 Y98.317 E.00798
G1 X87.655 Y98.781 E.00979
G1 X87.763 Y99.22 E.00889
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.335 E.00874
G1 X87.73 Y100.735 E.00798
G1 X87.59 Y101.213 E.0098
G1 X87.429 Y101.584 E.00797
G1 X87.303 Y101.819 E.00525
G1 X87.05 Y102.197 E.00895
G1 X86.912 Y102.368 E.00431
G1 X86.597 Y102.693 E.00891
G1 X86.246 Y102.979 E.00891
G1 X86.064 Y103.102 E.00432
G1 X85.707 Y103.301 E.00804
G1 X85.463 Y103.411 E.00525
G1 X85.078 Y103.543 E.00802
G1 X84.819 Y103.609 E.00525
G1 X84.369 Y103.676 E.00895
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.821 Y103.491 E.00437
G1 X82.445 Y103.34 E.00798
G1 X82.007 Y103.103 E.00979
G1 X81.643 Y102.84 E.00883
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.564 E.00891
G1 X80.572 Y98.362 E.00431
G1 X80.757 Y98.001 E.00798
G1 X81.034 Y97.587 E.00979
G1 X81.639 Y96.891 E.01815
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.368 E.00448
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35363
G1 X76.263 Y77.39 E.00433
G1 X76.3 Y77.23 E.00323
G1 X76.35 Y77.093 E.00287
G1 X76.458 Y76.892 E.00449
G1 X76.588 Y76.726 E.00415
G1 X76.704 Y76.615 E.00317
G1 X76.891 Y76.484 E.00447
G1 X77.081 Y76.394 E.00415
G1 X77.235 Y76.347 E.00317
G1 X77.463 Y76.313 E.00453
G1 X90.54 Y76.311 E.25721
G1 X90.835 Y76.347 E.00584
G1 X91.045 Y76.417 E.00437
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.02 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.608 E.00407
G1 X77.544 Y77.735 E.00355
G1 X77.458 Y77.894 E.00355
G1 X77.425 Y78.082 E.00376
G1 X77.425 Y95.119 E.3351
G1 X77.459 Y95.311 E.00383
G1 X77.568 Y95.5 E.0043
G1 X77.783 Y95.662 E.00529
G1 X78.013 Y95.711 E.00462
G1 X90.022 Y95.711 E.2362
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00543
G1 X90.526 Y94.547 E.00543
G1 X90.765 Y94.409 E.00542
G1 X91.051 Y94.327 E.00586
G1 X91.369 Y94.319 E.00626
G1 X91.76 Y94.413 E.0079
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.07442
G1 X91.753 Y96.571 E.00789
G1 X91.612 Y96.629 E.00299
G1 X91.483 Y96.664 E.00261
G1 X91.229 Y96.695 E.00504
G1 X90.902 Y96.837 E.00702
G1 X90.687 Y96.881 E.00431
G1 X86.473 Y96.892 E.08289
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12678
G1 X87.17 Y97.772 E-.08666
G1 X87.288 Y97.957 E-.04163
G1 X87.476 Y98.317 E-.07708
G1 X87.567 Y98.552 E-.04785
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




G1 X86.036 Y97.655
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.395932
G1 F1500
M204 S6000
G1 X85.846 Y97.485 E.00471
; LINE_WIDTH: 0.442242
G1 X85.657 Y97.314 E.0053
; LINE_WIDTH: 0.480636
G1 X85.415 Y97.129 E.0069
M204 S10000
G1 X86.036 Y97.655 F18000
; LINE_WIDTH: 0.359835
G1 F1500
M204 S6000
G1 X86.387 Y98.046 E.00876
G1 X86.599 Y98.345 E.0061
G1 X86.768 Y98.668 E.00608
G1 X86.904 Y99.027 E.00639
G1 X87.007 Y99.524 E.00847
G1 X87.031 Y99.92 E.0066
G1 X86.978 Y100.462 E.00908
M73 P53 R11
G1 X86.845 Y100.943 E.00831
G1 X86.762 Y101.145 E.00364
G1 X86.622 Y101.41 E.005
G1 X86.414 Y101.722 E.00625
G1 X86.06 Y102.108 E.00873
G1 X85.761 Y102.349 E.0064
G1 X85.463 Y102.532 E.00583
G1 X85.133 Y102.691 E.00611
G1 X84.633 Y102.841 E.00869
G1 X84.082 Y102.895 E.00923
G1 X83.733 Y102.884 E.00583
G1 X83.243 Y102.79 E.00831
G1 X82.846 Y102.653 E.007
G1 X82.395 Y102.412 E.00853
G1 X81.974 Y102.078 E.00896
G1 X81.648 Y101.716 E.00811
G1 X81.45 Y101.42 E.00594
G1 X81.27 Y101.063 E.00666
G1 X81.106 Y100.543 E.00909
G1 X81.042 Y100.071 E.00793
G1 X81.058 Y99.545 E.00877
G1 X81.123 Y99.186 E.00609
G1 X81.25 Y98.789 E.00695
G1 X81.499 Y98.303 E.00909
G1 X81.827 Y97.872 E.00903
G1 X82.025 Y97.669 E.00473
; LINE_WIDTH: 0.401791
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438842
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.47522
G1 X82.578 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.477 Y96.248 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.140087
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00149
; LINE_WIDTH: 0.148656
G1 X77.042 Y95.954 E.00163
G1 X76.882 Y95.627 E.00223
; WIPE_START
G1 X77.042 Y95.954 E-.21954
G1 X77.247 Y96.123 E-.16046
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.88 Y96.169 Z1.68 F18000
G1 X90.59 Y96.203 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.127142
G1 F1500
M204 S6000
G1 X90.803 Y96.16 E.0011
; LINE_WIDTH: 0.0931838
G1 X90.907 Y96.132 E.00036
; WIPE_START
G1 X90.803 Y96.16 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.954 Y95.582 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.446 Y95.493 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X92.799 Y95.202 F18000
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
; WIPE_START
G1 X94.487 Y94.021 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.435 Y86.601 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.449 Y81.99 Z1.68 F18000
G1 X77.539 Y76.955 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0995356
G1 F1500
M204 S6000
G1 X77.385 Y77.002 E.00059
; LINE_WIDTH: 0.14948
G1 X77.264 Y77.058 E.00082
G1 X77.148 Y77.15 E.00091
G1 X76.972 Y77.367 E.00173
; LINE_WIDTH: 0.123362
G1 X76.931 Y77.479 E.00058
; LINE_WIDTH: 0.0921784
G1 X76.891 Y77.59 E.00039
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.931 Y77.479 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/49
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.525 J1.098 P1  F18000
G1 X91.478 Y84.433 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.12039
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.493 E.08604
M204 S10000
G1 X91.054 Y85.176 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.131 E.17029
G1 X91.228 Y77.073 E.00388
G1 X91.291 Y77.157 E.00223
G1 X91.361 Y77.303 E.00342
G1 X91.398 Y77.441 E.00303
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.236 E.07928
; WIPE_START
M204 S6000
G1 X91.054 Y83.236 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.868 Z1.8 F18000
G1 X90.895 Y95.42 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.967 Y95.276 E.00342
G1 X91.094 Y95.181 E.00335
G1 X91.247 Y95.147 E.00332
G1 X92.163 Y95.367 E.01994
G1 X91.344 Y95.838 E.02001
G1 X90.838 Y95.903 E.01079
G1 X90.888 Y95.48 E.00903
; WIPE_START
M204 S6000
G1 X90.967 Y95.276 E-.04156
G1 X91.094 Y95.181 E-.03007
G1 X91.247 Y95.147 E-.02981
G1 X92.163 Y95.367 E-.17898
G1 X91.709 Y95.628 E-.09957
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.723 Y92.256 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11246
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
M204 S10000
G1 X97.07 Y92.013 F18000
G1 F1500
M204 S500
G1 X96.836 Y91.678 E.00866
G1 X97.742 Y91.043 E.02342
G1 X100.308 Y89.247 E.06629
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X97.105 Y92.062 E.07978
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.977 Y91.378 E.01372
G1 X100.207 Y89.817 E.05355
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X97.977 Y91.378 E-.13301
G1 X99.042 Y90.633 E-.24699
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.138 Y93.888 Z1.8 F18000
G1 X85.269 Y97.128 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.976 Y97.002 E.00674
G1 X84.444 Y96.881 E.01157
G1 X83.914 Y96.857 E.01123
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00804
G1 X82.796 Y97.126 E.00838
G1 X82.681 Y96.963 E.00423
G1 X83.046 Y96.544 E.01174
G1 X85.024 Y96.544 E.04188
G1 X85.389 Y96.964 E.01176
G1 X85.305 Y97.079 E.00302
; WIPE_START
M204 S6000
G1 X84.976 Y97.002 E-.06406
G1 X84.444 Y96.881 E-.10383
G1 X83.914 Y96.857 E-.1008
G1 X83.536 Y96.897 E-.0722
G1 X83.335 Y96.943 E-.03911
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.479 Y100.841 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
M73 P54 R11
G1 X86.361 Y101.107 E.00616
G1 X86.211 Y101.359 E.00621
G1 X85.904 Y101.739 E.01034
G1 X85.551 Y102.039 E.00981
G1 X85.277 Y102.208 E.0068
G1 X85.012 Y102.332 E.00621
G1 X84.544 Y102.473 E.01034
G1 X84.083 Y102.521 E.00981
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00684
G1 X83.004 Y102.312 E.00975
G1 X82.59 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.747 Y101.178 E.00681
G1 X81.618 Y100.914 E.00621
G1 X81.471 Y100.449 E.01034
G1 X81.414 Y99.979 E.01
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.205 E.00681
G1 X81.602 Y98.927 E.00621
G1 X81.824 Y98.491 E.01034
G1 X82.114 Y98.116 E.01006
G1 X82.487 Y97.785 E.01054
G1 X82.863 Y97.556 E.00933
G1 X83.291 Y97.388 E.00972
G1 X83.605 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.387 Y97.303 E.00975
G1 X84.845 Y97.407 E.00995
G1 X85.267 Y97.588 E.00972
G1 X85.517 Y97.741 E.00621
G1 X85.786 Y97.952 E.00723
G1 X86.008 Y98.177 E.00669
G1 X86.205 Y98.432 E.00683
G1 X86.425 Y98.827 E.00956
G1 X86.538 Y99.127 E.0068
G1 X86.609 Y99.412 E.00621
G1 X86.657 Y99.898 E.01034
G1 X86.614 Y100.369 E.01
G1 X86.5 Y100.785 E.00913
M204 S250
G1 X86.106 Y100.675 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00526
G1 X85.875 Y101.125 E.00472
G1 X85.61 Y101.452 E.00826
G1 X85.31 Y101.707 E.00775
G1 X85.083 Y101.847 E.00525
G1 X84.865 Y101.949 E.00472
G1 X84.463 Y102.07 E.00826
G1 X84.071 Y102.111 E.00775
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.00779
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.978 E.00526
G1 X81.999 Y100.762 E.00472
G1 X81.872 Y100.361 E.00826
G1 X81.825 Y99.967 E.00781
G1 X81.848 Y99.574 E.00774
G1 X81.904 Y99.313 E.00525
G1 X81.981 Y99.086 E.00472
G1 X82.171 Y98.711 E.00826
G1 X82.415 Y98.396 E.00783
G1 X82.732 Y98.116 E.00833
G1 X83.046 Y97.923 E.00725
G1 X83.412 Y97.78 E.00772
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00527
G1 X84.331 Y97.71 E.00773
G1 X84.718 Y97.798 E.0078
G1 X85.079 Y97.953 E.00772
G1 X85.284 Y98.078 E.00472
G1 X85.513 Y98.258 E.00573
G1 X85.699 Y98.447 E.00522
G1 X85.863 Y98.658 E.00526
G1 X86.053 Y98.999 E.00767
G1 X86.147 Y99.249 E.00525
G1 X86.205 Y99.482 E.00472
G1 X86.246 Y99.9 E.00826
G1 X86.21 Y100.296 E.00781
G1 X86.121 Y100.617 E.00655
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.06208
G1 X85.875 Y101.125 E-.04559
G1 X85.61 Y101.452 E-.07983
G1 X85.31 Y101.707 E-.0749
G1 X85.083 Y101.847 E-.05073
G1 X84.865 Y101.949 E-.04559
G1 X84.758 Y101.981 E-.02128
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.278 Y96.12 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.1081
G1 X90.479 Y95.322 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.001 E.00383
G1 X90.772 Y94.877 E.00382
G1 X90.927 Y94.788 E.00378
G1 X91.12 Y94.732 E.00427
G1 X91.244 Y94.722 E.00263
G1 X91.844 Y94.854 E.01299
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.218 Y95.826 E.07938
G1 X91.566 Y96.206 E.01597
G1 X91.405 Y96.261 E.00362
G1 X91.114 Y96.297 E.00619
G1 X90.829 Y96.427 E.00665
G1 X90.637 Y96.472 E.00416
G1 X85.535 Y96.485 E.108
G1 X86.718 Y97.845 E.03815
G1 X86.825 Y97.992 E.00385
G1 X87.04 Y98.353 E.00888
G1 X87.266 Y98.91 E.01273
G1 X87.389 Y99.49 E.01254
G1 X87.414 Y99.891 E.00851
G1 X87.364 Y100.484 E.0126
G1 X87.208 Y101.066 E.01274
G1 X86.952 Y101.608 E.0127
G1 X86.605 Y102.096 E.01266
G1 X86.319 Y102.392 E.00872
G1 X86.04 Y102.621 E.00763
G1 X85.846 Y102.755 E.00499
G1 X85.526 Y102.933 E.00776
G1 X85.313 Y103.03 E.00495
G1 X84.919 Y103.164 E.00882
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.765 Y103.033 E.00863
G1 X82.358 Y102.834 E.00959
G1 X81.908 Y102.529 E.0115
G1 X81.606 Y102.251 E.00869
G1 X81.344 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.678 Y100.299 E.01256
G1 X80.656 Y99.939 E.00763
G1 X80.681 Y99.487 E.00958
G1 X80.753 Y99.095 E.00844
G1 X80.944 Y98.533 E.01256
G1 X81.108 Y98.213 E.00762
G1 X81.36 Y97.836 E.00959
G1 X82.538 Y96.482 E.03799
G1 X77.571 Y96.482 E.10513
G1 X77.323 Y96.453 E.00527
G1 X77.113 Y96.372 E.00477
G1 X76.915 Y96.222 E.00526
G1 X76.825 Y96.12 E.00288
G1 X76.731 Y95.957 E.00397
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.627 E.37968
G1 X76.691 Y77.353 E.00583
G1 X76.797 Y77.123 E.00536
G1 X76.897 Y76.997 E.00341
G1 X77.005 Y76.9 E.00308
G1 X77.234 Y76.775 E.00552
G1 X77.484 Y76.723 E.00539
G1 X90.517 Y76.721 E.27585
G1 X90.744 Y76.749 E.00486
G1 X90.883 Y76.794 E.00308
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.74 Y77.118 E.00533
G1 X77.463 Y77.248 E.00648
G1 X77.216 Y77.48 E.00717
G1 X77.066 Y77.758 E.00669
G1 X77.016 Y78.047 E.0062
G1 X77.016 Y95.155 E.36211
G1 X77.068 Y95.453 E.0064
G1 X77.255 Y95.777 E.00792
G1 X77.608 Y96.043 E.00936
G1 X77.969 Y96.12 E.00781
G1 X85.218 Y96.12 E.15343
; WIPE_START
M204 S6000
G1 X87.218 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.0182
G1 X87.167 Y97.767 E.0043
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.824 Y99.889 E.00885
G1 X87.803 Y100.29 E.00789
G1 X87.767 Y100.559 E.00534
G1 X87.675 Y100.952 E.00793
G1 X87.591 Y101.21 E.00535
G1 X87.431 Y101.58 E.00793
G1 X87.303 Y101.819 E.00534
G1 X87.05 Y102.197 E.00895
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.694 E.00892
G1 X86.286 Y102.948 E.00789
G1 X86.063 Y103.102 E.00535
G1 X85.711 Y103.299 E.00793
G1 X85.464 Y103.411 E.00534
G1 X85.033 Y103.557 E.00895
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.609 Y103.412 E.00889
G1 X82.157 Y103.191 E.00988
G1 X81.819 Y102.976 E.00789
G1 X81.645 Y102.842 E.00431
G1 X81.311 Y102.536 E.00891
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.302 Y100.557 E.00891
G1 X80.271 Y100.341 E.0043
G1 X80.247 Y99.94 E.00789
G1 X80.273 Y99.439 E.00988
G1 X80.354 Y98.997 E.00883
G1 X80.488 Y98.564 E.00891
G1 X80.572 Y98.361 E.00431
G1 X80.755 Y98.005 E.00789
G1 X81.034 Y97.587 E.00988
G1 X81.639 Y96.891 E.01815
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.896 Y96.721 E.00276
G1 X76.635 Y96.523 E.00643
G1 X76.499 Y96.369 E.00406
G1 X76.418 Y96.246 E.0029
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35363
G1 X76.263 Y77.392 E.0043
G1 X76.299 Y77.233 E.00321
G1 X76.376 Y77.036 E.00416
G1 X76.456 Y76.894 E.0032
G1 X76.597 Y76.716 E.00447
G1 X76.753 Y76.576 E.00412
G1 X76.888 Y76.485 E.0032
G1 X77.094 Y76.389 E.00446
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.541 Y76.311 E.2573
G1 X90.835 Y76.347 E.00581
G1 X91.045 Y76.417 E.00437
G1 X91.24 Y76.522 E.00436
G1 X91.472 Y76.717 E.00596
G1 X91.643 Y76.944 E.00558
G1 X91.746 Y77.161 E.00473
G1 X91.804 Y77.375 E.00435
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.019 Y77.491 E.24833
G1 X77.859 Y77.514 E.00319
G1 X77.695 Y77.591 E.00355
G1 X77.545 Y77.732 E.00406
G1 X77.458 Y77.894 E.00362
G1 X77.425 Y78.083 E.00376
G1 X77.425 Y95.119 E.3351
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.5 E.0043
G1 X77.782 Y95.662 E.00528
G1 X78.013 Y95.711 E.00463
G1 X90.022 Y95.711 E.23621
G1 X90.078 Y95.226 E.0096
G1 X90.173 Y94.967 E.00543
G1 X90.325 Y94.736 E.00544
G1 X90.526 Y94.547 E.00543
G1 X90.765 Y94.409 E.00542
G1 X91.046 Y94.327 E.00575
G1 X91.369 Y94.319 E.00637
G1 X91.76 Y94.413 E.0079
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.07441
G1 X91.748 Y96.574 E.008
G1 X91.612 Y96.629 E.00288
G1 X91.484 Y96.664 E.00262
G1 X91.227 Y96.695 E.00509
G1 X90.961 Y96.817 E.00575
G1 X90.685 Y96.881 E.00558
G1 X86.491 Y96.892 E.08248
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16854
G1 X87.167 Y97.767 E-.04154
G1 X87.401 Y98.159 E-.08667
G1 X87.495 Y98.356 E-.0416
G1 X87.573 Y98.561 E-.04164
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




G1 X86.037 Y97.654
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396433
G1 F1500
M204 S6000
G1 X85.903 Y97.527 E.00341
; LINE_WIDTH: 0.433954
G1 X85.751 Y97.384 E.00426
; LINE_WIDTH: 0.470083
G1 X85.5 Y97.171 E.00728
M204 S10000
M73 P55 R11
G1 X86.037 Y97.654 F18000
; LINE_WIDTH: 0.360087
G1 F1500
M204 S6000
G1 X86.298 Y97.936 E.00642
G1 X86.524 Y98.236 E.00626
G1 X86.76 Y98.658 E.00806
G1 X86.904 Y99.024 E.00656
G1 X86.943 Y99.171 E.00254
G1 X87.007 Y99.536 E.00618
G1 X87.036 Y99.89 E.00592
G1 X86.99 Y100.417 E.00882
G1 X86.852 Y100.933 E.00891
G1 X86.623 Y101.413 E.00888
G1 X86.313 Y101.845 E.00886
G1 X86.059 Y102.11 E.00612
G1 X85.783 Y102.338 E.00596
G1 X85.448 Y102.544 E.00656
G1 X85.136 Y102.69 E.00576
G1 X84.633 Y102.836 E.00874
G1 X84.107 Y102.9 E.00883
G1 X83.731 Y102.884 E.00627
G1 X83.341 Y102.817 E.0066
G1 X82.87 Y102.664 E.00827
G1 X82.395 Y102.411 E.00897
G1 X81.953 Y102.057 E.00945
G1 X81.648 Y101.716 E.00764
G1 X81.45 Y101.42 E.00594
G1 X81.272 Y101.066 E.00662
G1 X81.099 Y100.513 E.00965
G1 X81.039 Y100.005 E.00854
G1 X81.06 Y99.532 E.00791
G1 X81.123 Y99.188 E.00583
G1 X81.294 Y98.689 E.0088
G1 X81.498 Y98.304 E.00727
G1 X81.829 Y97.87 E.0091
G1 X82.039 Y97.656 E.005
; LINE_WIDTH: 0.407694
G1 X82.228 Y97.465 E.00512
; LINE_WIDTH: 0.444162
G1 X82.412 Y97.307 E.00506
; LINE_WIDTH: 0.47442
G1 X82.57 Y97.174 E.00463
; WIPE_START
G1 X82.412 Y97.307 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.419 Y96.244 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.148364
G1 F1500
M204 S6000
M73 P55 R10
G1 X77.059 Y95.965 E.00278
G1 X76.982 Y95.849 E.00085
G1 X76.882 Y95.627 E.00149
; WIPE_START
G1 X76.982 Y95.849 E-.11037
G1 X77.059 Y95.965 E-.06334
G1 X77.419 Y96.244 E-.2063
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.051 Y96.222 Z1.8 F18000
G1 X90.589 Y96.206 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.129913
G1 F1500
M204 S6000
G1 X90.744 Y96.179 E.00082
; LINE_WIDTH: 0.102199
G1 X90.912 Y96.131 E.00066
; WIPE_START
G1 X90.744 Y96.179 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.954 Y95.582 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.446 Y95.493 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X92.799 Y95.202 F18000
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
; WIPE_START
G1 X94.487 Y94.021 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.435 Y86.601 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.448 Y81.991 Z1.8 F18000
G1 X77.536 Y76.956 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0876651
G1 F1500
M204 S6000
G1 X77.429 Y76.99 E.00035
; LINE_WIDTH: 0.11518
G1 X77.307 Y77.033 E.00058
; LINE_WIDTH: 0.151592
G1 X77.105 Y77.193 E.00162
G1 X76.996 Y77.322 E.00106
G1 X76.944 Y77.429 E.00074
; LINE_WIDTH: 0.115818
G1 X76.918 Y77.51 E.00038
; LINE_WIDTH: 0.0906776
G1 X76.891 Y77.591 E.00028
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.918 Y77.51 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/49
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-.523 J1.099 P1  F18000
G1 X91.478 Y84.433 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.478 Y78.744 E.1204
G1 X95.391 Y78.744 E.08282
G1 X95.391 Y88.557 E.2077
G1 X91.478 Y88.557 E.08282
G1 X91.478 Y84.493 E.08603
M204 S10000
G1 X91.054 Y85.176 F18000
G1 F1500
M204 S500
G1 X91.054 Y77.12 E.17051
G1 X91.252 Y77.076 E.0043
G1 X91.361 Y77.303 E.00534
G1 X91.398 Y77.441 E.00303
G1 X91.453 Y78.32 E.01864
G1 X95.816 Y78.32 E.09233
G1 X95.816 Y88.982 E.22566
G1 X91.054 Y88.982 E.10078
G1 X91.054 Y85.236 E.07927
; WIPE_START
M204 S6000
G1 X91.054 Y83.236 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.954 Y90.868 Z1.92 F18000
G1 X90.895 Y95.42 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.923 Y95.344 E.00172
G1 X90.966 Y95.277 E.00169
G1 X91.088 Y95.179 E.0033
G1 X91.276 Y95.154 E.00402
G1 X92.165 Y95.367 E.01935
G1 X91.345 Y95.838 E.02001
G1 X90.838 Y95.903 E.01083
G1 X90.888 Y95.48 E.00903
; WIPE_START
M204 S6000
G1 X90.923 Y95.344 E-.02662
G1 X90.966 Y95.277 E-.01515
G1 X91.088 Y95.179 E-.02964
G1 X91.276 Y95.154 E-.03612
G1 X92.165 Y95.367 E-.17371
G1 X91.714 Y95.626 E-.09876
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.263 Y97.104 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01029
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01123
G1 X83.007 Y97.034 E.00804
G1 X82.807 Y97.12 E.00462
G1 X82.688 Y96.956 E.00429
G1 X83.046 Y96.544 E.01154
G1 X85.024 Y96.544 E.04187
G1 X85.37 Y96.942 E.01116
G1 X85.297 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09607
G1 X84.428 Y96.88 E-.07221
G1 X83.898 Y96.856 E-.1008
G1 X83.372 Y96.928 E-.10083
G1 X83.321 Y96.942 E-.0101
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.477 Y100.846 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.107 E.00604
M73 P56 R10
G1 X86.213 Y101.357 E.00616
G1 X85.905 Y101.739 E.01039
G1 X85.551 Y102.039 E.00981
G1 X85.277 Y102.208 E.0068
G1 X85.014 Y102.331 E.00615
G1 X84.544 Y102.473 E.01039
G1 X84.083 Y102.521 E.00981
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00684
G1 X83.004 Y102.312 E.00975
G1 X82.59 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.747 Y101.178 E.0068
G1 X81.62 Y100.917 E.00616
G1 X81.471 Y100.449 E.01039
G1 X81.414 Y99.979 E.01001
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00995
G1 X81.741 Y98.632 E.00976
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.112 E.00682
G1 X82.462 Y97.803 E.00975
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.461 Y97.344 E.00683
G1 X83.917 Y97.282 E.00975
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.206 Y98.432 E.00683
G1 X86.425 Y98.826 E.00955
G1 X86.539 Y99.129 E.00683
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.614 Y100.369 E.00995
G1 X86.498 Y100.79 E.00924
M204 S250
G1 X86.103 Y100.679 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00515
G1 X85.876 Y101.123 E.00467
G1 X85.61 Y101.452 E.00831
G1 X85.31 Y101.707 E.00775
G1 X85.082 Y101.847 E.00525
G1 X84.867 Y101.948 E.00467
G1 X84.463 Y102.07 E.00831
G1 X84.071 Y102.111 E.00776
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.00779
G1 X82.248 Y101.203 E.00774
G1 X82.104 Y100.978 E.00525
G1 X82 Y100.764 E.00467
G1 X81.872 Y100.362 E.00831
G1 X81.825 Y99.967 E.00781
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.0078
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.709 Y98.132 E.00774
G1 X83.043 Y97.925 E.00773
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00773
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00773
G1 X85.512 Y98.256 E.00773
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.053 Y98.999 E.00767
G1 X86.147 Y99.249 E.00526
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.296 E.00779
G1 X86.12 Y100.622 E.00666
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.06106
G1 X85.876 Y101.123 E-.04513
G1 X85.61 Y101.452 E-.08029
G1 X85.31 Y101.707 E-.07489
G1 X85.082 Y101.847 E-.05076
G1 X84.867 Y101.948 E-.04511
G1 X84.753 Y101.982 E-.02276
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.686 Y97.181 Z1.92 F18000
G1 X97.07 Y92.013 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.836 Y91.678 E.00866
G1 X97.558 Y91.172 E.01866
G1 X100.308 Y89.247 E.07105
G1 X102.739 Y92.719 E.08971
G1 X99.267 Y95.15 E.08971
G1 X97.105 Y92.062 E.07978
M204 S250
G1 X97.406 Y91.778 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.793 Y91.507 E.00929
G1 X100.207 Y89.817 E.05797
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
M204 S10000
G1 X96.723 Y92.256 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.826 Y95.26 E.0776
G1 X94.474 Y98.307 E.11245
G1 X92.229 Y95.102 E.08282
G1 X96.581 Y92.054 E.11246
G1 X96.688 Y92.207 E.00395
; WIPE_START
M204 S6000
G1 X97.835 Y93.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.325 Y95.206 Z1.92 F18000
G1 X85.278 Y96.12 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.386 Y96.12 E.1081
G1 X90.479 Y95.321 E.01702
G1 X90.541 Y95.152 E.00382
G1 X90.64 Y95.002 E.0038
G1 X90.783 Y94.868 E.00415
G1 X90.953 Y94.775 E.00409
G1 X91.146 Y94.729 E.00421
G1 X91.327 Y94.73 E.00382
G1 X91.844 Y94.854 E.01126
G1 X100.372 Y88.882 E.22035
G1 X103.103 Y92.783 E.10078
G1 X94.369 Y98.898 E.22566
G1 X92.219 Y95.826 E.07937
G1 X91.562 Y96.208 E.01607
G1 X91.405 Y96.261 E.00353
G1 X91.112 Y96.297 E.00624
G1 X90.843 Y96.423 E.00627
G1 X90.636 Y96.472 E.00452
G1 X85.535 Y96.485 E.10796
G1 X86.718 Y97.845 E.03814
G1 X86.825 Y97.992 E.00386
G1 X87.04 Y98.353 E.00888
G1 X87.266 Y98.91 E.01273
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.091 E.01273
G1 X87.333 Y100.633 E.0116
G1 X87.204 Y101.074 E.00971
G1 X86.952 Y101.609 E.01252
G1 X86.605 Y102.096 E.01266
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00868
G1 X85.678 Y102.855 E.00811
G1 X85.306 Y103.032 E.00872
G1 X84.969 Y103.148 E.00754
G1 X84.738 Y103.207 E.00506
G1 X84.327 Y103.269 E.0088
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01273
G1 X82.578 Y102.951 E.01273
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.344 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.88 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.754 Y99.086 E.00888
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.315 Y96.452 E.00546
G1 X77.106 Y96.367 E.00476
G1 X76.914 Y96.221 E.0051
G1 X76.825 Y96.12 E.00285
G1 X76.725 Y95.942 E.00432
G1 X76.683 Y95.814 E.00285
G1 X76.654 Y95.565 E.00531
G1 X76.654 Y77.619 E.37984
G1 X76.694 Y77.347 E.00581
G1 X76.797 Y77.123 E.00523
G1 X76.897 Y76.997 E.0034
G1 X77.004 Y76.901 E.00305
G1 X77.236 Y76.775 E.00559
G1 X77.487 Y76.723 E.00542
G1 X90.518 Y76.721 E.27582
G1 X90.744 Y76.749 E.00483
G1 X90.874 Y76.791 E.00289
G1 X91.05 Y76.893 E.0043
G1 X90.999 Y77.082 E.00413
G1 X77.99 Y77.082 E.27536
G1 X77.731 Y77.119 E.00553
G1 X77.429 Y77.271 E.00717
G1 X77.205 Y77.495 E.00669
G1 X77.053 Y77.797 E.00717
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.255 Y95.777 E.00792
G1 X77.607 Y96.043 E.00935
G1 X77.969 Y96.12 E.00783
G1 X85.218 Y96.12 E.15344
; WIPE_START
M204 S6000
G1 X87.218 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y96.892 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.0182
G1 X87.167 Y97.767 E.0043
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00874
G1 X87.732 Y100.726 E.00779
G1 X87.59 Y101.213 E.00998
G1 X87.433 Y101.576 E.00778
G1 X87.303 Y101.819 E.00543
G1 X87.05 Y102.197 E.00895
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.693 E.00891
G1 X86.246 Y102.979 E.00891
G1 X86.061 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.461 Y103.412 E.00892
G1 X85.086 Y103.541 E.0078
G1 X84.819 Y103.609 E.00543
G1 X84.369 Y103.676 E.00894
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.113 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.355 Y98.994 E.00897
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.587 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X77.097 Y96.814 E.00277
G1 X76.894 Y96.719 E.0044
G1 X76.634 Y96.522 E.00641
G1 X76.418 Y96.246 E.00689
G1 X76.345 Y96.096 E.00329
G1 X76.281 Y95.902 E.00402
G1 X76.245 Y95.589 E.0062
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00449
G1 X76.375 Y77.037 E.00408
G1 X76.456 Y76.894 E.00323
G1 X76.597 Y76.716 E.00447
G1 X76.752 Y76.577 E.00408
G1 X76.888 Y76.485 E.00324
G1 X77.094 Y76.389 E.00447
G1 X77.295 Y76.334 E.00408
G1 X77.461 Y76.313 E.00329
G1 X90.543 Y76.311 E.25732
G1 X90.835 Y76.347 E.00577
G1 X91.042 Y76.416 E.00431
G1 X91.307 Y76.569 E.00601
G1 X91.471 Y76.715 E.00431
G1 X91.642 Y76.942 E.00561
G1 X91.746 Y77.161 E.00476
G1 X91.804 Y77.375 E.00435
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.02 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.607 E.00406
G1 X77.541 Y77.738 E.00362
G1 X77.449 Y77.922 E.00406
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.5 E.0043
G1 X77.782 Y95.661 E.00527
G1 X78.012 Y95.711 E.00464
G1 X90.022 Y95.711 E.23621
G1 X90.078 Y95.226 E.0096
G1 X90.173 Y94.967 E.00543
G1 X90.325 Y94.736 E.00543
G1 X90.534 Y94.541 E.00563
G1 X90.824 Y94.385 E.00648
G1 X91.099 Y94.32 E.00556
G1 X91.375 Y94.321 E.00543
G1 X91.76 Y94.413 E.00778
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.07441
G1 X91.743 Y96.576 E.00811
G1 X91.612 Y96.629 E.00277
G1 X91.484 Y96.664 E.00262
G1 X91.226 Y96.696 E.0051
G1 X90.978 Y96.811 E.00538
G1 X90.684 Y96.881 E.00595
G1 X86.491 Y96.892 E.08247
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16853
G1 X87.167 Y97.767 E-.04155
G1 X87.401 Y98.159 E-.08667
G1 X87.495 Y98.356 E-.0416
G1 X87.573 Y98.561 E-.04165
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




G1 X86.028 Y97.645
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360441
G1 F1500
M204 S6000
G1 X86.298 Y97.936 E.00664
G1 X86.524 Y98.236 E.00627
M73 P57 R10
G1 X86.769 Y98.665 E.00824
G1 X86.944 Y99.177 E.00903
G1 X87.008 Y99.536 E.0061
G1 X87.036 Y99.903 E.00615
G1 X86.982 Y100.451 E.00918
G1 X86.848 Y100.942 E.00851
G1 X86.623 Y101.414 E.00872
G1 X86.313 Y101.845 E.00887
G1 X86.06 Y102.109 E.0061
G1 X85.777 Y102.344 E.00615
G1 X85.466 Y102.536 E.00611
G1 X85.138 Y102.689 E.00603
G1 X84.634 Y102.84 E.00879
G1 X84.107 Y102.9 E.00886
G1 X83.731 Y102.884 E.00628
G1 X83.341 Y102.818 E.00661
G1 X82.843 Y102.652 E.00876
G1 X82.395 Y102.412 E.00849
G1 X81.974 Y102.078 E.00898
G1 X81.648 Y101.716 E.00813
G1 X81.45 Y101.42 E.00594
G1 X81.273 Y101.068 E.00658
G1 X81.106 Y100.544 E.00919
G1 X81.041 Y100.069 E.008
G1 X81.046 Y99.704 E.0061
G1 X81.129 Y99.175 E.00894
G1 X81.3 Y98.681 E.00874
G1 X81.46 Y98.365 E.00591
G1 X81.66 Y98.071 E.00594
G1 X82.029 Y97.664 E.00917
; LINE_WIDTH: 0.402094
G1 X82.203 Y97.487 E.00466
; LINE_WIDTH: 0.43878
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.475187
G1 X82.579 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.338 Y97.375 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.433769
G1 F1500
M204 S6000
G1 X85.5 Y97.34 E.00337
; LINE_WIDTH: 0.468491
G1 X85.661 Y97.304 E.00365
; LINE_WIDTH: 0.468069
G1 X85.785 Y97.419 E.00372
; LINE_WIDTH: 0.432764
G1 X85.906 Y97.532 E.00337
; LINE_WIDTH: 0.397705
G1 X86.028 Y97.645 E.00308
; WIPE_START
G1 X85.906 Y97.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.589 Y96.206 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.128126
G1 F1500
M204 S6000
G1 X90.757 Y96.176 E.00087
; LINE_WIDTH: 0.100792
G1 X90.913 Y96.131 E.0006
; WIPE_START
G1 X90.757 Y96.176 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.954 Y95.582 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X96.052 Y94.814 E.02239
; WIPE_START
G1 X94.954 Y95.582 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.446 Y95.493 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X94.865 Y96.09 E.01434
G1 X96.609 Y94.869 E.04188
G1 X96.19 Y94.272 E.01434
G1 X94.495 Y95.458 E.0407
M204 S10000
G1 X93.897 Y95.396 F18000
G1 F1500
M204 S6000
G1 X94.768 Y96.639 E.02985
G1 X97.158 Y94.966 E.05739
G1 X96.287 Y93.722 E.02985
G1 X93.946 Y95.362 E.05621
M204 S10000
G1 X93.348 Y95.299 F18000
G1 F1500
M204 S6000
G1 X94.671 Y97.188 E.04536
G1 X97.707 Y95.062 E.07289
G1 X96.384 Y93.173 E.04536
G1 X93.397 Y95.265 E.07171
M204 S10000
G1 X92.799 Y95.202 F18000
G1 F1500
M204 S6000
G1 X94.574 Y97.737 E.06087
G1 X98.256 Y95.159 E.0884
G1 X96.481 Y92.624 E.06087
G1 X92.848 Y95.168 E.08722
; WIPE_START
G1 X94.487 Y94.021 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.435 Y86.601 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X93.435 Y80.761 E.09757
; WIPE_START
G1 X93.435 Y82.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y86.965 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.799 Y86.965 E.01434
G1 X93.799 Y80.336 E.13039
G1 X93.07 Y80.336 E.01434
G1 X93.07 Y86.905 E.12921
M204 S10000
G1 X92.676 Y87.36 F18000
G1 F1500
M204 S6000
G1 X94.194 Y87.36 E.02985
G1 X94.194 Y79.942 E.14589
G1 X92.676 Y79.942 E.02985
G1 X92.676 Y87.3 E.14471
M204 S10000
G1 X92.282 Y87.754 F18000
G1 F1500
M204 S6000
G1 X94.588 Y87.754 E.04536
G1 X94.588 Y79.548 E.1614
G1 X92.282 Y79.548 E.04536
G1 X92.282 Y87.694 E.16022
M204 S10000
G1 X91.887 Y88.148 F18000
G1 F1500
M204 S6000
G1 X94.982 Y88.148 E.06087
G1 X94.982 Y79.154 E.17691
G1 X91.887 Y79.154 E.06087
G1 X91.887 Y88.088 E.17573
; WIPE_START
G1 X91.887 Y86.088 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.65 Y90.487 Z1.92 F18000
G1 X77.469 Y96.256 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153618
G1 F1500
M204 S6000
G1 X77.106 Y96.015 E.00279
G1 X77.044 Y95.956 E.00054
G1 X76.978 Y95.841 E.00084
; LINE_WIDTH: 0.128061
G1 X76.937 Y95.732 E.0006
; LINE_WIDTH: 0.0943591
G1 X76.896 Y95.622 E.0004
; WIPE_START
G1 X76.937 Y95.732 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.917 Y88.099 Z1.92 F18000
G1 X76.889 Y77.604 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.089882
G1 F1500
M204 S6000
G1 X76.918 Y77.513 E.00031
; LINE_WIDTH: 0.1155
G1 X76.947 Y77.421 E.00043
; LINE_WIDTH: 0.152476
G1 X76.991 Y77.329 E.00065
G1 X77.105 Y77.193 E.00113
G1 X77.228 Y77.082 E.00104
; LINE_WIDTH: 0.128314
G1 X77.432 Y76.991 E.00114
; LINE_WIDTH: 0.0894141
G1 X77.539 Y76.955 E.00036
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.432 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/49
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-.724 J.978 P1  F18000
G1 X97.406 Y91.778 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.207 Y89.817 E.06727
G1 X102.169 Y92.618 E.06727
G1 X99.367 Y94.58 E.06727
G1 X97.44 Y91.827 E.06609
; WIPE_START
M204 S6000
G1 X99.058 Y90.652 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.143 Y93.882 Z2.04 F18000
G1 X85.253 Y97.101 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01007
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00804
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.045 Y96.544 E.01174
G1 X85.014 Y96.544 E.04167
G1 X85.36 Y96.938 E.0111
G1 X85.286 Y97.05 E.00284
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09406
G1 X84.428 Y96.88 E-.07221
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07217
G1 X83.312 Y96.948 E-.04373
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.482 Y100.823 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.425 Y100.975 E.00343
G1 X86.201 Y101.378 E.00976
G1 X85.902 Y101.741 E.00994
G1 X85.551 Y102.039 E.00976
G1 X85.278 Y102.208 E.0068
G1 X85.017 Y102.33 E.0061
G1 X84.544 Y102.473 E.01044
G1 X84.083 Y102.521 E.00982
G1 X83.762 Y102.507 E.0068
G1 X83.478 Y102.461 E.0061
G1 X83.007 Y102.313 E.01044
G1 X82.59 Y102.089 E.01001
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00994
G1 X81.677 Y101.046 E.00976
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00682
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00995
G1 X81.741 Y98.633 E.00975
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.462 Y97.803 E.00975
G1 X82.862 Y97.556 E.00995
M73 P58 R10
G1 X83.291 Y97.388 E.00975
G1 X83.606 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.789 Y97.953 E.00994
G1 X86.102 Y98.29 E.00975
G1 X86.284 Y98.557 E.00683
G1 X86.429 Y98.835 E.00663
G1 X86.539 Y99.129 E.00664
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00683
G1 X86.503 Y100.767 E.00213
M204 S250
G1 X86.099 Y100.68 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.053 Y100.803 E.00259
G1 X85.861 Y101.146 E.00774
G1 X85.61 Y101.452 E.00779
G1 X85.31 Y101.707 E.00774
G1 X85.083 Y101.847 E.00525
G1 X84.87 Y101.947 E.00462
G1 X84.463 Y102.07 E.00836
G1 X84.071 Y102.111 E.00776
G1 X83.804 Y102.099 E.00525
G1 X83.572 Y102.062 E.00463
G1 X83.167 Y101.934 E.00836
G1 X82.817 Y101.746 E.00782
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00779
G1 X82.044 Y100.863 E.00774
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.0078
G1 X82.103 Y98.827 E.00773
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.709 Y98.132 E.00773
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00773
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00773
G1 X85.514 Y98.258 E.00779
G1 X85.782 Y98.546 E.00774
G1 X85.932 Y98.767 E.00526
G1 X86.054 Y99.002 E.0052
G1 X86.147 Y99.249 E.0052
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.12 Y100.623 E.00149
; WIPE_START
M204 S6000
G1 X86.053 Y100.803 E-.0364
G1 X85.861 Y101.146 E-.07474
G1 X85.61 Y101.452 E-.07529
G1 X85.31 Y101.707 E-.07473
G1 X85.083 Y101.847 E-.05071
G1 X84.87 Y101.947 E-.04466
G1 X84.752 Y101.983 E-.02347
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.267 Y96.12 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X87.835 Y96.12 E.05435
G1 X87.704 Y96.479 E.0081
G1 X85.527 Y96.485 E.04609
G1 X86.681 Y97.8 E.03704
G1 X86.827 Y97.996 E.00515
G1 X87.04 Y98.353 E.0088
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.415 Y99.899 E.00888
G1 X87.393 Y100.283 E.00814
G1 X87.334 Y100.629 E.00743
G1 X87.204 Y101.074 E.00981
G1 X86.951 Y101.61 E.01255
G1 X86.603 Y102.099 E.0127
G1 X86.319 Y102.392 E.00864
G1 X85.846 Y102.755 E.01262
G1 X85.311 Y103.031 E.01273
G1 X84.738 Y103.207 E.0127
G1 X84.327 Y103.269 E.0088
G1 X83.734 Y103.267 E.01254
G1 X83.328 Y103.206 E.00869
G1 X82.959 Y103.105 E.00811
G1 X82.578 Y102.951 E.00869
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.88 E.00849
G1 X80.678 Y100.299 E.01256
G1 X80.657 Y99.948 E.00744
G1 X80.681 Y99.486 E.00978
G1 X80.753 Y99.094 E.00845
G1 X80.945 Y98.531 E.01259
G1 X81.132 Y98.17 E.00861
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.335 Y96.454 E.00502
G1 X77.117 Y96.372 E.00494
G1 X77.004 Y96.302 E.00282
G1 X76.824 Y96.119 E.00543
G1 X76.773 Y96.041 E.00197
G1 X76.683 Y95.812 E.0052
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.897 Y76.997 E.00347
G1 X77.003 Y76.901 E.00301
G1 X77.234 Y76.775 E.00558
G1 X77.484 Y76.723 E.00539
G1 X88.843 Y76.721 E.24044
G1 X88.843 Y77.082 E.00763
G1 X77.99 Y77.082 E.22973
G1 X77.731 Y77.12 E.00553
G1 X77.429 Y77.272 E.00717
G1 X77.207 Y77.493 E.00663
G1 X77.057 Y77.787 E.00698
G1 X77.016 Y78.053 E.0057
G1 X77.016 Y95.155 E.36198
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00951
G1 X77.972 Y96.12 E.00767
G1 X85.207 Y96.12 E.15315
; WIPE_START
M204 S6000
G1 X87.207 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.429 Y96.892 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87 Y97.543 E.01703
G1 X87.168 Y97.768 E.00552
G1 X87.401 Y98.159 E.00895
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.335 E.00874
G1 X87.733 Y100.721 E.0077
G1 X87.59 Y101.213 E.01008
G1 X87.435 Y101.572 E.00768
G1 X87.303 Y101.82 E.00553
G1 X87.085 Y102.148 E.00774
G1 X86.911 Y102.368 E.00552
G1 X86.597 Y102.693 E.0089
G1 X86.294 Y102.942 E.00771
G1 X86.063 Y103.102 E.00553
G1 X85.719 Y103.294 E.00774
G1 X85.463 Y103.411 E.00554
G1 X85.091 Y103.539 E.00774
G1 X84.819 Y103.609 E.00552
G1 X84.369 Y103.676 E.00895
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.302 Y100.557 E.00891
G1 X80.247 Y99.95 E.012
G1 X80.273 Y99.439 E.01007
G1 X80.355 Y98.997 E.00884
G1 X80.469 Y98.622 E.00771
G1 X80.572 Y98.361 E.00552
G1 X80.78 Y97.96 E.00889
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.239 Y96.855 E.00611
G1 X76.935 Y96.741 E.00638
G1 X76.652 Y96.541 E.00681
G1 X76.499 Y96.369 E.00454
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.02 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.597 Y76.716 E.00449
G1 X76.75 Y76.578 E.00405
G1 X76.888 Y76.485 E.00327
G1 X77.094 Y76.389 E.00446
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.545 Y76.312 E.25737
G1 X90.834 Y76.347 E.00574
G1 X91.044 Y76.417 E.00435
G1 X91.258 Y76.535 E.00479
G1 X91.472 Y76.716 E.00552
G1 X91.653 Y76.959 E.00596
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.838 Y77.911 E.01057
G1 X96.225 Y77.911 E.08629
G1 X96.225 Y89.391 E.2258
G1 X90.645 Y89.391 E.10975
G1 X90.645 Y77.491 E.23406
G1 X78.019 Y77.491 E.24833
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.608 E.00406
G1 X77.542 Y77.737 E.0036
G1 X77.451 Y77.915 E.00393
G1 X77.425 Y78.085 E.00338
G1 X77.425 Y95.119 E.33506
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00452
G1 X90.022 Y95.711 E.23619
G1 X90.078 Y95.226 E.00959
G1 X90.173 Y94.967 E.00544
G1 X90.325 Y94.736 E.00544
G1 X90.526 Y94.547 E.00543
G1 X90.766 Y94.409 E.00544
G1 X91.034 Y94.329 E.00551
G1 X91.369 Y94.319 E.00659
G1 X91.76 Y94.413 E.0079
G1 X100.472 Y88.312 E.20919
G1 X103.673 Y92.883 E.10975
G1 X94.269 Y99.468 E.2258
G1 X92.099 Y96.369 E.0744
G1 X91.737 Y96.579 E.00824
G1 X91.613 Y96.629 E.00263
G1 X91.483 Y96.664 E.00263
G1 X91.226 Y96.696 E.0051
G1 X90.978 Y96.811 E.00537
G1 X90.684 Y96.881 E.00595
G1 X86.489 Y96.892 E.08252
; WIPE_START
M204 S6000
G1 X87 Y97.543 E-.15728
G1 X87.168 Y97.768 E-.05336
G1 X87.401 Y98.159 E-.08642
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04134
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




G1 X86.037 Y97.654
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.394454
G1 F1500
M204 S6000
G1 X85.912 Y97.538 E.00313
; LINE_WIDTH: 0.429634
G1 X85.787 Y97.422 E.00343
; LINE_WIDTH: 0.466153
G1 X85.652 Y97.298 E.00402
; LINE_WIDTH: 0.47272
G1 X85.49 Y97.336 E.00373
; LINE_WIDTH: 0.44734
G1 X85.327 Y97.375 E.00352
M204 S10000
G1 X86.037 Y97.654 F18000
; LINE_WIDTH: 0.360297
G1 F1500
M204 S6000
G1 X86.391 Y98.044 E.0088
G1 X86.603 Y98.355 E.00628
G1 X86.767 Y98.674 E.00598
G1 X86.904 Y99.027 E.00632
G1 X87.008 Y99.527 E.00853
G1 X87.036 Y99.903 E.00631
G1 X86.985 Y100.434 E.00889
G1 X86.845 Y100.942 E.0088
G1 X86.62 Y101.414 E.00874
G1 X86.31 Y101.849 E.00891
G1 X86.059 Y102.11 E.00605
G1 X85.763 Y102.352 E.00638
G1 X85.449 Y102.544 E.00615
G1 X85.141 Y102.688 E.00567
G1 X84.635 Y102.84 E.00883
G1 X84.082 Y102.895 E.00926
G1 X83.733 Y102.884 E.00583
G1 X83.243 Y102.79 E.00832
G1 X82.847 Y102.652 E.007
G1 X82.395 Y102.412 E.00855
G1 X81.973 Y102.078 E.00898
G1 X81.648 Y101.716 E.00812
G1 X81.453 Y101.418 E.00594
G1 X81.289 Y101.103 E.00594
G1 X81.165 Y100.769 E.00594
G1 X81.102 Y100.522 E.00426
G1 X81.039 Y100.005 E.00868
G1 X81.06 Y99.531 E.00793
G1 X81.126 Y99.187 E.00584
G1 X81.297 Y98.687 E.00883
G1 X81.46 Y98.365 E.00602
G1 X81.66 Y98.071 E.00594
G1 X82.029 Y97.664 E.00916
; LINE_WIDTH: 0.40216
G1 X82.203 Y97.487 E.00466
; LINE_WIDTH: 0.438165
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473065
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z2.04 F18000
G1 Z1.64
M73 P59 R10
G1 E.4 F1800
; LINE_WIDTH: 0.139416
G1 F1500
M204 S6000
G1 X77.243 Y96.119 E.00153
; LINE_WIDTH: 0.148605
G1 X77.042 Y95.954 E.0016
G1 X76.882 Y95.627 E.00223
; WIPE_START
G1 X77.042 Y95.954 E-.22148
G1 X77.243 Y96.119 E-.15852
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.875 Y96.223 Z2.04 F18000
G1 X88.344 Y96.27 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.634092
G1 F1500
M204 S6000
G1 X88.268 Y96.27 E.00231
G1 X88.23 Y96.336 E.00231
G1 X88.268 Y96.402 E.00231
G1 X88.344 Y96.402 E.00231
G1 X88.352 Y96.388 E.00049
; WIPE_START
G1 X88.344 Y96.402 E-.01903
G1 X88.268 Y96.402 E-.09024
G1 X88.23 Y96.336 E-.09024
G1 X88.268 Y96.27 E-.09024
G1 X88.344 Y96.27 E-.09024
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.186 Y92.886 Z2.04 F18000
G1 X101.295 Y89.865 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X100.198 Y88.769 E.0305
G1 X99.87 Y88.999
G1 X102.597 Y91.725 E.07584
; WIPE_START
M204 S6000
G1 X101.183 Y90.311 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X101.267 Y90.953 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X103.238 Y92.923 E.05481
G1 X102.91 Y93.153
G1 X102.446 Y92.689 E.01291
G1 X102.118 Y92.918
G1 X102.582 Y93.383 E.01291
G1 X102.254 Y93.612
G1 X101.79 Y93.148 E.01291
G1 X101.462 Y93.378
G1 X101.926 Y93.842 E.01291
G1 X101.598 Y94.071
G1 X101.134 Y93.607 E.01291
G1 X100.806 Y93.837
G1 X101.27 Y94.301 E.01291
G1 X100.942 Y94.531
G1 X100.478 Y94.067 E.01291
G1 X100.15 Y94.296
G1 X100.614 Y94.76 E.01291
G1 X100.286 Y94.99
G1 X99.822 Y94.526 E.01291
G1 X99.494 Y94.755
G1 X99.958 Y95.219 E.01291
; WIPE_START
M204 S6000
G1 X99.494 Y94.755 E-.12469
G1 X99.822 Y94.526 E-.07606
G1 X100.286 Y94.99 E-.12469
G1 X100.522 Y94.825 E-.05455
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.007 Y89.692 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X99.543 Y89.228 E.01291
G1 X99.215 Y89.458
G1 X99.679 Y89.922 E.01291
G1 X99.351 Y90.151
G1 X98.887 Y89.687 E.01291
G1 X98.559 Y89.917
G1 X99.023 Y90.381 E.01291
G1 X98.695 Y90.611
G1 X98.231 Y90.147 E.01291
G1 X97.903 Y90.376
G1 X98.367 Y90.84 E.01291
G1 X98.039 Y91.07
G1 X97.575 Y90.606 E.01291
G1 X97.247 Y90.835
G1 X97.711 Y91.3 E.01291
G1 X97.383 Y91.529
G1 X96.919 Y91.065 E.01291
G1 X96.591 Y91.295
G1 X97.295 Y91.998 E.01958
; WIPE_START
M204 S6000
G1 X96.591 Y91.295 E-.1891
G1 X96.919 Y91.065 E-.07606
G1 X97.347 Y91.492 E-.11484
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.597 Y93.858 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X96.263 Y91.524 E.06492
G1 X95.935 Y91.754
G1 X99.631 Y95.449 E.10279
G1 X99.303 Y95.679
G1 X95.607 Y91.984 E.10278
G1 X95.28 Y92.213
G1 X98.975 Y95.908 E.10279
G1 X98.647 Y96.138
G1 X94.952 Y92.443 E.10278
G1 X94.624 Y92.672
G1 X98.319 Y96.368 E.10279
G1 X97.991 Y96.597
G1 X94.296 Y92.902 E.10279
G1 X93.968 Y93.132
G1 X97.663 Y96.827 E.10279
G1 X97.335 Y97.056
G1 X93.64 Y93.361 E.10279
G1 X93.312 Y93.591
G1 X97.007 Y97.286 E.10279
G1 X96.679 Y97.516
G1 X92.984 Y93.82 E.10279
G1 X92.656 Y94.05
G1 X96.351 Y97.745 E.10279
G1 X96.023 Y97.975
G1 X92.328 Y94.28 E.10279
G1 X92 Y94.509
G1 X95.695 Y98.204 E.10279
G1 X95.368 Y98.434
G1 X91.509 Y94.576 E.10733
G1 X90.955 Y94.579
G1 X95.04 Y98.664 E.11363
G1 X94.712 Y98.893
G1 X92.775 Y96.957 E.05386
G1 X91.997 Y96.178
G1 X90.597 Y94.778 E.03895
G1 X90.357 Y95.096
G1 X91.644 Y96.383 E.0358
G1 X91.185 Y96.482
G1 X90.258 Y95.555 E.02579
G1 X90.073 Y95.928
G1 X90.781 Y96.635 E.01967
G1 X90.208 Y96.62
G1 X89.516 Y95.928 E.01926
G1 X88.958 Y95.928
G1 X89.651 Y96.62 E.01926
G1 X89.093 Y96.62
G1 X88.597 Y96.124 E.0138
; WIPE_START
M204 S6000
G1 X89.093 Y96.62 E-.13333
G1 X89.651 Y96.62 E-.10593
G1 X89.127 Y96.096 E-.14074
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.273 Y93.416 Z2.04 F18000
G1 X97.867 Y92.818 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0918983
G1 F1500
M204 S6000
G1 X97.708 Y92.629 E.00081
; LINE_WIDTH: 0.129579
G1 X97.549 Y92.44 E.00128
; LINE_WIDTH: 0.167259
G1 X97.391 Y92.251 E.00174
; LINE_WIDTH: 0.20494
G1 X97.232 Y92.062 E.00221
; WIPE_START
G1 X97.391 Y92.251 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.439 Y99.109 Z2.04 F18000
M73 P59 R9
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.275535
G1 F1500
M204 S6000
G1 X94.252 Y98.886 E.00362
; LINE_WIDTH: 0.23054
G1 X94.066 Y98.664 E.00297
; LINE_WIDTH: 0.185545
G1 X93.879 Y98.442 E.00231
; LINE_WIDTH: 0.14055
G1 X93.692 Y98.219 E.00166
; LINE_WIDTH: 0.0955552
G1 X93.506 Y97.997 E.00101
; WIPE_START
G1 X93.692 Y98.219 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.169 Y94.678 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0918986
G1 F1500
M204 S6000
G1 X99.01 Y94.489 E.00081
; LINE_WIDTH: 0.12958
G1 X98.851 Y94.3 E.00128
; LINE_WIDTH: 0.167262
G1 X98.693 Y94.11 E.00174
; LINE_WIDTH: 0.204944
G1 X98.534 Y93.921 E.00221
; WIPE_START
G1 X98.693 Y94.11 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X102.52 Y92.615 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.175163
G1 F1500
M204 S6000
G1 X102.346 Y92.408 E.00202
; LINE_WIDTH: 0.134321
G1 X102.172 Y92.2 E.00147
; LINE_WIDTH: 0.0934787
G1 X101.998 Y91.993 E.00091
; WIPE_START
G1 X102.172 Y92.2 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X103.169 Y92.545 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0890831
G1 F1500
M204 S6000
G1 X103.043 Y92.395 E.00062
; LINE_WIDTH: 0.121134
G1 X102.917 Y92.245 E.00093
; LINE_WIDTH: 0.158826
G1 X102.726 Y92.017 E.00198
; LINE_WIDTH: 0.202123
G1 X102.534 Y91.788 E.00262
; WIPE_START
G1 X102.726 Y92.017 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X101.331 Y90.89 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.20493
G1 F1500
M204 S6000
G1 X101.172 Y90.701 E.00221
; LINE_WIDTH: 0.167252
G1 X101.013 Y90.511 E.00174
; LINE_WIDTH: 0.129575
G1 X100.854 Y90.322 E.00128
; LINE_WIDTH: 0.0918966
G1 X100.696 Y90.133 E.00081
; WIPE_START
G1 X100.854 Y90.322 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X101.867 Y90.685 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0878625
G1 F1500
M204 S6000
G1 X101.75 Y90.546 E.00056
; LINE_WIDTH: 0.117472
G1 X101.633 Y90.407 E.00083
; LINE_WIDTH: 0.155167
G1 X101.432 Y90.168 E.00202
; LINE_WIDTH: 0.200903
G1 X101.232 Y89.929 E.00273
; WIPE_START
G1 X101.432 Y90.168 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.564 Y88.825 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0914556
G1 F1500
M204 S6000
G1 X100.386 Y88.613 E.00091
; WIPE_START
G1 X100.564 Y88.825 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.202 Y93.041 Z2.04 F18000
G1 X88.772 Y96.64 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0878526
G1 F1500
M204 S6000
G1 X88.683 Y96.516 E.00047
M204 S10000
G1 X88.933 Y95.953 F18000
; LINE_WIDTH: 0.115389
G1 F1500
M204 S6000
G1 X88.565 Y95.953 E.00165
; WIPE_START
G1 X88.933 Y95.953 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.873 Y88.909 Z2.04 F18000
G1 X96.008 Y79.003 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X95.133 Y78.128 E.02435
G1 X94.575 Y78.128
G1 X96.008 Y79.561 E.03986
G1 X96.008 Y80.118
G1 X94.018 Y78.128 E.05537
G1 X93.46 Y78.128
G1 X96.008 Y80.676 E.07087
G1 X96.008 Y81.233
G1 X92.902 Y78.128 E.08638
G1 X92.345 Y78.128
G1 X96.008 Y81.791 E.10189
G1 X96.008 Y82.348
G1 X91.787 Y78.128 E.1174
G1 X91.624 Y77.964
G1 X90.241 Y76.582 E.03845
G1 X90.376 Y77.274
G1 X89.684 Y76.582 E.01926
G1 X89.265 Y76.72
G1 X89.819 Y77.274 E.01541
G1 X90.862 Y77.759
G1 X96.008 Y82.906 E.14315
G1 X96.008 Y83.463
G1 X90.862 Y78.317 E.14315
G1 X90.862 Y78.875
G1 X96.008 Y84.021 E.14315
G1 X96.008 Y84.578
G1 X90.862 Y79.432 E.14315
G1 X90.862 Y79.99
G1 X96.008 Y85.136 E.14315
G1 X96.008 Y85.694
G1 X90.862 Y80.547 E.14315
G1 X90.862 Y81.105
G1 X96.008 Y86.251 E.14315
G1 X96.008 Y86.809
G1 X90.862 Y81.662 E.14315
G1 X90.862 Y82.22
G1 X96.008 Y87.366 E.14315
G1 X96.008 Y87.924
G1 X90.862 Y82.777 E.14315
G1 X90.862 Y83.335
G1 X96.008 Y88.481 E.14315
G1 X96.008 Y89.039
G1 X93.615 Y86.646 E.06655
G1 X93.389 Y86.42
G1 X90.862 Y83.892 E.07031
G1 X90.862 Y84.45
G1 X95.586 Y89.174 E.13141
G1 X95.028 Y89.174
G1 X90.862 Y85.007 E.1159
G1 X90.862 Y85.565
G1 X94.471 Y89.174 E.10039
G1 X93.913 Y89.174
G1 X90.862 Y86.123 E.08488
G1 X90.862 Y86.68
G1 X93.356 Y89.174 E.06937
G1 X92.798 Y89.174
G1 X90.862 Y87.238 E.05386
G1 X90.862 Y87.795
G1 X92.24 Y89.174 E.03835
G1 X91.683 Y89.174
G1 X90.862 Y88.353 E.02285
; WIPE_START
M204 S6000
G1 X91.683 Y89.174 E-.22069
G1 X92.24 Y89.174 E-.10593
G1 X92.042 Y88.975 E-.05338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.873 Y81.433 Z2.04 F18000
G1 X90.121 Y76.583 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0827758
G1 F1500
M204 S6000
G1 X89.985 Y76.604 E.00039
; WIPE_START
G1 X90.121 Y76.583 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.618 Y77.556 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.331134
G1 F1500
M204 S6000
G1 X91.475 Y77.353 E.00378
; LINE_WIDTH: 0.358252
G1 X91.333 Y77.15 E.00412
; LINE_WIDTH: 0.391729
G1 X91.042 Y76.847 E.00766
; LINE_WIDTH: 0.363385
G1 X90.662 Y76.562 E.008
M204 S10000
G1 X90.632 Y77.251 F18000
; LINE_WIDTH: 0.0827753
G1 F1500
M204 S6000
G1 X90.497 Y77.272 E.00039
; WIPE_START
G1 X90.632 Y77.251 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.108 Y77.241 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X89.107 Y76.985 E.00434
G1 X89.152 Y76.728 E.00443
; WIPE_START
G1 X89.107 Y76.985 E-.19189
M73 P60 R9
G1 X89.108 Y77.241 E-.18811
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.478 Y77.053 Z2.04 F18000
G1 X77.539 Y76.955 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0894129
G1 F1500
M204 S6000
G1 X77.431 Y76.991 E.00036
; LINE_WIDTH: 0.128265
G1 X77.228 Y77.082 E.00114
; LINE_WIDTH: 0.152856
G1 X76.997 Y77.32 E.0021
G1 X76.947 Y77.424 E.00073
; LINE_WIDTH: 0.115296
G1 X76.918 Y77.513 E.00042
; LINE_WIDTH: 0.0898038
G1 X76.889 Y77.602 E.0003
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X76.918 Y77.513 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/49
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I-1.12 J.477 P1  F18000
G1 X85.263 Y97.104 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01029
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01124
G1 X83.008 Y97.034 E.00804
G1 X82.807 Y97.12 E.00462
G1 X82.687 Y96.956 E.00429
G1 X83.046 Y96.544 E.01155
G1 X85.024 Y96.544 E.04187
G1 X85.37 Y96.942 E.01116
G1 X85.296 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09605
G1 X84.428 Y96.88 E-.07221
G1 X83.898 Y96.856 E-.1008
G1 X83.372 Y96.928 E-.10087
G1 X83.321 Y96.942 E-.01008
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.473 Y100.856 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.107 E.00581
G1 X86.216 Y101.352 E.00604
G1 X85.905 Y101.739 E.0105
G1 X85.551 Y102.039 E.00982
G1 X85.277 Y102.208 E.00682
G1 X84.984 Y102.344 E.00683
G1 X84.542 Y102.473 E.00975
G1 X84.083 Y102.521 E.00975
G1 X83.762 Y102.507 E.0068
G1 X83.48 Y102.462 E.00605
G1 X83.007 Y102.313 E.0105
G1 X82.59 Y102.089 E.01002
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.204 E.00683
G1 X81.613 Y98.898 E.00683
G1 X81.825 Y98.489 E.00975
G1 X82.113 Y98.118 E.00995
G1 X82.462 Y97.803 E.00995
G1 X82.854 Y97.561 E.00976
G1 X83.151 Y97.434 E.00683
G1 X83.46 Y97.344 E.00683
G1 X83.917 Y97.282 E.00975
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.206 Y98.432 E.00683
G1 X86.425 Y98.826 E.00956
G1 X86.538 Y99.127 E.0068
G1 X86.607 Y99.404 E.00605
G1 X86.657 Y99.898 E.0105
G1 X86.614 Y100.369 E.01002
G1 X86.495 Y100.8 E.00947
M204 S250
G1 X86.099 Y100.689 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00493
G1 X85.879 Y101.119 E.00457
G1 X85.611 Y101.452 E.00841
G1 X85.31 Y101.707 E.00776
G1 X85.082 Y101.847 E.00526
G1 X84.84 Y101.96 E.00526
G1 X84.462 Y102.07 E.00773
G1 X84.071 Y102.111 E.00774
G1 X83.804 Y102.099 E.00525
G1 X83.575 Y102.062 E.00458
G1 X83.167 Y101.934 E.00841
G1 X82.817 Y101.746 E.00782
G1 X82.507 Y101.499 E.00779
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.863 E.00774
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.848 Y99.575 E.00774
G1 X81.904 Y99.313 E.00526
G1 X81.991 Y99.06 E.00526
G1 X82.172 Y98.711 E.00773
G1 X82.414 Y98.397 E.0078
G1 X82.709 Y98.132 E.00779
G1 X83.043 Y97.925 E.00774
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00774
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00773
G1 X85.512 Y98.256 E.00773
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.053 Y98.999 E.00767
G1 X86.147 Y99.249 E.00525
G1 X86.203 Y99.475 E.00457
G1 X86.246 Y99.9 E.00841
G1 X86.21 Y100.296 E.00782
G1 X86.117 Y100.632 E.00687
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.05899
G1 X85.879 Y101.119 E-.04418
G1 X85.611 Y101.452 E-.08121
G1 X85.31 Y101.707 E-.07494
G1 X85.082 Y101.847 E-.0508
G1 X84.84 Y101.96 E-.05082
G1 X84.743 Y101.988 E-.01906
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.787 Y96.442 E.00324
G1 X90.517 Y96.482 E.00577
G1 X85.532 Y96.482 E.10551
G1 X86.718 Y97.845 E.03824
G1 X87.036 Y98.346 E.01257
G1 X87.179 Y98.663 E.00735
G1 X87.262 Y98.896 E.00525
G1 X87.361 Y99.3 E.00879
G1 X87.415 Y99.899 E.01273
G1 X87.393 Y100.283 E.00814
G1 X87.335 Y100.625 E.00734
G1 X87.202 Y101.082 E.01007
G1 X86.949 Y101.613 E.01246
G1 X86.605 Y102.096 E.01254
G1 X86.319 Y102.392 E.00872
G1 X86.05 Y102.613 E.00735
G1 X85.678 Y102.855 E.00941
G1 X85.306 Y103.032 E.00872
G1 X84.978 Y103.146 E.00735
G1 X84.737 Y103.207 E.00525
G1 X84.326 Y103.269 E.00879
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01273
G1 X82.579 Y102.951 E.01273
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.0085
G1 X81.344 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.88 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.659 Y100.081 E.00868
G1 X80.674 Y99.551 E.01122
G1 X80.754 Y99.09 E.00991
G1 X80.945 Y98.53 E.01252
G1 X81.132 Y98.17 E.0086
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.324 Y96.453 E.00527
G1 X77.178 Y96.405 E.00324
G1 X76.919 Y96.228 E.00665
G1 X76.771 Y96.035 E.00513
G1 X76.683 Y95.814 E.00504
G1 X76.654 Y95.565 E.00531
G1 X76.654 Y77.626 E.37969
G1 X76.693 Y77.345 E.006
G1 X76.801 Y77.118 E.00532
G1 X76.897 Y76.997 E.00328
G1 X77.002 Y76.902 E.00299
G1 X77.234 Y76.775 E.00561
G1 X77.484 Y76.723 E.00539
G1 X90.521 Y76.721 E.27595
G1 X90.744 Y76.748 E.00475
G1 X90.883 Y76.794 E.00309
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.987 Y77.082 E.27566
G1 X77.72 Y77.123 E.00571
G1 X77.419 Y77.277 E.00717
G1 X77.182 Y77.529 E.00731
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.00639
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.971 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.00431
G1 X87.399 Y98.157 E.00892
G1 X87.558 Y98.51 E.00762
G1 X87.654 Y98.778 E.00561
G1 X87.763 Y99.22 E.00894
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.335 E.00874
G1 X87.734 Y100.717 E.00761
G1 X87.589 Y101.216 E.01022
G1 X87.508 Y101.417 E.00428
G1 X87.302 Y101.821 E.00891
G1 X87.05 Y102.197 E.00892
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.694 E.00892
G1 X86.297 Y102.939 E.00762
G1 X85.871 Y103.216 E.01001
G1 X85.461 Y103.412 E.00892
G1 X85.095 Y103.538 E.00762
G1 X84.819 Y103.609 E.00562
G1 X84.369 Y103.676 E.00894
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.11 E.00891
G1 X80.267 Y99.505 E.01192
G1 X80.355 Y98.996 E.01017
G1 X80.467 Y98.626 E.00759
G1 X80.572 Y98.361 E.00561
G1 X80.78 Y97.96 E.00889
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.895 Y96.72 E.00277
G1 X76.646 Y96.535 E.00612
G1 X76.549 Y96.432 E.00277
G1 X76.417 Y96.244 E.00451
G1 X76.343 Y96.093 E.0033
G1 X76.281 Y95.902 E.00396
G1 X76.245 Y95.589 E.0062
G1 X76.245 Y77.609 E.35363
G1 X76.262 Y77.397 E.0042
G1 X76.3 Y77.23 E.00336
G1 X76.35 Y77.093 E.00287
G1 X76.458 Y76.893 E.00448
G1 X76.597 Y76.716 E.00443
G1 X76.749 Y76.579 E.00402
G1 X76.888 Y76.485 E.0033
G1 X77.094 Y76.389 E.00446
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.546 Y76.312 E.2574
G1 X90.834 Y76.347 E.00571
G1 X91.045 Y76.417 E.00437
G1 X91.24 Y76.522 E.00436
G1 X91.472 Y76.717 E.00595
G1 X91.653 Y76.959 E.00594
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.811 Y77.491 E.00229
G1 X78.018 Y77.491 E.27129
G1 X77.848 Y77.517 E.00339
G1 X77.668 Y77.61 E.00398
G1 X77.525 Y77.762 E.00411
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.31 E.00382
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.611 Y96.311 E.00445
G1 X91.472 Y96.486 E.00439
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.681 Y96.882 E.00448
G1 X90.529 Y96.891 E.00301
G1 X86.49 Y96.891 E.07943
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16878
G1 X87.167 Y97.767 E-.0416
G1 X87.399 Y98.157 E-.08616
G1 X87.558 Y98.51 E-.07359
G1 X87.576 Y98.559 E-.00987
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




G1 X86.028 Y97.645
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360386
G1 F1500
M204 S6000
G1 X86.298 Y97.936 E.00664
G1 X86.524 Y98.236 E.00627
G1 X86.76 Y98.658 E.00807
G1 X86.903 Y99.024 E.00655
G1 X87.006 Y99.527 E.00858
G1 X87.036 Y99.903 E.00631
G1 X86.982 Y100.451 E.00918
G1 X86.845 Y100.953 E.00869
G1 X86.619 Y101.42 E.00866
G1 X86.313 Y101.845 E.00874
G1 X86.059 Y102.11 E.00614
G1 X85.783 Y102.337 E.00596
G1 X85.465 Y102.537 E.00627
G1 X85.105 Y102.702 E.00661
G1 X84.629 Y102.841 E.00828
G1 X84.082 Y102.895 E.00917
G1 X83.766 Y102.888 E.00529
G1 X83.382 Y102.828 E.00649
G1 X82.847 Y102.654 E.00939
G1 X82.395 Y102.412 E.00856
G1 X81.974 Y102.078 E.00898
G1 X81.648 Y101.716 E.00813
G1 X81.453 Y101.418 E.00594
G1 X81.289 Y101.103 E.00594
G1 X81.165 Y100.769 E.00594
G1 X81.102 Y100.522 E.00426
G1 X81.04 Y100.005 E.00868
G1 X81.055 Y99.595 E.00685
G1 X81.125 Y99.181 E.00701
G1 X81.271 Y98.739 E.00778
G1 X81.46 Y98.365 E.00699
G1 X81.662 Y98.073 E.00594
G1 X82.025 Y97.669 E.00906
; LINE_WIDTH: 0.401691
G1 X82.203 Y97.487 E.00477
; LINE_WIDTH: 0.438749
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.475174
G1 X82.578 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.338 Y97.375 Z2.16 F18000
M73 P61 R9
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.433931
G1 F1500
M204 S6000
G1 X85.5 Y97.34 E.00337
; LINE_WIDTH: 0.468557
G1 X85.661 Y97.304 E.00365
; LINE_WIDTH: 0.468071
G1 X85.785 Y97.419 E.00372
; LINE_WIDTH: 0.432754
G1 X85.906 Y97.532 E.00337
; LINE_WIDTH: 0.397694
G1 X86.028 Y97.645 E.00308
; WIPE_START
G1 X85.906 Y97.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.36 Y96.387 Z2.16 F18000
G1 X77.422 Y96.245 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.153442
G1 F1500
M204 S6000
G1 X77.11 Y96.02 E.00245
G1 X76.976 Y95.837 E.00145
; LINE_WIDTH: 0.127216
G1 X76.936 Y95.729 E.00058
; LINE_WIDTH: 0.0941179
G1 X76.896 Y95.622 E.00039
; WIPE_START
G1 X76.936 Y95.729 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.917 Y88.097 Z2.16 F18000
G1 X76.891 Y77.596 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.099848
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00081
; LINE_WIDTH: 0.154249
G1 X77.107 Y77.192 E.00157
G1 X77.228 Y77.081 E.00105
; LINE_WIDTH: 0.12805
G1 X77.43 Y76.991 E.00113
; LINE_WIDTH: 0.0895179
G1 X77.537 Y76.955 E.00036
; WIPE_START
G1 X77.43 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.993 Y80.889 Z2.16 F18000
G1 X93.178 Y86.344 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/49
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I-.958 J-.751 P1  F18000
G1 X85.263 Y97.104 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01029
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00804
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.045 Y96.544 E.01174
G1 X85.024 Y96.544 E.04188
G1 X85.37 Y96.942 E.01116
G1 X85.296 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09606
G1 X84.428 Y96.88 E-.0722
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07218
G1 X83.322 Y96.946 E-.04174
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.47 Y100.861 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.36 Y101.108 E.00572
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00975
G1 X85.551 Y102.039 E.00975
G1 X85.276 Y102.208 E.00683
G1 X84.984 Y102.344 E.00683
G1 X84.541 Y102.473 E.00975
G1 X84.083 Y102.521 E.00975
G1 X83.763 Y102.507 E.00679
G1 X83.483 Y102.462 E.00599
G1 X83.007 Y102.313 E.01055
G1 X82.59 Y102.089 E.01002
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.746 Y101.177 E.00683
G1 X81.606 Y100.886 E.00683
G1 X81.47 Y100.446 E.00975
G1 X81.414 Y99.979 E.00995
G1 X81.442 Y99.519 E.00975
G1 X81.508 Y99.205 E.0068
G1 X81.599 Y98.937 E.00599
G1 X81.823 Y98.492 E.01055
G1 X82.113 Y98.118 E.01002
G1 X82.462 Y97.803 E.00995
G1 X82.862 Y97.556 E.00995
G1 X83.291 Y97.388 E.00975
G1 X83.606 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.789 Y97.953 E.00994
G1 X86.101 Y98.289 E.00972
G1 X86.262 Y98.522 E.00598
G1 X86.427 Y98.832 E.00743
G1 X86.539 Y99.129 E.00672
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.614 Y100.369 E.00995
G1 X86.494 Y100.806 E.00959
M204 S250
G1 X86.097 Y100.695 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00484
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.452 E.00773
G1 X85.31 Y101.707 E.00773
G1 X85.082 Y101.847 E.00526
G1 X84.839 Y101.96 E.00526
G1 X84.462 Y102.07 E.00773
G1 X84.071 Y102.111 E.00774
G1 X83.804 Y102.099 E.00525
G1 X83.577 Y102.063 E.00453
G1 X83.167 Y101.934 E.00845
G1 X82.817 Y101.746 E.00782
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.977 E.00527
G1 X81.988 Y100.736 E.00526
G1 X81.872 Y100.361 E.00773
G1 X81.825 Y99.967 E.0078
G1 X81.848 Y99.574 E.00774
G1 X81.904 Y99.313 E.00525
G1 X81.977 Y99.095 E.00453
G1 X82.171 Y98.712 E.00845
G1 X82.414 Y98.397 E.00782
G1 X82.709 Y98.132 E.0078
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00773
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.514 Y98.258 E.00779
G1 X85.781 Y98.546 E.00772
G1 X85.912 Y98.735 E.00452
G1 X86.054 Y99.001 E.00592
G1 X86.147 Y99.249 E.00523
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.296 E.00779
G1 X86.116 Y100.638 E.00698
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.05805
G1 X85.859 Y101.149 E-.05082
G1 X85.61 Y101.452 E-.07471
G1 X85.31 Y101.707 E-.07471
G1 X85.082 Y101.847 E-.05082
G1 X84.839 Y101.96 E-.05082
G1 X84.738 Y101.989 E-.02007
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.992 E.00386
G1 X87.04 Y98.353 E.00888
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.091 E.01292
G1 X87.336 Y100.62 E.01132
G1 X87.204 Y101.075 E.01001
G1 X86.951 Y101.609 E.01251
G1 X86.605 Y102.096 E.01264
G1 X86.319 Y102.392 E.00872
G1 X86.054 Y102.61 E.00725
G1 X85.678 Y102.855 E.0095
G1 X85.307 Y103.032 E.00869
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.163 E.01254
G1 X82.765 Y103.033 E.00861
G1 X82.342 Y102.825 E.00998
G1 X81.908 Y102.529 E.01112
G1 X81.606 Y102.251 E.00869
G1 X81.344 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.0085
G1 X80.678 Y100.298 E.01257
G1 X80.657 Y99.957 E.00725
G1 X80.681 Y99.486 E.00997
G1 X80.753 Y99.095 E.00842
G1 X80.944 Y98.533 E.01257
G1 X81.1 Y98.228 E.00724
G1 X81.36 Y97.835 E.00998
G1 X82.538 Y96.482 E.03797
G1 X77.571 Y96.482 E.10513
G1 X77.321 Y96.453 E.00532
G1 X77.111 Y96.37 E.00478
G1 X76.911 Y96.218 E.00532
G1 X76.825 Y96.12 E.00275
G1 X76.731 Y95.957 E.00399
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.628 E.37965
G1 X76.692 Y77.348 E.00597
G1 X76.801 Y77.118 E.00539
G1 X76.897 Y76.997 E.00329
G1 X77.001 Y76.903 E.00295
G1 X77.236 Y76.775 E.00568
G1 X77.487 Y76.723 E.00542
G1 X90.523 Y76.721 E.27591
G1 X90.744 Y76.748 E.00471
G1 X90.874 Y76.792 E.00291
G1 X91.05 Y76.893 E.0043
G1 X90.999 Y77.082 E.00413
G1 X77.981 Y77.082 E.27555
G1 X77.692 Y77.133 E.0062
G1 X77.419 Y77.28 E.00656
G1 X77.198 Y77.505 E.00669
G1 X77.053 Y77.8 E.00695
G1 X77.016 Y78.056 E.00547
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00883
G1 X77.962 Y96.12 E.00834
G1 X85.214 Y96.12 E.15348
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.00431
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.335 E.00874
G1 X87.735 Y100.712 E.00752
G1 X87.59 Y101.213 E.01026
G1 X87.439 Y101.563 E.0075
G1 X87.303 Y101.82 E.00571
G1 X87.05 Y102.197 E.00895
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.694 E.00892
G1 X86.301 Y102.936 E.00752
G1 X86.06 Y103.104 E.00577
G1 X85.871 Y103.216 E.00434
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.609 Y103.412 E.00889
G1 X82.141 Y103.182 E.01025
G1 X81.645 Y102.842 E.01182
G1 X81.311 Y102.536 E.00891
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.302 Y100.557 E.00891
G1 X80.247 Y99.959 E.01182
G1 X80.274 Y99.438 E.01025
G1 X80.354 Y98.997 E.00883
G1 X80.488 Y98.564 E.00891
G1 X80.746 Y98.021 E.01182
G1 X81.034 Y97.587 E.01025
G1 X81.639 Y96.891 E.01814
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.0062
G1 X77.044 Y96.793 E.00392
G1 X76.895 Y96.72 E.00325
G1 X76.631 Y96.519 E.00654
G1 X76.418 Y96.246 E.00681
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35362
G1 X76.265 Y77.374 E.00466
G1 X76.299 Y77.231 E.00289
G1 X76.35 Y77.093 E.00289
G1 X76.458 Y76.893 E.00448
G1 X76.597 Y76.716 E.00444
G1 X76.748 Y76.58 E.00399
G1 X76.888 Y76.485 E.00333
G1 X77.095 Y76.389 E.00447
G1 X77.29 Y76.335 E.00398
G1 X77.461 Y76.313 E.00339
G1 X90.548 Y76.312 E.25741
G1 X90.834 Y76.347 E.00567
G1 X91.043 Y76.416 E.00432
G1 X91.307 Y76.569 E.00601
G1 X91.47 Y76.714 E.0043
G1 X91.653 Y76.959 E.00601
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.668 Y77.61 E.00358
G1 X77.536 Y77.745 E.0037
G1 X77.449 Y77.923 E.0039
G1 X77.425 Y78.086 E.00323
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16878
G1 X87.167 Y97.767 E-.0416
G1 X87.401 Y98.159 E-.08666
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04136
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




G1 X86.037 Y97.654
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.395481
G1 F1500
M204 S6000
G1 X85.912 Y97.538 E.00314
; LINE_WIDTH: 0.431411
G1 X85.788 Y97.422 E.00345
; LINE_WIDTH: 0.467604
G1 X85.661 Y97.304 E.00381
; LINE_WIDTH: 0.468546
G1 X85.5 Y97.34 E.00365
; LINE_WIDTH: 0.433958
G1 X85.338 Y97.375 E.00337
M204 S10000
G1 X86.037 Y97.654 F18000
; LINE_WIDTH: 0.359834
G1 F1500
M204 S6000
G1 X86.404 Y98.061 E.00915
G1 X86.577 Y98.319 E.00517
G1 X86.764 Y98.667 E.00659
G1 X86.903 Y99.027 E.00642
G1 X87.008 Y99.527 E.00851
G1 X87.036 Y99.903 E.0063
G1 X86.983 Y100.451 E.00916
G1 X86.848 Y100.944 E.00852
G1 X86.622 Y101.414 E.0087
G1 X86.314 Y101.845 E.00883
G1 X86.059 Y102.11 E.00613
G1 X85.783 Y102.337 E.00595
G1 X85.465 Y102.537 E.00626
G1 X85.105 Y102.702 E.0066
G1 X84.628 Y102.837 E.00826
G1 X84.29 Y102.886 E.00569
G1 X84.082 Y102.895 E.00346
G1 X83.734 Y102.884 E.00582
G1 X83.253 Y102.792 E.00816
M73 P62 R9
G1 X82.876 Y102.667 E.00662
G1 X82.396 Y102.409 E.00907
G1 X81.974 Y102.078 E.00895
G1 X81.648 Y101.716 E.00812
G1 X81.421 Y101.37 E.0069
G1 X81.259 Y101.036 E.00619
G1 X81.099 Y100.51 E.00916
G1 X81.038 Y100.005 E.00847
G1 X81.06 Y99.53 E.00793
G1 X81.123 Y99.186 E.00584
G1 X81.245 Y98.802 E.00671
G1 X81.498 Y98.305 E.0093
G1 X81.827 Y97.872 E.00906
G1 X82.025 Y97.669 E.00473
; LINE_WIDTH: 0.401789
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438157
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473052
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.421 Y96.247 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.14715
G1 F1500
M204 S6000
G1 X77.053 Y95.956 E.00284
G1 X76.982 Y95.849 E.00078
G1 X76.882 Y95.627 E.00148
; WIPE_START
G1 X76.982 Y95.849 E-.10998
G1 X77.053 Y95.956 E-.05811
G1 X77.421 Y96.247 E-.21191
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.205 Y88.617 Z2.28 F18000
G1 X76.892 Y77.597 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0969401
G1 F1500
M204 S6000
G1 X76.924 Y77.482 E.00043
; LINE_WIDTH: 0.124044
G1 X76.967 Y77.371 E.00058
; LINE_WIDTH: 0.154174
G1 X77.107 Y77.191 E.00146
G1 X77.229 Y77.081 E.00105
; LINE_WIDTH: 0.129883
G1 X77.429 Y76.991 E.00114
; LINE_WIDTH: 0.0898053
G1 X77.531 Y76.955 E.00035
; WIPE_START
G1 X77.429 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.991 Y80.888 Z2.28 F18000
G1 X93.178 Y86.344 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/49
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I-.958 J-.751 P1  F18000
G1 X85.263 Y97.104 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.954 E.01029
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01123
G1 X83.008 Y97.034 E.00804
G1 X82.807 Y97.12 E.00462
G1 X82.687 Y96.956 E.00429
G1 X83.045 Y96.544 E.01155
G1 X85.024 Y96.544 E.04188
G1 X85.37 Y96.942 E.01117
G1 X85.297 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.954 E-.09606
G1 X84.428 Y96.88 E-.07222
G1 X83.898 Y96.856 E-.1008
G1 X83.372 Y96.928 E-.10083
G1 X83.321 Y96.942 E-.01009
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.468 Y100.866 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.106 E.00556
G1 X86.219 Y101.348 E.00594
G1 X85.905 Y101.738 E.0106
G1 X85.551 Y102.039 E.00983
G1 X85.278 Y102.207 E.00679
G1 X85.024 Y102.327 E.00593
G1 X84.545 Y102.473 E.0106
G1 X84.083 Y102.521 E.00983
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00684
G1 X83.004 Y102.312 E.00975
G1 X82.59 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00994
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.551 Y99.063 E.00975
G1 X81.674 Y98.764 E.00683
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.462 Y97.803 E.00995
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.461 Y97.344 E.00683
G1 X83.917 Y97.282 E.00975
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00976
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.206 Y98.432 E.00683
G1 X86.425 Y98.826 E.00955
G1 X86.539 Y99.129 E.00683
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.614 Y100.369 E.00995
G1 X86.492 Y100.811 E.00971
M204 S250
G1 X86.094 Y100.7 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.918 E.00471
G1 X85.881 Y101.115 E.00448
G1 X85.611 Y101.452 E.0085
G1 X85.31 Y101.707 E.00776
G1 X85.083 Y101.847 E.00525
G1 X84.877 Y101.944 E.00448
G1 X84.463 Y102.07 E.0085
G1 X84.071 Y102.111 E.00776
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.00779
G1 X82.246 Y101.2 E.00779
G1 X82.044 Y100.863 E.00774
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.19 E.00773
G1 X82.043 Y98.942 E.00526
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.709 Y98.132 E.0078
G1 X83.043 Y97.925 E.00773
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00773
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.512 Y98.256 E.00773
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.053 Y98.999 E.00767
G1 X86.147 Y99.249 E.00526
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.296 E.00779
G1 X86.114 Y100.643 E.0071
; WIPE_START
M204 S6000
G1 X85.997 Y100.918 E-.05683
G1 X85.881 Y101.115 E-.04326
G1 X85.611 Y101.452 E-.08213
G1 X85.31 Y101.707 E-.07495
G1 X85.083 Y101.847 E-.05072
G1 X84.877 Y101.944 E-.04324
G1 X84.731 Y101.988 E-.02888
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.712 Y97.838 E.03805
G1 X87.036 Y98.344 E.01272
G1 X87.266 Y98.91 E.01293
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.091 E.01273
G1 X87.337 Y100.616 E.01123
G1 X87.204 Y101.075 E.01011
G1 X86.947 Y101.618 E.01271
G1 X86.599 Y102.103 E.01263
G1 X86.32 Y102.391 E.00849
G1 X86.001 Y102.65 E.00869
G1 X85.678 Y102.855 E.0081
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.0087
G1 X83.734 Y103.267 E.01253
G1 X83.142 Y103.161 E.01273
G1 X82.579 Y102.951 E.01273
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.88 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.753 Y99.095 E.00869
G1 X80.871 Y98.712 E.00849
G1 X81.038 Y98.337 E.00869
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00343
G1 X76.824 Y96.119 E.00343
G1 X76.731 Y95.957 E.00394
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.628 E.37965
G1 X76.69 Y77.355 E.00583
G1 X76.798 Y77.122 E.00542
G1 X76.897 Y76.996 E.0034
G1 X76.999 Y76.904 E.00292
G1 X77.234 Y76.775 E.00567
G1 X77.484 Y76.723 E.00539
G1 X90.525 Y76.721 E.27602
G1 X90.744 Y76.748 E.00468
G1 X90.883 Y76.794 E.0031
G1 X91.059 Y76.889 E.00424
G1 X91.01 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.806 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.00639
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.214 Y96.12 E.15348
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.037 Y97.588 E.01817
G1 X87.291 Y97.962 E.00891
G1 X87.495 Y98.356 E.00873
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00874
G1 X87.736 Y100.708 E.00742
G1 X87.59 Y101.213 E.01036
G1 X87.441 Y101.559 E.0074
G1 X87.184 Y102.009 E.01019
G1 X86.91 Y102.37 E.00891
G1 X86.597 Y102.693 E.00885
G1 X86.245 Y102.979 E.00891
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.0043
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.113 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.567 E.00885
G1 X80.672 Y98.153 E.00891
G1 X80.778 Y97.962 E.0043
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.368 E.00448
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35362
G1 X76.265 Y77.374 E.00466
G1 X76.299 Y77.233 E.00285
G1 X76.373 Y77.043 E.00401
G1 X76.456 Y76.894 E.00336
G1 X76.597 Y76.716 E.00447
G1 X76.747 Y76.581 E.00395
G1 X76.889 Y76.485 E.00337
G1 X77.094 Y76.389 E.00445
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.55 Y76.312 E.25747
G1 X90.834 Y76.347 E.00564
G1 X91.045 Y76.417 E.00437
G1 X91.241 Y76.522 E.00436
G1 X91.472 Y76.717 E.00595
G1 X91.653 Y76.959 E.00594
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.31 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.304 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.037 Y97.588 E-.16823
G1 X87.291 Y97.962 E-.08605
G1 X87.495 Y98.356 E-.08432
G1 X87.572 Y98.56 E-.0414
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




G1 X86.028 Y97.645
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360191
G1 F1500
M204 S6000
G1 X86.298 Y97.936 E.00664
G1 X86.524 Y98.236 E.00626
G1 X86.694 Y98.521 E.00554
G1 X86.904 Y99.025 E.0091
G1 X86.987 Y99.393 E.00629
G1 X87.036 Y99.903 E.00856
G1 X86.983 Y100.451 E.00917
G1 X86.848 Y100.944 E.00854
G1 X86.616 Y101.425 E.0089
G1 X86.305 Y101.854 E.00884
G1 X86.061 Y102.108 E.00589
G1 X85.777 Y102.344 E.00615
G1 X85.496 Y102.52 E.00553
G1 X85.155 Y102.684 E.00631
M73 P63 R9
G1 X84.636 Y102.84 E.00906
G1 X84.107 Y102.9 E.00888
G1 X83.731 Y102.884 E.00627
G1 X83.341 Y102.818 E.00661
G1 X82.843 Y102.652 E.00876
G1 X82.395 Y102.412 E.00848
G1 X81.973 Y102.078 E.00897
G1 X81.648 Y101.716 E.00812
G1 X81.453 Y101.418 E.00594
G1 X81.288 Y101.103 E.00594
G1 X81.165 Y100.769 E.00594
G1 X81.102 Y100.522 E.00426
G1 X81.041 Y100.069 E.00762
G1 X81.046 Y99.704 E.00609
G1 X81.127 Y99.184 E.00877
G1 X81.228 Y98.848 E.00586
G1 X81.455 Y98.373 E.00878
G1 X81.662 Y98.073 E.0061
G1 X82.025 Y97.669 E.00905
; LINE_WIDTH: 0.401765
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.43883
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.475194
G1 X82.578 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.338 Y97.375 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.43386
G1 F1500
M204 S6000
G1 X85.5 Y97.34 E.00337
; LINE_WIDTH: 0.468533
G1 X85.661 Y97.304 E.00365
; LINE_WIDTH: 0.468072
G1 X85.785 Y97.419 E.00372
; LINE_WIDTH: 0.432758
G1 X85.906 Y97.532 E.00337
; LINE_WIDTH: 0.397695
G1 X86.028 Y97.645 E.00308
; WIPE_START
G1 X85.906 Y97.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.361 Y96.382 Z2.4 F18000
G1 X77.463 Y96.245 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.122776
G1 F1500
M204 S6000
G1 X77.355 Y96.185 E.0006
; LINE_WIDTH: 0.1491
G1 X77.247 Y96.124 E.00076
G1 X77.043 Y95.953 E.00164
G1 X76.882 Y95.626 E.00224
; WIPE_START
G1 X77.043 Y95.953 E-.18337
G1 X77.247 Y96.124 E-.13415
G1 X77.355 Y96.185 E-.06248
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.165 Y88.554 Z2.4 F18000
G1 X76.892 Y77.595 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.106466
G1 F1500
M204 S6000
G1 X76.967 Y77.373 E.00094
; LINE_WIDTH: 0.156902
G1 X77.107 Y77.192 E.00149
G1 X77.228 Y77.08 E.00108
; LINE_WIDTH: 0.131191
G1 X77.412 Y76.995 E.00106
; LINE_WIDTH: 0.0957275
G1 X77.499 Y76.963 E.00032
; LINE_WIDTH: 0.0812008
G1 X77.531 Y76.955 E.00009
; WIPE_START
G1 X77.499 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.049 Y80.882 Z2.4 F18000
G1 X93.178 Y86.344 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/49
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I-.954 J-.755 P1  F18000
G1 X85.194 Y97.081 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.00874
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00805
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.046 Y96.544 E.01174
G1 X84.957 Y96.544 E.04046
G1 X85.3 Y96.916 E.0107
G1 X85.226 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.08209
G1 X84.428 Y96.88 E-.07221
G1 X83.914 Y96.857 E-.09783
G1 X83.536 Y96.897 E-.07217
G1 X83.25 Y96.962 E-.0557
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.467 Y100.853 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.365 Y101.1 E.00566
G1 X86.2 Y101.377 E.00683
G1 X86.002 Y101.632 E.00683
G1 X85.669 Y101.951 E.00976
G1 X85.277 Y102.21 E.00995
G1 X84.854 Y102.391 E.00975
G1 X84.541 Y102.472 E.00683
G1 X84.231 Y102.514 E.00664
G1 X83.917 Y102.519 E.00663
G1 X83.596 Y102.485 E.00683
G1 X83.159 Y102.371 E.00956
G1 X82.863 Y102.244 E.00683
G1 X82.583 Y102.083 E.00683
G1 X82.23 Y101.802 E.00956
G1 X82.011 Y101.565 E.00683
G1 X81.821 Y101.304 E.00683
G1 X81.609 Y100.895 E.00975
G1 X81.47 Y100.446 E.00995
G1 X81.414 Y99.979 E.00995
G1 X81.442 Y99.519 E.00975
G1 X81.508 Y99.206 E.00679
G1 X81.597 Y98.942 E.00588
M73 P63 R8
G1 X81.823 Y98.493 E.01065
G1 X82.113 Y98.118 E.01003
G1 X82.462 Y97.803 E.00995
G1 X82.862 Y97.556 E.00995
G1 X83.291 Y97.388 E.00975
G1 X83.606 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.206 Y98.432 E.00683
G1 X86.43 Y98.835 E.00975
G1 X86.582 Y99.279 E.00995
G1 X86.652 Y99.744 E.00995
G1 X86.638 Y100.214 E.00995
G1 X86.54 Y100.674 E.00995
G1 X86.489 Y100.797 E.00282
M204 S250
G1 X86.088 Y100.697 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.998 Y100.916 E.00466
G1 X85.861 Y101.146 E.00526
G1 X85.697 Y101.358 E.00526
G1 X85.413 Y101.629 E.00774
G1 X85.082 Y101.848 E.00779
G1 X84.721 Y102.002 E.00773
G1 X84.462 Y102.07 E.00526
G1 X84.2 Y102.105 E.0052
G1 X83.936 Y102.109 E.0052
G1 X83.67 Y102.081 E.00526
G1 X83.292 Y101.983 E.00767
G1 X83.046 Y101.878 E.00526
G1 X82.814 Y101.744 E.00526
G1 X82.509 Y101.501 E.00768
G1 X82.327 Y101.305 E.00526
G1 X82.17 Y101.088 E.00526
G1 X81.989 Y100.739 E.00773
G1 X81.872 Y100.361 E.0078
G1 X81.825 Y99.967 E.0078
G1 X81.848 Y99.574 E.00774
G1 X81.904 Y99.313 E.00525
G1 X81.975 Y99.1 E.00443
G1 X82.171 Y98.712 E.00855
G1 X82.414 Y98.397 E.00782
G1 X82.709 Y98.132 E.00779
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00773
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.512 Y98.256 E.00774
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.054 Y99.002 E.00773
G1 X86.183 Y99.377 E.00779
G1 X86.242 Y99.769 E.0078
G1 X86.23 Y100.165 E.0078
G1 X86.147 Y100.552 E.00779
G1 X86.111 Y100.642 E.0019
; WIPE_START
M204 S6000
G1 X85.998 Y100.916 E-.05638
G1 X85.861 Y101.146 E-.05083
G1 X85.697 Y101.358 E-.05081
G1 X85.413 Y101.629 E-.07474
G1 X85.082 Y101.848 E-.0753
G1 X84.734 Y101.997 E-.07195
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.2 Y96.12 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12291
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.787 Y96.442 E.00324
G1 X90.517 Y96.482 E.00577
G1 X85.476 Y96.482 E.10668
G1 X86.579 Y97.675 E.03439
G1 X86.829 Y98 E.00868
G1 X87.119 Y98.517 E.01254
G1 X87.315 Y99.086 E.01273
G1 X87.389 Y99.49 E.00869
G1 X87.415 Y99.899 E.00869
G1 X87.393 Y100.283 E.00815
G1 X87.337 Y100.612 E.00705
G1 X87.204 Y101.075 E.01021
G1 X86.95 Y101.611 E.01255
G1 X86.602 Y102.099 E.01269
G1 X86.318 Y102.392 E.00863
G1 X86.061 Y102.605 E.00706
G1 X85.678 Y102.855 E.00969
G1 X85.306 Y103.033 E.00873
G1 X84.99 Y103.142 E.00706
G1 X84.737 Y103.207 E.00554
G1 X84.326 Y103.269 E.00878
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01253
G1 X82.766 Y103.033 E.0086
G1 X82.335 Y102.82 E.01018
G1 X82.055 Y102.641 E.00705
G1 X81.606 Y102.251 E.01258
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.0085
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.754 Y99.086 E.00889
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.867 Y96.173 E.0054
G1 X76.769 Y96.033 E.00362
G1 X76.683 Y95.812 E.00501
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00578
G1 X76.751 Y77.204 E.00329
G1 X76.821 Y77.088 E.00289
G1 X77.017 Y76.89 E.00589
G1 X77.243 Y76.772 E.00539
G1 X77.493 Y76.723 E.00539
G1 X90.526 Y76.721 E.27586
G1 X90.744 Y76.748 E.00464
G1 X90.879 Y76.793 E.00302
G1 X91.055 Y76.891 E.00426
G1 X91.006 Y77.082 E.00417
G1 X77.99 Y77.082 E.2755
G1 X77.731 Y77.119 E.00553
G1 X77.425 Y77.273 E.00725
G1 X77.197 Y77.507 E.00691
G1 X77.053 Y77.8 E.00693
G1 X77.016 Y78.056 E.00546
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.14 Y96.12 E.15173
; WIPE_START
M204 S6000
G1 X87.14 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.412 Y96.891 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01393
G1 X87.168 Y97.77 E.00891
G1 X87.4 Y98.159 E.00891
G1 X87.496 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.335 E.00874
G1 X87.737 Y100.703 E.00733
G1 X87.59 Y101.213 E.01045
G1 X87.443 Y101.555 E.00731
G1 X87.302 Y101.82 E.00591
G1 X87.096 Y102.133 E.00737
G1 X86.911 Y102.369 E.00589
G1 X86.596 Y102.694 E.00889
G1 X86.309 Y102.931 E.00734
G1 X86.06 Y103.104 E.00595
G1 X85.871 Y103.216 E.00434
G1 X85.461 Y103.412 E.00892
G1 X85.109 Y103.534 E.00734
G1 X84.819 Y103.609 E.00589
G1 X84.369 Y103.676 E.00894
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.609 Y103.412 E.00889
G1 X82.133 Y103.177 E.01044
G1 X81.645 Y102.842 E.01164
G1 X81.311 Y102.536 E.00891
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.355 Y98.994 E.00897
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.648 Y96.537 E.00454
G1 X76.549 Y96.432 E.00283
G1 X76.417 Y96.243 E.00454
G1 X76.352 Y96.114 E.00283
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.383 Y77.022 E.00443
G1 X76.486 Y76.851 E.00392
G1 X76.596 Y76.717 E.0034
G1 X76.767 Y76.565 E.00452
G1 X76.887 Y76.486 E.00283
G1 X77.097 Y76.388 E.00454
G1 X77.234 Y76.347 E.00283
G1 X77.463 Y76.313 E.00454
G1 X90.552 Y76.312 E.25744
G1 X90.834 Y76.347 E.0056
G1 X91.044 Y76.417 E.00435
G1 X91.263 Y76.538 E.00493
G1 X91.472 Y76.717 E.0054
G1 X91.638 Y76.935 E.0054
G1 X91.747 Y77.161 E.00493
G1 X91.804 Y77.375 E.00435
G1 X91.811 Y77.491 E.00229
G1 X78.019 Y77.491 E.27127
G1 X77.856 Y77.515 E.00325
G1 X77.67 Y77.608 E.00409
G1 X77.536 Y77.746 E.00379
G1 X77.449 Y77.923 E.00389
G1 X77.425 Y78.086 E.00323
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
M73 P64 R8
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.681 Y96.882 E.00448
G1 X90.529 Y96.891 E.00301
G1 X86.472 Y96.891 E.0798
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12708
G1 X87.168 Y97.77 E-.08606
G1 X87.4 Y98.159 E-.08606
G1 X87.496 Y98.356 E-.04163
G1 X87.568 Y98.549 E-.03917
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




G1 X86.026 Y97.647
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397629
G1 F1500
M204 S6000
G1 X85.842 Y97.48 E.00462
; LINE_WIDTH: 0.442824
G1 X85.657 Y97.314 E.00518
; LINE_WIDTH: 0.480631
G1 X85.415 Y97.129 E.0069
M204 S10000
G1 X86.026 Y97.647 F18000
; LINE_WIDTH: 0.360195
G1 F1500
M204 S6000
G1 X86.289 Y97.921 E.00632
G1 X86.528 Y98.234 E.00659
G1 X86.766 Y98.669 E.00827
G1 X86.942 Y99.177 E.00896
G1 X87.008 Y99.536 E.0061
G1 X87.026 Y100.07 E.00891
G1 X86.963 Y100.529 E.00773
G1 X86.842 Y100.946 E.00725
G1 X86.698 Y101.28 E.00607
G1 X86.454 Y101.671 E.00768
G1 X86.275 Y101.894 E.00478
G1 X86.058 Y102.11 E.00511
G1 X85.832 Y102.299 E.00491
G1 X85.47 Y102.536 E.00722
G1 X84.964 Y102.752 E.00918
G1 X84.661 Y102.834 E.00524
G1 X84.292 Y102.889 E.00622
G1 X83.91 Y102.893 E.00638
G1 X83.517 Y102.854 E.00659
G1 X83.027 Y102.722 E.00847
G1 X82.686 Y102.576 E.00619
G1 X82.36 Y102.388 E.00627
G1 X81.966 Y102.068 E.00847
G1 X81.713 Y101.797 E.00619
G1 X81.494 Y101.492 E.00627
G1 X81.255 Y101.024 E.00876
G1 X81.099 Y100.51 E.00897
G1 X81.042 Y100.071 E.00738
G1 X81.058 Y99.548 E.00874
G1 X81.143 Y99.116 E.00735
G1 X81.253 Y98.786 E.00579
G1 X81.496 Y98.305 E.009
G1 X81.827 Y97.872 E.00909
G1 X82.025 Y97.669 E.00474
; LINE_WIDTH: 0.401729
G1 X82.203 Y97.487 E.00477
; LINE_WIDTH: 0.438105
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473045
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.144874
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00157
G1 X77.061 Y95.968 E.00144
G1 X76.982 Y95.849 E.00085
G1 X76.882 Y95.627 E.00145
; WIPE_START
G1 X76.982 Y95.849 E-.1035
G1 X77.061 Y95.968 E-.06065
G1 X77.247 Y96.123 E-.10339
G1 X77.48 Y96.249 E-.11246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.238 Y88.62 Z2.52 F18000
G1 X76.889 Y77.604 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.101573
G1 F1500
M204 S6000
G1 X76.946 Y77.423 E.00072
; LINE_WIDTH: 0.153013
G1 X76.993 Y77.327 E.00068
G1 X77.225 Y77.084 E.00213
; LINE_WIDTH: 0.128753
G1 X77.436 Y76.989 E.00119
; LINE_WIDTH: 0.0896062
G1 X77.539 Y76.955 E.00034
; WIPE_START
G1 X77.436 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.998 Y80.888 Z2.52 F18000
G1 X93.178 Y86.344 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 18/49
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I-.958 J-.751 P1  F18000
G1 X85.254 Y97.115 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.954 E.01018
G1 X84.428 Y96.88 E.00805
G1 X83.898 Y96.856 E.01123
G1 X83.372 Y96.928 E.01124
G1 X83.008 Y97.034 E.00803
G1 X82.807 Y97.12 E.00462
G1 X82.687 Y96.956 E.00429
G1 X83.045 Y96.544 E.01155
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X84.801 Y96.954 E-.09541
G1 X84.428 Y96.88 E-.07222
G1 X83.898 Y96.856 E-.10081
G1 X83.372 Y96.928 E-.10087
G1 X83.318 Y96.943 E-.0107
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.463 Y100.877 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.108 E.00536
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00975
G1 X85.551 Y102.039 E.00975
G1 X85.278 Y102.207 E.00678
G1 X85.029 Y102.325 E.00583
G1 X84.545 Y102.473 E.01071
G1 X84.083 Y102.521 E.00984
G1 X83.763 Y102.507 E.00678
G1 X83.491 Y102.464 E.00583
G1 X83.008 Y102.314 E.01071
G1 X82.59 Y102.089 E.01003
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.671 Y101.035 E.01004
G1 X81.499 Y100.559 E.01071
G1 X81.444 Y100.289 E.00582
G1 X81.415 Y99.97 E.00679
G1 X81.442 Y99.519 E.00955
G1 X81.508 Y99.206 E.00679
G1 X81.596 Y98.945 E.00583
G1 X81.823 Y98.493 E.01071
G1 X82.113 Y98.118 E.01003
G1 X82.462 Y97.803 E.00995
G1 X82.854 Y97.561 E.00975
G1 X83.151 Y97.434 E.00683
G1 X83.46 Y97.344 E.00682
G1 X83.917 Y97.282 E.00975
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X84.992 Y97.462 E.00663
G1 X85.276 Y97.593 E.00663
G1 X85.551 Y97.763 E.00683
G1 X85.895 Y98.055 E.00955
G1 X86.106 Y98.296 E.00679
G1 X86.263 Y98.523 E.00582
G1 X86.488 Y98.976 E.01071
G1 X86.614 Y99.433 E.01003
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.492 Y100.813 E.00975
G1 X86.488 Y100.822 E.0002
M204 S250
G1 X86.09 Y100.71 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.0045
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.452 E.00773
G1 X85.31 Y101.707 E.00773
G1 X85.083 Y101.847 E.00525
G1 X84.881 Y101.942 E.00438
G1 X84.463 Y102.07 E.0086
G1 X84.071 Y102.111 E.00776
G1 X83.805 Y102.099 E.00524
G1 X83.584 Y102.064 E.00438
G1 X83.167 Y101.935 E.0086
G1 X82.817 Y101.746 E.00782
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.042 Y100.859 E.00782
G1 X81.894 Y100.448 E.0086
G1 X81.849 Y100.23 E.00438
G1 X81.825 Y99.964 E.00525
G1 X81.848 Y99.574 E.00767
G1 X81.904 Y99.314 E.00525
G1 X81.974 Y99.102 E.00438
G1 X82.171 Y98.712 E.0086
G1 X82.414 Y98.397 E.00782
G1 X82.709 Y98.132 E.0078
G1 X83.043 Y97.925 E.00773
G1 X83.289 Y97.82 E.00526
G1 X83.546 Y97.745 E.00526
G1 X83.936 Y97.692 E.00774
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.842 Y97.843 E.0052
G1 X85.082 Y97.954 E.0052
G1 X85.31 Y98.095 E.00526
G1 X85.607 Y98.347 E.00767
G1 X85.783 Y98.548 E.00525
G1 X85.91 Y98.731 E.00438
G1 X86.104 Y99.123 E.0086
G1 X86.21 Y99.506 E.00782
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.111 Y100.654 E.00732
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.0548
G1 X85.859 Y101.149 E-.05083
G1 X85.61 Y101.452 E-.07471
G1 X85.31 Y101.707 E-.07471
G1 X85.083 Y101.847 E-.05069
G1 X84.881 Y101.942 E-.04232
G1 X84.721 Y101.991 E-.03194
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03825
G1 X86.825 Y97.992 E.00385
G1 X87.04 Y98.353 E.00888
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.091 E.01292
G1 X87.338 Y100.607 E.01104
G1 X87.204 Y101.076 E.01031
G1 X86.951 Y101.61 E.01251
G1 X86.605 Y102.096 E.01263
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00869
G1 X85.678 Y102.855 E.0081
G1 X85.308 Y103.032 E.00868
G1 X84.919 Y103.164 E.00869
G1 X84.327 Y103.269 E.01272
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.652 Y102.983 E.01104
G1 X82.224 Y102.754 E.01027
G1 X81.902 Y102.522 E.0084
G1 X81.606 Y102.251 E.0085
G1 X81.344 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.0085
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01254
G1 X80.753 Y99.095 E.00869
G1 X80.871 Y98.712 E.00849
G1 X81.038 Y98.337 E.00869
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.321 Y96.452 E.00532
G1 X77.202 Y96.414 E.00266
G1 X77.013 Y96.309 E.00457
G1 X76.826 Y96.121 E.00562
G1 X76.731 Y95.957 E.00399
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.897 Y76.996 E.00329
G1 X76.997 Y76.906 E.00285
G1 X77.237 Y76.774 E.00578
G1 X77.488 Y76.723 E.00543
G1 X90.528 Y76.721 E.276
G1 X90.743 Y76.748 E.0046
G1 X90.883 Y76.794 E.00311
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.986 Y77.082 E.27567
G1 X77.717 Y77.124 E.00576
G1 X77.418 Y77.278 E.00711
G1 X77.182 Y77.529 E.0073
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.971 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.8 Y100.336 E.00874
G1 X87.738 Y100.698 E.00724
G1 X87.59 Y101.213 E.01054
G1 X87.445 Y101.551 E.00722
G1 X87.303 Y101.82 E.00598
G1 X87.05 Y102.197 E.00894
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.693 E.00891
G1 X86.245 Y102.979 E.00891
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00892
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.479 Y103.355 E.01161
G1 X82.007 Y103.102 E.01053
G1 X81.643 Y102.84 E.00882
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.567 E.00885
G1 X80.672 Y98.153 E.00891
G1 X80.778 Y97.962 E.0043
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00621
G1 X77.049 Y96.795 E.00382
G1 X76.889 Y96.717 E.00349
G1 X76.631 Y96.52 E.00638
G1 X76.418 Y96.246 E.00684
M73 P65 R8
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.598 Y76.716 E.00444
G1 X76.744 Y76.583 E.00389
G1 X76.889 Y76.485 E.00343
G1 X77.095 Y76.389 E.00447
G1 X77.285 Y76.336 E.00389
G1 X77.461 Y76.313 E.00349
G1 X90.553 Y76.312 E.25751
G1 X90.834 Y76.347 E.00557
G1 X91.045 Y76.417 E.00438
G1 X91.241 Y76.522 E.00436
G1 X91.473 Y76.717 E.00596
G1 X91.637 Y76.934 E.00535
G1 X91.747 Y77.161 E.00496
G1 X91.804 Y77.375 E.00434
G1 X91.811 Y77.491 E.00229
G1 X78.018 Y77.491 E.27129
G1 X77.846 Y77.518 E.00343
G1 X77.668 Y77.61 E.00394
G1 X77.525 Y77.762 E.00411
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16882
G1 X87.167 Y97.767 E-.04154
G1 X87.401 Y98.159 E-.08667
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04136
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




G1 X86.153 Y97.775
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380221
G1 F1500
M204 S6000
G1 X85.981 Y97.605 E.00429
; LINE_WIDTH: 0.419769
G1 X85.783 Y97.411 E.00545
; LINE_WIDTH: 0.468123
G1 X85.484 Y97.162 E.00858
M204 S10000
G1 X86.153 Y97.775 F18000
; LINE_WIDTH: 0.36029
G1 F1500
M204 S6000
G1 X86.417 Y98.077 E.00669
G1 X86.698 Y98.533 E.00893
G1 X86.843 Y98.857 E.00592
G1 X86.98 Y99.352 E.00857
G1 X87.036 Y99.903 E.00925
G1 X87.012 Y100.237 E.00559
G1 X86.967 Y100.523 E.00482
G1 X86.847 Y100.945 E.00733
G1 X86.622 Y101.415 E.0087
G1 X86.314 Y101.845 E.00883
G1 X86.061 Y102.108 E.00609
G1 X85.777 Y102.344 E.00615
G1 X85.467 Y102.536 E.00608
G1 X85.155 Y102.683 E.00576
G1 X84.636 Y102.84 E.00904
G1 X84.082 Y102.9 E.0093
G1 X83.734 Y102.885 E.00581
G1 X83.393 Y102.831 E.00576
G1 X82.847 Y102.655 E.00957
G1 X82.395 Y102.412 E.00857
G1 X81.974 Y102.078 E.00897
G1 X81.648 Y101.716 E.00813
G1 X81.453 Y101.418 E.00594
G1 X81.289 Y101.103 E.00593
G1 X81.133 Y100.65 E.008
G1 X81.071 Y100.354 E.00505
G1 X81.041 Y100.069 E.00478
G1 X81.046 Y99.704 E.0061
G1 X81.124 Y99.184 E.00878
G1 X81.242 Y98.811 E.00653
G1 X81.496 Y98.305 E.00944
G1 X81.827 Y97.872 E.0091
G1 X82.025 Y97.669 E.00474
; LINE_WIDTH: 0.401775
G1 X82.203 Y97.487 E.00478
; LINE_WIDTH: 0.438833
G1 X82.404 Y97.315 E.00545
; LINE_WIDTH: 0.475197
G1 X82.578 Y97.167 E.00513
; WIPE_START
G1 X82.404 Y97.315 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.463 Y96.254 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.150496
G1 F1500
M204 S6000
G1 X77.234 Y96.115 E.00167
G1 X77.061 Y95.967 E.00142
G1 X76.982 Y95.849 E.00089
G1 X76.882 Y95.627 E.00151
; WIPE_START
G1 X76.982 Y95.849 E-.10483
G1 X77.061 Y95.967 E-.06139
G1 X77.234 Y96.115 E-.09817
G1 X77.463 Y96.254 E-.11561
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.229 Y88.625 Z2.64 F18000
G1 X76.889 Y77.601 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.0995706
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00083
; LINE_WIDTH: 0.154206
G1 X77.108 Y77.191 E.00157
G1 X77.229 Y77.08 E.00105
; LINE_WIDTH: 0.128183
G1 X77.431 Y76.991 E.00113
; LINE_WIDTH: 0.0895846
G1 X77.536 Y76.955 E.00035
; WIPE_START
G1 X77.431 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.994 Y80.888 Z2.64 F18000
G1 X93.178 Y86.344 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/49
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I-.954 J-.755 P1  F18000
G1 X85.194 Y97.081 Z2.64
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.00874
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.356 Y96.93 E.01157
G1 X82.8 Y97.11 E.01238
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X84.957 Y96.544 E.04046
G1 X85.3 Y96.916 E.0107
G1 X85.226 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.08211
G1 X84.428 Y96.88 E-.0722
G1 X83.898 Y96.856 E-.1008
G1 X83.356 Y96.93 E-.10385
G1 X83.251 Y96.964 E-.02104
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.461 Y100.882 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.106 E.00518
G1 X86.223 Y101.341 E.00577
G1 X85.906 Y101.738 E.01076
G1 X85.551 Y102.039 E.00984
G1 X85.278 Y102.207 E.00679
G1 X85.032 Y102.324 E.00577
G1 X84.546 Y102.473 E.01076
G1 X84.083 Y102.521 E.00984
G1 X83.763 Y102.507 E.00678
G1 X83.494 Y102.464 E.00578
G1 X83.008 Y102.314 E.01076
G1 X82.591 Y102.089 E.01004
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.038 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.292 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.519 E.00955
G1 X81.508 Y99.206 E.00678
G1 X81.595 Y98.947 E.00577
G1 X81.823 Y98.493 E.01076
G1 X82.113 Y98.118 E.01003
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.451 Y97.345 E.00975
G1 X83.917 Y97.282 E.00995
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X84.992 Y97.462 E.00663
G1 X85.274 Y97.592 E.00659
G1 X85.507 Y97.734 E.00577
G1 X85.892 Y98.052 E.01056
G1 X86.108 Y98.298 E.00692
G1 X86.289 Y98.565 E.00683
G1 X86.489 Y98.98 E.00975
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.492 Y100.813 E.00975
G1 X86.485 Y100.827 E.00033
M204 S250
G1 X86.087 Y100.716 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.918 E.00436
G1 X85.885 Y101.108 E.00433
G1 X85.611 Y101.452 E.00865
G1 X85.31 Y101.707 E.00776
G1 X85.083 Y101.847 E.00525
G1 X84.884 Y101.941 E.00433
G1 X84.463 Y102.07 E.00864
G1 X84.071 Y102.111 E.00776
G1 X83.805 Y102.099 E.00524
G1 X83.587 Y102.065 E.00433
G1 X83.167 Y101.935 E.00864
G1 X82.817 Y101.746 E.00782
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.86 E.0078
G1 X81.905 Y100.492 E.00773
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.848 Y99.574 E.00767
G1 X81.904 Y99.314 E.00525
G1 X81.974 Y99.105 E.00433
G1 X82.171 Y98.712 E.00865
G1 X82.414 Y98.397 E.00782
G1 X82.706 Y98.134 E.00774
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.746 E.00773
G1 X83.936 Y97.692 E.0078
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.842 Y97.843 E.0052
G1 X85.082 Y97.954 E.00519
G1 X85.27 Y98.069 E.00433
G1 X85.606 Y98.346 E.00858
G1 X85.783 Y98.549 E.00529
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00773
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.0078
G1 X86.109 Y100.66 E.00744
; WIPE_START
M204 S6000
G1 X85.997 Y100.918 E-.05352
G1 X85.885 Y101.108 E-.04186
G1 X85.611 Y101.452 E-.08352
G1 X85.31 Y101.707 E-.07498
G1 X85.083 Y101.847 E-.05069
G1 X84.884 Y101.941 E-.04184
G1 X84.715 Y101.993 E-.03359
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.2 Y96.12 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12291
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.476 Y96.482 E.10649
G1 X86.579 Y97.675 E.03439
G1 X86.829 Y98 E.00869
G1 X87.119 Y98.517 E.01254
G1 X87.266 Y98.91 E.00888
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.091 E.01273
G1 X87.339 Y100.603 E.01095
G1 X87.203 Y101.076 E.01041
G1 X86.95 Y101.612 E.01255
G1 X86.602 Y102.1 E.01269
G1 X86.318 Y102.393 E.00862
G1 X86.068 Y102.599 E.00687
G1 X85.678 Y102.855 E.00987
G1 X85.308 Y103.032 E.00869
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.656 Y102.985 E.01094
G1 X82.224 Y102.754 E.01037
G1 X81.902 Y102.522 E.0084
G1 X81.606 Y102.251 E.00849
G1 X81.344 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.753 Y99.095 E.00869
G1 X80.871 Y98.711 E.00849
G1 X81.038 Y98.337 E.00869
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.324 Y96.453 E.00527
G1 X77.178 Y96.405 E.00324
G1 X76.926 Y96.233 E.00646
G1 X76.775 Y96.044 E.00511
G1 X76.683 Y95.815 E.00524
G1 X76.654 Y95.565 E.00533
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.897 Y76.996 E.00349
G1 X76.996 Y76.907 E.00282
G1 X77.234 Y76.775 E.00576
G1 X77.484 Y76.723 E.00539
G1 X90.529 Y76.721 E.27612
G1 X90.743 Y76.748 E.00457
G1 X90.883 Y76.794 E.00311
G1 X91.059 Y76.889 E.00424
G1 X91.01 Y77.082 E.0042
G1 X77.986 Y77.082 E.27568
G1 X77.716 Y77.125 E.00578
G1 X77.423 Y77.276 E.00698
G1 X77.196 Y77.508 E.00687
G1 X77.053 Y77.801 E.0069
G1 X77.016 Y78.056 E.00546
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00795
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.14 Y96.12 E.15173
; WIPE_START
M204 S6000
G1 X87.14 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.412 Y96.891 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01393
G1 X87.168 Y97.77 E.00891
G1 X87.401 Y98.159 E.00891
G1 X87.495 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.8 Y100.336 E.00874
G1 X87.739 Y100.694 E.00715
G1 X87.59 Y101.214 E.01064
G1 X87.447 Y101.547 E.00712
G1 X87.302 Y101.82 E.00609
G1 X87.101 Y102.125 E.00719
G1 X86.911 Y102.369 E.00608
G1 X86.596 Y102.694 E.00889
G1 X86.316 Y102.925 E.00716
G1 X86.06 Y103.104 E.00614
G1 X85.871 Y103.216 E.00433
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00892
G1 X84.82 Y103.609 E.00431
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.483 Y103.357 E.01152
G1 X82.007 Y103.102 E.01062
G1 X81.643 Y102.84 E.00882
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.113 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.567 E.00885
G1 X80.672 Y98.153 E.00891
M73 P66 R8
G1 X80.778 Y97.962 E.0043
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.895 Y96.721 E.00277
G1 X76.648 Y96.536 E.00607
G1 X76.499 Y96.368 E.00442
G1 X76.419 Y96.247 E.00286
G1 X76.34 Y96.086 E.00353
G1 X76.281 Y95.902 E.00379
G1 X76.245 Y95.589 E.00621
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.598 Y76.715 E.0045
G1 X76.743 Y76.584 E.00385
G1 X76.889 Y76.485 E.00347
G1 X77.094 Y76.389 E.00445
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.555 Y76.312 E.25757
G1 X90.834 Y76.347 E.00554
G1 X91.045 Y76.417 E.00438
G1 X91.241 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.018 Y77.491 E.27129
G1 X77.845 Y77.518 E.00344
G1 X77.669 Y77.609 E.00389
G1 X77.535 Y77.747 E.00379
G1 X77.449 Y77.923 E.00387
G1 X77.425 Y78.086 E.00323
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.472 Y96.891 E.07974
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12708
G1 X87.168 Y97.77 E-.08606
G1 X87.401 Y98.159 E-.08607
G1 X87.495 Y98.356 E-.0416
G1 X87.568 Y98.549 E-.03918
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




G1 X86.148 Y97.769
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380327
G1 F1500
M204 S6000
G1 X85.954 Y97.586 E.00471
; LINE_WIDTH: 0.419057
G1 X85.733 Y97.38 E.00594
; LINE_WIDTH: 0.455597
G1 X85.575 Y97.254 E.00434
; LINE_WIDTH: 0.481757
G1 X85.416 Y97.128 E.00461
M204 S10000
G1 X86.148 Y97.769 F18000
; LINE_WIDTH: 0.360183
G1 F1500
M204 S6000
G1 X86.513 Y98.215 E.00962
G1 X86.699 Y98.53 E.00609
G1 X86.844 Y98.862 E.00605
G1 X86.979 Y99.352 E.00848
G1 X87.008 Y99.536 E.00311
G1 X87.026 Y100.07 E.00891
G1 X86.982 Y100.451 E.00639
G1 X86.846 Y100.948 E.00861
G1 X86.693 Y101.287 E.0062
G1 X86.457 Y101.662 E.0074
G1 X86.164 Y102.011 E.0076
G1 X85.782 Y102.336 E.00837
G1 X85.495 Y102.521 E.00569
G1 X85.158 Y102.682 E.00624
G1 X84.636 Y102.836 E.00908
G1 X84.29 Y102.886 E.00583
G1 X84.082 Y102.895 E.00346
G1 X83.734 Y102.884 E.00581
G1 X83.243 Y102.789 E.00835
G1 X82.848 Y102.655 E.00696
G1 X82.395 Y102.412 E.00858
G1 X81.974 Y102.078 E.00897
G1 X81.648 Y101.716 E.00813
G1 X81.453 Y101.418 E.00594
G1 X81.289 Y101.103 E.00593
G1 X81.145 Y100.701 E.00712
G1 X81.082 Y100.423 E.00476
G1 X81.042 Y100.071 E.0059
G1 X81.058 Y99.545 E.00878
G1 X81.123 Y99.186 E.0061
G1 X81.241 Y98.813 E.00652
G1 X81.495 Y98.305 E.00948
G1 X81.827 Y97.872 E.0091
G1 X82.021 Y97.673 E.00464
; LINE_WIDTH: 0.40064
G1 X82.195 Y97.496 E.00465
; LINE_WIDTH: 0.43843
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477116
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.422 Y96.245 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.155488
G1 F1500
M204 S6000
G1 X77.058 Y95.971 E.00295
G1 X76.975 Y95.833 E.00104
; LINE_WIDTH: 0.127207
G1 X76.935 Y95.728 E.00057
; LINE_WIDTH: 0.0942109
G1 X76.896 Y95.622 E.00039
; WIPE_START
G1 X76.935 Y95.728 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.916 Y88.095 Z2.76 F18000
G1 X76.889 Y77.604 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.101457
G1 F1500
M204 S6000
G1 X76.946 Y77.423 E.00071
; LINE_WIDTH: 0.153064
G1 X76.998 Y77.32 E.00073
G1 X77.229 Y77.081 E.00211
; LINE_WIDTH: 0.128457
G1 X77.43 Y76.991 E.00113
; LINE_WIDTH: 0.0895581
G1 X77.536 Y76.955 E.00036
; WIPE_START
G1 X77.43 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.992 Y80.889 Z2.76 F18000
G1 X93.178 Y86.344 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/49
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I-.957 J-.752 P1  F18000
G1 X85.247 Y97.098 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.00992
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.165 Y96.981 E.00804
G1 X82.796 Y97.126 E.00839
G1 X82.681 Y96.963 E.00423
G1 X83.046 Y96.544 E.01174
G1 X85.008 Y96.544 E.04153
G1 X85.353 Y96.936 E.01106
G1 X85.28 Y97.048 E.00284
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09273
G1 X84.428 Y96.88 E-.07221
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07217
G1 X83.305 Y96.949 E-.04507
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.449 Y100.905 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.237 Y101.323 E.00992
G1 X85.906 Y101.738 E.01123
G1 X85.539 Y102.049 E.01018
G1 X85.053 Y102.317 E.01175
G1 X84.546 Y102.473 E.01123
G1 X84.068 Y102.523 E.01018
G1 X83.515 Y102.471 E.01175
G1 X83.008 Y102.314 E.01123
G1 X82.591 Y102.089 E.01004
G1 X82.223 Y101.796 E.00995
G1 X81.92 Y101.449 E.00975
G1 X81.746 Y101.177 E.00683
G1 X81.606 Y100.886 E.00683
G1 X81.47 Y100.446 E.00975
G1 X81.414 Y99.979 E.00995
G1 X81.443 Y99.504 E.01008
G1 X81.585 Y98.967 E.01175
G1 X81.823 Y98.493 E.01123
G1 X82.116 Y98.114 E.01014
G1 X82.508 Y97.771 E.01103
G1 X82.865 Y97.555 E.00884
G1 X83.291 Y97.388 E.00969
G1 X83.606 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.789 Y97.953 E.00995
G1 X86.101 Y98.289 E.0097
G1 X86.254 Y98.51 E.00571
G1 X86.431 Y98.839 E.0079
G1 X86.579 Y99.27 E.00965
G1 X86.636 Y99.588 E.00683
G1 X86.656 Y99.91 E.00683
G1 X86.614 Y100.369 E.00975
G1 X86.488 Y100.828 E.01008
G1 X86.476 Y100.852 E.00057
M204 S250
G1 X86.083 Y100.721 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.891 Y101.101 E.00839
G1 X85.611 Y101.451 E.00882
G1 X85.306 Y101.71 E.00787
G1 X84.892 Y101.938 E.00928
G1 X84.464 Y102.07 E.00882
G1 X84.066 Y102.112 E.00787
G1 X83.596 Y102.067 E.00929
G1 X83.167 Y101.935 E.00882
G1 X82.817 Y101.746 E.00782
G1 X82.507 Y101.499 E.0078
G1 X82.248 Y101.203 E.00773
G1 X82.104 Y100.977 E.00526
G1 X81.988 Y100.736 E.00526
G1 X81.872 Y100.361 E.00773
G1 X81.825 Y99.967 E.0078
G1 X81.849 Y99.569 E.00784
G1 X81.97 Y99.113 E.00929
G1 X82.171 Y98.712 E.00882
G1 X82.415 Y98.396 E.00786
G1 X82.75 Y98.103 E.00876
G1 X83.047 Y97.923 E.00682
G1 X83.412 Y97.78 E.00771
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00773
G1 X85.514 Y98.258 E.00779
G1 X85.781 Y98.546 E.00772
G1 X85.905 Y98.725 E.00428
G1 X86.055 Y99.003 E.00622
G1 X86.182 Y99.374 E.0077
G1 X86.229 Y99.637 E.00526
G1 X86.245 Y99.904 E.00526
G1 X86.21 Y100.296 E.00773
G1 X86.108 Y100.666 E.00756
; WIPE_START
M204 S6000
G1 X85.891 Y101.101 E-.09237
G1 X85.611 Y101.451 E-.08523
G1 X85.306 Y101.71 E-.07601
G1 X84.892 Y101.938 E-.08969
G1 X84.708 Y101.995 E-.0367
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.256 Y96.12 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12173
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.518 Y96.482 E.10561
G1 X86.662 Y97.777 E.03657
G1 X86.827 Y97.997 E.00583
G1 X87.04 Y98.353 E.00877
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.075 E.01259
G1 X87.337 Y100.608 E.01139
G1 X87.203 Y101.076 E.01031
G1 X86.946 Y101.618 E.01269
G1 X86.599 Y102.103 E.01262
G1 X86.318 Y102.393 E.00854
G1 X86.071 Y102.597 E.00678
G1 X85.678 Y102.855 E.00997
G1 X85.307 Y103.032 E.00869
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.157 Y103.165 E.01241
G1 X82.651 Y102.982 E.01139
G1 X82.224 Y102.754 E.01025
G1 X81.902 Y102.522 E.0084
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.708 Y100.495 E.00836
G1 X80.658 Y99.969 E.01119
G1 X80.681 Y99.485 E.01026
G1 X80.754 Y99.086 E.00859
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.129 Y96.38 E.00459
G1 X77.036 Y96.324 E.00227
G1 X76.85 Y96.151 E.00539
G1 X76.773 Y96.039 E.00288
G1 X76.683 Y95.815 E.00511
G1 X76.654 Y95.565 E.00533
G1 X76.654 Y77.625 E.37971
G1 X76.694 Y77.344 E.006
G1 X76.801 Y77.118 E.00529
G1 X76.995 Y76.907 E.00607
G1 X77.234 Y76.775 E.00578
G1 X77.484 Y76.723 E.00539
G1 X90.531 Y76.721 E.27615
G1 X90.743 Y76.748 E.00453
G1 X90.883 Y76.794 E.00311
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.282 E.00668
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.196 Y96.12 E.15291
; WIPE_START
M204 S6000
G1 X87.196 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.426 Y96.891 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.979 Y97.518 E.01645
G1 X87.168 Y97.769 E.00617
G1 X87.401 Y98.159 E.00894
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.108 E.00426
G1 X87.739 Y100.693 E.0116
G1 X87.59 Y101.214 E.01066
G1 X87.449 Y101.542 E.00703
G1 X87.184 Y102.009 E.01056
G1 X86.91 Y102.37 E.00891
G1 X86.596 Y102.694 E.00887
G1 X86.32 Y102.922 E.00706
G1 X86.06 Y103.104 E.00624
G1 X85.871 Y103.216 E.00433
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.609 E.00431
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.039 Y103.557 E.00427
G1 X82.484 Y103.357 E.0116
G1 X82.007 Y103.102 E.01064
G1 X81.643 Y102.84 E.00882
G1 X81.311 Y102.536 E.00885
M73 P67 R8
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.563 E.00881
G1 X80.248 Y99.979 E.01153
G1 X80.274 Y99.438 E.01065
G1 X80.355 Y98.994 E.00888
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.952 Y96.751 E.00597
G1 X76.802 Y96.661 E.00344
G1 X76.65 Y96.538 E.00385
G1 X76.529 Y96.406 E.00352
G1 X76.418 Y96.245 E.00385
G1 X76.34 Y96.084 E.00352
G1 X76.281 Y95.902 E.00376
G1 X76.245 Y95.589 E.00621
G1 X76.245 Y77.609 E.35364
G1 X76.261 Y77.406 E.004
G1 X76.3 Y77.23 E.00356
G1 X76.35 Y77.093 E.00286
G1 X76.458 Y76.893 E.00448
G1 X76.598 Y76.715 E.00444
G1 X76.742 Y76.585 E.00382
G1 X76.889 Y76.485 E.0035
G1 X77.094 Y76.389 E.00445
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.557 Y76.312 E.2576
G1 X90.834 Y76.347 E.0055
G1 X91.045 Y76.417 E.00438
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.304 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.486 Y96.891 E.07946
; WIPE_START
M204 S6000
G1 X86.979 Y97.518 E-.15162
G1 X87.168 Y97.769 E-.05958
G1 X87.401 Y98.159 E-.08635
G1 X87.495 Y98.356 E-.0416
G1 X87.571 Y98.557 E-.04085
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




G1 X86.037 Y97.654
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360586
G1 F1500
M204 S6000
G1 X86.388 Y98.042 E.00875
G1 X86.581 Y98.321 E.00566
G1 X86.769 Y98.677 E.00673
G1 X86.938 Y99.165 E.00862
G1 X87.012 Y99.533 E.00627
G1 X87.027 Y100.049 E.00863
G1 X86.981 Y100.45 E.00674
G1 X86.846 Y100.949 E.00863
G1 X86.615 Y101.425 E.00884
G1 X86.305 Y101.854 E.00883
G1 X86.058 Y102.111 E.00596
G1 X85.766 Y102.349 E.0063
G1 X85.216 Y102.658 E.01053
G1 X84.817 Y102.792 E.00704
G1 X84.29 Y102.886 E.00894
G1 X84.054 Y102.896 E.00395
G1 X83.768 Y102.882 E.00477
G1 X83.263 Y102.795 E.00857
G1 X82.849 Y102.654 E.00731
G1 X82.395 Y102.412 E.00859
G1 X81.974 Y102.078 E.00898
G1 X81.648 Y101.716 E.00813
G1 X81.421 Y101.37 E.00692
G1 X81.259 Y101.036 E.0062
G1 X81.099 Y100.51 E.00918
G1 X81.039 Y100.005 E.00849
G1 X81.06 Y99.529 E.00797
G1 X81.13 Y99.178 E.00598
G1 X81.241 Y98.819 E.00627
G1 X81.495 Y98.306 E.00957
G1 X81.831 Y97.868 E.00922
G1 X82.05 Y97.645 E.00522
; LINE_WIDTH: 0.412438
G1 X82.248 Y97.447 E.00542
; LINE_WIDTH: 0.43552
G1 X82.275 Y97.422 E.00074
; LINE_WIDTH: 0.463441
G1 X82.57 Y97.174 E.00843
; WIPE_START
G1 X82.275 Y97.422 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.32 Y97.374 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.465691
G1 F1500
M204 S6000
M73 P67 R7
G1 X85.647 Y97.295 E.00739
G1 X85.786 Y97.423 E.00417
; LINE_WIDTH: 0.428458
G1 X85.912 Y97.538 E.00342
; LINE_WIDTH: 0.393777
G1 X86.037 Y97.654 E.00313
; WIPE_START
G1 X85.912 Y97.538 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.367 Y96.384 Z2.88 F18000
G1 X77.48 Y96.249 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.149064
G1 F1500
M204 S6000
G1 X77.252 Y96.126 E.00159
G1 X77.125 Y96.033 E.00097
G1 X77.045 Y95.951 E.00071
G1 X76.975 Y95.834 E.00084
; LINE_WIDTH: 0.127475
G1 X76.935 Y95.728 E.00057
; LINE_WIDTH: 0.0943119
G1 X76.896 Y95.622 E.00039
; WIPE_START
G1 X76.935 Y95.728 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.917 Y88.095 Z2.88 F18000
G1 X76.891 Y77.597 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.0998062
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00081
; LINE_WIDTH: 0.154198
G1 X77.108 Y77.191 E.00158
G1 X77.229 Y77.08 E.00106
; LINE_WIDTH: 0.131098
G1 X77.412 Y76.995 E.00106
; LINE_WIDTH: 0.0957304
G1 X77.499 Y76.963 E.00032
; LINE_WIDTH: 0.0812161
G1 X77.531 Y76.955 E.00009
; WIPE_START
G1 X77.499 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.049 Y80.882 Z2.88 F18000
G1 X93.178 Y86.344 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 21/49
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-.954 J-.755 P1  F18000
G1 X85.194 Y97.081 Z2.88
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.00874
G1 X84.428 Y96.88 E.00804
G1 X83.898 Y96.856 E.01123
G1 X83.357 Y96.93 E.01157
G1 X82.8 Y97.11 E.01238
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X84.957 Y96.544 E.04046
G1 X85.3 Y96.916 E.0107
G1 X85.226 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.0821
G1 X84.428 Y96.88 E-.07221
G1 X83.898 Y96.856 E-.10079
G1 X83.357 Y96.93 E-.10383
G1 X83.251 Y96.964 E-.02107
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.446 Y100.911 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.238 Y101.321 E.00974
G1 X85.906 Y101.738 E.01128
G1 X85.539 Y102.049 E.01018
G1 X85.055 Y102.316 E.0117
G1 X84.546 Y102.473 E.01128
G1 X84.068 Y102.523 E.01018
G1 X83.518 Y102.471 E.0117
G1 X83.008 Y102.314 E.01128
G1 X82.59 Y102.089 E.01005
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.038 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.51 E.00975
G1 X81.552 Y99.063 E.00975
G1 X81.674 Y98.764 E.00683
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.451 Y97.345 E.00975
G1 X83.917 Y97.282 E.00995
G1 X84.377 Y97.302 E.00975
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.205 Y98.432 E.00683
G1 X86.43 Y98.835 E.00975
G1 X86.579 Y99.271 E.00975
G1 X86.636 Y99.588 E.00683
G1 X86.656 Y99.91 E.00683
G1 X86.614 Y100.369 E.00975
G1 X86.488 Y100.828 E.01008
G1 X86.473 Y100.857 E.00069
M204 S250
G1 X86.081 Y100.726 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.892 Y101.099 E.00822
G1 X85.611 Y101.451 E.00887
G1 X85.306 Y101.71 E.00787
G1 X84.895 Y101.937 E.00924
G1 X84.464 Y102.07 E.00887
G1 X84.066 Y102.112 E.00787
G1 X83.598 Y102.068 E.00924
G1 X83.167 Y101.935 E.00887
G1 X82.817 Y101.746 E.00783
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00779
G1 X82.043 Y100.86 E.0078
G1 X81.905 Y100.492 E.00773
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00774
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00526
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00774
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00773
G1 X83.936 Y97.692 E.0078
G1 X84.328 Y97.71 E.00773
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00774
G1 X85.512 Y98.256 E.00773
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.054 Y99.002 E.00773
G1 X86.182 Y99.374 E.00773
G1 X86.229 Y99.637 E.00526
G1 X86.245 Y99.904 E.00526
G1 X86.21 Y100.296 E.00773
G1 X86.106 Y100.672 E.00768
; WIPE_START
M204 S6000
G1 X85.892 Y101.099 E-.09078
G1 X85.611 Y101.451 E-.08567
G1 X85.306 Y101.71 E-.07604
G1 X84.895 Y101.937 E-.08922
G1 X84.702 Y101.996 E-.03829
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.2 Y96.12 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12291
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.787 Y96.442 E.00324
G1 X90.517 Y96.482 E.00577
G1 X85.476 Y96.482 E.10668
G1 X86.579 Y97.675 E.03439
G1 X86.829 Y98 E.00868
G1 X87.04 Y98.353 E.00869
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.075 E.0126
G1 X87.338 Y100.604 E.01129
G1 X87.203 Y101.077 E.01041
G1 X86.953 Y101.605 E.01237
G1 X86.651 Y102.037 E.01117
G1 X86.314 Y102.396 E.01041
G1 X86.075 Y102.594 E.00657
G1 X85.678 Y102.855 E.01006
G1 X85.305 Y103.033 E.00874
G1 X85.007 Y103.136 E.00667
G1 X84.736 Y103.207 E.00594
G1 X84.327 Y103.269 E.00876
G1 X83.734 Y103.267 E.01254
G1 X83.157 Y103.165 E.01241
G1 X82.655 Y102.984 E.01129
G1 X82.223 Y102.754 E.01035
G1 X81.902 Y102.522 E.00839
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.0085
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01254
G1 X80.753 Y99.095 E.00869
G1 X80.869 Y98.717 E.00836
G1 X81.092 Y98.243 E.01109
G1 X81.361 Y97.834 E.01035
G1 X82.538 Y96.482 E.03795
G1 X77.571 Y96.482 E.10513
G1 X77.321 Y96.452 E.00533
G1 X77.205 Y96.415 E.00256
G1 X77.107 Y96.368 E.0023
G1 X76.919 Y96.228 E.00498
G1 X76.772 Y96.037 E.0051
G1 X76.683 Y95.815 E.00505
G1 X76.654 Y95.565 E.00534
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.994 Y76.908 E.00623
G1 X77.234 Y76.775 E.00582
G1 X77.484 Y76.723 E.00539
G1 X90.532 Y76.721 E.27619
G1 X90.743 Y76.748 E.00449
G1 X90.878 Y76.793 E.00302
G1 X91.055 Y76.891 E.00427
G1 X91.005 Y77.082 E.00417
G1 X77.981 Y77.082 E.27567
G1 X77.692 Y77.132 E.0062
G1 X77.422 Y77.278 E.0065
G1 X77.205 Y77.495 E.00649
G1 X77.053 Y77.797 E.00716
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
M73 P68 R7
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.14 Y96.12 E.15173
; WIPE_START
M204 S6000
G1 X87.14 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.412 Y96.891 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01393
G1 X87.168 Y97.77 E.00891
G1 X87.401 Y98.159 E.00891
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.108 E.00426
G1 X87.74 Y100.688 E.01151
G1 X87.59 Y101.214 E.01076
G1 X87.451 Y101.538 E.00694
G1 X87.304 Y101.818 E.00622
G1 X86.969 Y102.296 E.01147
G1 X86.595 Y102.695 E.01076
G1 X86.323 Y102.92 E.00693
G1 X86.06 Y103.104 E.00633
G1 X85.871 Y103.216 E.00433
G1 X85.461 Y103.412 E.00893
G1 X85.126 Y103.528 E.00697
G1 X84.818 Y103.609 E.00626
G1 X84.369 Y103.676 E.00893
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.039 Y103.557 E.00426
G1 X82.489 Y103.359 E.01151
G1 X82.007 Y103.102 E.01074
G1 X81.643 Y102.84 E.00882
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.487 Y98.569 E.00881
G1 X80.734 Y98.043 E.01144
G1 X81.034 Y97.586 E.01074
G1 X81.639 Y96.891 E.01813
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00621
G1 X77.053 Y96.796 E.00373
G1 X76.894 Y96.72 E.00347
G1 X76.645 Y96.534 E.0061
G1 X76.549 Y96.432 E.00277
G1 X76.418 Y96.244 E.00451
G1 X76.339 Y96.083 E.00354
G1 X76.281 Y95.902 E.00372
G1 X76.245 Y95.589 E.00621
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.598 Y76.715 E.0045
G1 X76.74 Y76.586 E.00379
G1 X76.889 Y76.485 E.00353
G1 X77.094 Y76.389 E.00445
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.558 Y76.312 E.25764
G1 X90.834 Y76.347 E.00547
G1 X91.044 Y76.417 E.00435
G1 X91.269 Y76.542 E.00506
G1 X91.472 Y76.716 E.00527
G1 X91.635 Y76.93 E.00527
G1 X91.747 Y77.161 E.00506
G1 X91.804 Y77.375 E.00434
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.669 Y77.61 E.00356
G1 X77.541 Y77.738 E.00355
G1 X77.449 Y77.922 E.00406
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.304 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.681 Y96.882 E.00448
G1 X90.529 Y96.891 E.00301
G1 X86.472 Y96.891 E.0798
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12708
G1 X87.168 Y97.77 E-.08605
G1 X87.401 Y98.159 E-.08609
G1 X87.495 Y98.356 E-.0416
G1 X87.568 Y98.549 E-.03918
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




G1 X86.026 Y97.647
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397654
G1 F1500
M204 S6000
G1 X85.842 Y97.48 E.00462
; LINE_WIDTH: 0.442833
G1 X85.657 Y97.314 E.00518
; LINE_WIDTH: 0.480645
G1 X85.415 Y97.129 E.0069
M204 S10000
G1 X86.026 Y97.647 F18000
; LINE_WIDTH: 0.360493
G1 F1500
M204 S6000
G1 X86.289 Y97.921 E.00633
G1 X86.528 Y98.234 E.00659
G1 X86.766 Y98.669 E.00828
G1 X86.938 Y99.165 E.00876
G1 X87.012 Y99.533 E.00627
G1 X87.027 Y100.05 E.00864
G1 X86.981 Y100.45 E.00674
G1 X86.846 Y100.95 E.00864
G1 X86.625 Y101.405 E.00845
G1 X86.352 Y101.795 E.00795
G1 X86.051 Y102.116 E.00735
G1 X85.766 Y102.349 E.00615
G1 X85.218 Y102.656 E.01048
G1 X84.895 Y102.768 E.00571
G1 X84.606 Y102.845 E.005
G1 X84.086 Y102.896 E.00873
G1 X83.768 Y102.882 E.00531
G1 X83.262 Y102.794 E.00858
G1 X82.849 Y102.654 E.00729
G1 X82.395 Y102.412 E.00859
G1 X81.974 Y102.078 E.00898
G1 X81.648 Y101.716 E.00813
G1 X81.453 Y101.418 E.00595
G1 X81.289 Y101.103 E.00594
G1 X81.151 Y100.725 E.00671
G1 X81.069 Y100.338 E.00661
G1 X81.039 Y99.988 E.00587
G1 X81.072 Y99.439 E.00918
G1 X81.197 Y98.934 E.00869
G1 X81.425 Y98.429 E.00926
G1 X81.667 Y98.067 E.00728
G1 X82.021 Y97.673 E.00883
; LINE_WIDTH: 0.400648
G1 X82.195 Y97.496 E.00465
; LINE_WIDTH: 0.438435
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.47713
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.435 Y96.249 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.150998
G1 F1500
M204 S6000
G1 X77.11 Y96.019 E.00249
G1 X76.973 Y95.829 E.00147
; LINE_WIDTH: 0.126383
G1 X76.934 Y95.726 E.00055
; LINE_WIDTH: 0.0939648
G1 X76.896 Y95.622 E.00038
; WIPE_START
G1 X76.934 Y95.726 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.915 Y88.093 Z3 F18000
G1 X76.889 Y77.604 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.0897445
G1 F1500
M204 S6000
G1 X76.918 Y77.514 E.0003
; LINE_WIDTH: 0.115046
G1 X76.947 Y77.424 E.00042
; LINE_WIDTH: 0.152684
G1 X76.997 Y77.32 E.00073
G1 X77.23 Y77.081 E.00211
; LINE_WIDTH: 0.129824
G1 X77.428 Y76.991 E.00113
; LINE_WIDTH: 0.0897772
G1 X77.531 Y76.955 E.00035
; WIPE_START
G1 X77.428 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.99 Y80.888 Z3 F18000
G1 X93.178 Y86.344 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/49
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I-.958 J-.751 P1  F18000
G1 X85.263 Y97.104 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.801 Y96.953 E.01029
G1 X84.428 Y96.88 E.00804
G1 X83.914 Y96.857 E.0109
G1 X83.536 Y96.897 E.00804
G1 X83.166 Y96.981 E.00804
G1 X82.796 Y97.126 E.0084
G1 X82.681 Y96.963 E.00423
G1 X83.045 Y96.544 E.01174
G1 X85.024 Y96.544 E.04188
G1 X85.37 Y96.942 E.01116
G1 X85.296 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X84.801 Y96.953 E-.09606
G1 X84.428 Y96.88 E-.07222
G1 X83.914 Y96.857 E-.09782
G1 X83.536 Y96.897 E-.07217
G1 X83.322 Y96.946 E-.04173
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.442 Y100.927 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.205 Y101.373 E.0107
G1 X85.902 Y101.741 E.01007
G1 X85.539 Y102.049 E.01007
G1 X85.058 Y102.315 E.01164
G1 X84.546 Y102.473 E.01134
G1 X84.068 Y102.523 E.01018
G1 X83.52 Y102.472 E.01164
G1 X83.009 Y102.314 E.01133
G1 X82.591 Y102.089 E.01005
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.67 Y101.034 E.01005
G1 X81.49 Y100.53 E.01134
G1 X81.414 Y99.985 E.01164
G1 X81.442 Y99.51 E.01007
G1 X81.554 Y99.054 E.00995
G1 X81.741 Y98.633 E.00975
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.112 E.00683
G1 X82.462 Y97.803 E.00975
G1 X82.862 Y97.556 E.00995
G1 X83.291 Y97.388 E.00975
G1 X83.606 Y97.316 E.00683
G1 X83.926 Y97.282 E.00683
G1 X84.377 Y97.302 E.00955
G1 X84.694 Y97.365 E.00683
G1 X85.001 Y97.465 E.00683
G1 X85.413 Y97.671 E.00975
G1 X85.782 Y97.947 E.00975
G1 X86.008 Y98.177 E.00683
G1 X86.205 Y98.432 E.00683
G1 X86.433 Y98.84 E.00988
G1 X86.601 Y99.363 E.01164
G1 X86.657 Y99.896 E.01134
G1 X86.614 Y100.374 E.01015
G1 X86.468 Y100.873 E.01101
M204 S250
G1 X86.081 Y100.735 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.863 Y101.145 E.00914
G1 X85.61 Y101.452 E.00784
G1 X85.306 Y101.71 E.00784
G1 X84.897 Y101.936 E.00919
G1 X84.464 Y102.07 E.00892
G1 X84.066 Y102.112 E.00787
G1 X83.601 Y102.068 E.00919
G1 X83.167 Y101.935 E.00892
G1 X82.817 Y101.746 E.00783
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.042 Y100.859 E.00783
G1 X81.889 Y100.432 E.00892
G1 X81.825 Y99.969 E.00919
G1 X81.849 Y99.571 E.00784
G1 X81.943 Y99.186 E.00779
G1 X82.102 Y98.827 E.00773
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.709 Y98.132 E.00774
G1 X83.046 Y97.924 E.0078
G1 X83.412 Y97.78 E.00774
G1 X83.673 Y97.72 E.00526
G1 X83.939 Y97.692 E.00526
G1 X84.328 Y97.71 E.00767
G1 X84.591 Y97.762 E.00526
G1 X84.845 Y97.844 E.00526
G1 X85.197 Y98.02 E.00773
G1 X85.512 Y98.256 E.00773
G1 X85.699 Y98.447 E.00526
G1 X85.863 Y98.658 E.00526
G1 X86.055 Y99.003 E.00778
G1 X86.198 Y99.448 E.00919
G1 X86.246 Y99.899 E.00892
G1 X86.21 Y100.297 E.00786
G1 X86.099 Y100.677 E.00779
; WIPE_START
M204 S6000
G1 X85.863 Y101.145 E-.09949
G1 X85.61 Y101.452 E-.07569
G1 X85.306 Y101.71 E-.07569
G1 X84.897 Y101.936 E-.08878
G1 X84.694 Y101.999 E-.04036
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.787 Y96.442 E.00324
G1 X90.517 Y96.482 E.00577
G1 X85.532 Y96.482 E.10551
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.992 E.00386
G1 X87.04 Y98.353 E.00888
G1 X87.266 Y98.91 E.01273
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.075 E.01241
G1 X87.339 Y100.599 E.01119
G1 X87.203 Y101.077 E.01051
M73 P69 R7
G1 X86.949 Y101.613 E.01255
G1 X86.601 Y102.1 E.01268
G1 X86.318 Y102.393 E.00863
G1 X86.078 Y102.591 E.00658
G1 X85.678 Y102.855 E.01015
G1 X85.307 Y103.032 E.00868
G1 X84.918 Y103.164 E.00869
G1 X84.327 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.163 E.01254
G1 X82.762 Y103.032 E.00869
G1 X82.405 Y102.861 E.00837
G1 X81.972 Y102.575 E.011
G1 X81.603 Y102.247 E.01045
G1 X81.345 Y101.947 E.00838
G1 X81.121 Y101.613 E.0085
G1 X80.941 Y101.261 E.00837
G1 X80.771 Y100.77 E.011
G1 X80.677 Y100.286 E.01045
G1 X80.655 Y99.89 E.00839
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.87 Y98.717 E.00837
G1 X81.09 Y98.247 E.011
G1 X81.361 Y97.834 E.01045
G1 X82.538 Y96.482 E.03794
G1 X77.571 Y96.482 E.10512
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.867 Y96.173 E.0054
G1 X76.769 Y96.033 E.00362
G1 X76.683 Y95.812 E.00501
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.993 Y76.909 E.0062
G1 X77.237 Y76.774 E.00591
G1 X77.489 Y76.723 E.00543
G1 X90.534 Y76.721 E.27612
G1 X90.743 Y76.748 E.00446
G1 X90.878 Y76.793 E.00302
G1 X91.054 Y76.891 E.00427
G1 X91.005 Y77.082 E.00416
G1 X77.985 Y77.082 E.27557
G1 X77.714 Y77.125 E.00582
G1 X77.422 Y77.276 E.00695
G1 X77.195 Y77.51 E.0069
G1 X77.053 Y77.801 E.00686
G1 X77.016 Y78.056 E.00545
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.00431
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.108 E.00426
G1 X87.741 Y100.684 E.01142
G1 X87.59 Y101.214 E.01085
G1 X87.453 Y101.534 E.00685
G1 X87.302 Y101.821 E.00637
G1 X87.109 Y102.114 E.0069
G1 X86.911 Y102.369 E.00635
G1 X86.596 Y102.694 E.00889
G1 X86.327 Y102.917 E.00688
G1 X86.06 Y103.104 E.00641
G1 X85.871 Y103.216 E.00433
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00892
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.608 Y103.412 E.00891
G1 X82.204 Y103.219 E.00881
G1 X81.722 Y102.901 E.01135
G1 X81.31 Y102.535 E.01083
G1 X81.018 Y102.195 E.00881
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.422 E.00881
G1 X80.375 Y100.877 E.01135
G1 X80.27 Y100.336 E.01083
G1 X80.245 Y99.889 E.00882
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.487 Y98.569 E.00881
G1 X80.732 Y98.047 E.01135
G1 X81.034 Y97.586 E.01083
G1 X81.639 Y96.891 E.01813
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.648 Y96.537 E.00454
G1 X76.549 Y96.432 E.00283
G1 X76.417 Y96.243 E.00454
G1 X76.352 Y96.114 E.00283
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.598 Y76.715 E.0045
G1 X76.739 Y76.587 E.00376
G1 X76.889 Y76.485 E.00357
G1 X77.095 Y76.389 E.00447
G1 X77.279 Y76.338 E.00376
G1 X77.461 Y76.313 E.00363
G1 X90.56 Y76.312 E.25764
G1 X90.834 Y76.347 E.00543
G1 X91.044 Y76.417 E.00435
G1 X91.27 Y76.543 E.00509
G1 X91.474 Y76.718 E.00528
G1 X91.61 Y76.89 E.00432
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.018 Y77.491 E.2713
G1 X77.844 Y77.519 E.00347
G1 X77.669 Y77.609 E.00386
G1 X77.534 Y77.748 E.00382
G1 X77.449 Y77.923 E.00383
G1 X77.425 Y78.086 E.00323
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.681 Y96.882 E.00448
G1 X90.529 Y96.891 E.00301
G1 X86.49 Y96.891 E.07943
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16877
G1 X87.167 Y97.767 E-.0416
G1 X87.401 Y98.159 E-.08667
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04136
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




G1 X86.028 Y97.645
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397726
G1 F1500
M204 S6000
G1 X85.906 Y97.532 E.00308
; LINE_WIDTH: 0.432792
G1 X85.784 Y97.419 E.00337
; LINE_WIDTH: 0.468094
G1 X85.661 Y97.304 E.00371
; LINE_WIDTH: 0.468469
G1 X85.5 Y97.34 E.00365
; LINE_WIDTH: 0.433651
G1 X85.338 Y97.375 E.00337
M204 S10000
G1 X86.028 Y97.645 F18000
; LINE_WIDTH: 0.360466
G1 F1500
M204 S6000
G1 X86.415 Y98.079 E.00971
G1 X86.7 Y98.532 E.00894
G1 X86.898 Y99.027 E.0089
G1 X86.962 Y99.27 E.00421
G1 X87.006 Y99.537 E.00451
G1 X87.027 Y100.05 E.00858
G1 X86.98 Y100.459 E.00688
G1 X86.844 Y100.946 E.00844
G1 X86.617 Y101.417 E.00873
G1 X86.309 Y101.851 E.00889
G1 X86.057 Y102.111 E.00605
G1 X85.766 Y102.348 E.00627
G1 X85.492 Y102.516 E.00536
G1 X85.164 Y102.679 E.00612
G1 X84.637 Y102.835 E.00919
G1 X84.29 Y102.886 E.00585
G1 X84.086 Y102.896 E.00341
G1 X83.768 Y102.882 E.00531
G1 X83.464 Y102.841 E.00513
G1 X83.253 Y102.792 E.00362
G1 X82.848 Y102.656 E.00713
G1 X82.397 Y102.409 E.0086
G1 X81.953 Y102.057 E.00945
G1 X81.648 Y101.716 E.00764
G1 X81.453 Y101.418 E.00594
G1 X81.293 Y101.111 E.00578
G1 X81.128 Y100.636 E.0084
G1 X81.039 Y100.016 E.01046
G1 X81.059 Y99.536 E.00802
G1 X81.126 Y99.186 E.00595
G1 X81.225 Y98.855 E.00578
G1 X81.421 Y98.432 E.00779
G1 X81.665 Y98.065 E.00736
G1 X82.029 Y97.664 E.00904
; LINE_WIDTH: 0.402168
G1 X82.203 Y97.487 E.00466
; LINE_WIDTH: 0.438169
G1 X82.4 Y97.318 E.00533
; LINE_WIDTH: 0.473057
G1 X82.57 Y97.174 E.00499
; WIPE_START
G1 X82.4 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.144852
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00157
G1 X77.06 Y95.968 E.00145
G1 X76.982 Y95.849 E.00085
G1 X76.882 Y95.627 E.00145
; WIPE_START
G1 X76.982 Y95.849 E-.1035
G1 X77.06 Y95.968 E-.06062
G1 X77.247 Y96.123 E-.10344
G1 X77.48 Y96.249 E-.11244
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.238 Y88.62 Z3.12 F18000
G1 X76.889 Y77.603 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.101285
G1 F1500
M204 S6000
G1 X76.946 Y77.423 E.00071
; LINE_WIDTH: 0.15312
G1 X76.998 Y77.32 E.00073
G1 X77.23 Y77.08 E.00212
; LINE_WIDTH: 0.128592
G1 X77.432 Y76.99 E.00113
; LINE_WIDTH: 0.0896313
G1 X77.536 Y76.955 E.00035
; WIPE_START
G1 X77.432 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.994 Y80.888 Z3.12 F18000
G1 X93.178 Y86.344 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/49
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-.958 J-.751 P1  F18000
G1 X85.252 Y97.113 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.802 Y96.951 E.01013
G1 X84.263 Y96.862 E.01156
G1 X83.708 Y96.87 E.01174
G1 X83.114 Y96.997 E.01285
G1 X82.8 Y97.124 E.00717
G1 X82.683 Y96.961 E.00425
G1 X83.046 Y96.544 E.01168
G1 X85.004 Y96.544 E.04146
G1 X85.363 Y96.949 E.01145
G1 X85.286 Y97.063 E.00291
; WIPE_START
M204 S6000
G1 X84.802 Y96.951 E-.09443
G1 X84.263 Y96.862 E-.10382
G1 X83.708 Y96.87 E-.10542
G1 X83.315 Y96.954 E-.07633
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.455 Y100.881 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.362 Y101.109 E.0052
G1 X86.109 Y101.505 E.00995
G1 X85.789 Y101.849 E.00995
G1 X85.42 Y102.126 E.00975
G1 X85.136 Y102.278 E.00683
G1 X84.836 Y102.396 E.00683
G1 X84.396 Y102.497 E.00956
G1 X84.074 Y102.521 E.00683
G1 X83.752 Y102.506 E.00683
G1 X83.3 Y102.417 E.00975
G1 X82.857 Y102.244 E.01007
G1 X82.396 Y101.947 E.01159
G1 X82.012 Y101.57 E.01139
G1 X81.75 Y101.185 E.00985
G1 X81.61 Y100.895 E.00683
G1 X81.506 Y100.589 E.00684
G1 X81.424 Y100.136 E.00975
G1 X81.424 Y99.666 E.00995
G1 X81.506 Y99.213 E.00975
G1 X81.61 Y98.907 E.00683
G1 X81.75 Y98.616 E.00683
G1 X82.004 Y98.243 E.00956
G1 X82.224 Y98.007 E.00683
G1 X82.47 Y97.798 E.00683
G1 X82.859 Y97.558 E.00968
G1 X83.239 Y97.404 E.00867
G1 X83.756 Y97.294 E.01119
G1 X84.231 Y97.286 E.01005
G1 X84.694 Y97.363 E.00995
G1 X85.134 Y97.521 E.00988
G1 X85.474 Y97.712 E.00826
G1 X85.679 Y97.86 E.00535
G1 X86.007 Y98.174 E.00961
G1 X86.239 Y98.487 E.00826
G1 X86.367 Y98.705 E.00535
G1 X86.542 Y99.133 E.0098
G1 X86.646 Y99.671 E.01159
G1 X86.639 Y100.209 E.01139
G1 X86.54 Y100.674 E.01005
G1 X86.478 Y100.826 E.00348
M204 S250
G1 X86.076 Y100.726 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.0041
G1 X85.784 Y101.253 E.0078
G1 X85.514 Y101.544 E.0078
M73 P70 R7
G1 X85.199 Y101.78 E.00774
G1 X84.964 Y101.906 E.00526
G1 X84.715 Y102.004 E.00526
G1 X84.335 Y102.091 E.00767
G1 X84.068 Y102.111 E.00526
G1 X83.801 Y102.099 E.00526
G1 X83.415 Y102.023 E.00774
G1 X83.044 Y101.878 E.00783
G1 X82.653 Y101.626 E.00914
G1 X82.328 Y101.306 E.00897
G1 X82.106 Y100.98 E.00777
G1 X81.99 Y100.739 E.00526
G1 X81.903 Y100.486 E.00527
G1 X81.833 Y100.099 E.00773
G1 X81.833 Y99.703 E.00779
G1 X81.903 Y99.316 E.00773
G1 X81.989 Y99.063 E.00526
G1 X82.106 Y98.822 E.00526
G1 X82.325 Y98.499 E.00767
G1 X82.507 Y98.303 E.00526
G1 X82.711 Y98.13 E.00526
G1 X83.045 Y97.924 E.00771
G1 X83.359 Y97.797 E.00667
G1 X83.802 Y97.702 E.0089
G1 X84.2 Y97.696 E.00783
G1 X84.591 Y97.761 E.0078
G1 X84.963 Y97.895 E.00777
G1 X85.253 Y98.058 E.00654
G1 X85.416 Y98.175 E.00396
G1 X85.699 Y98.445 E.00769
G1 X85.897 Y98.713 E.00654
G1 X85.999 Y98.887 E.00396
G1 X86.148 Y99.251 E.00775
G1 X86.236 Y99.707 E.00914
G1 X86.23 Y100.163 E.00897
G1 X86.147 Y100.553 E.00783
G1 X86.099 Y100.671 E.00251
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.05105
G1 X85.784 Y101.253 E-.07531
G1 X85.514 Y101.544 E-.07533
G1 X85.199 Y101.78 E-.07472
G1 X84.964 Y101.906 E-.05079
G1 X84.715 Y102.004 E-.05085
G1 X84.705 Y102.007 E-.00195
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.252 Y96.12 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12181
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.787 Y96.442 E.00324
G1 X90.517 Y96.482 E.00577
G1 X85.516 Y96.482 E.10585
G1 X86.653 Y97.766 E.03632
G1 X86.828 Y97.997 E.00612
G1 X87.036 Y98.347 E.00863
G1 X87.164 Y98.626 E.00648
G1 X87.262 Y98.898 E.00613
G1 X87.361 Y99.3 E.00875
G1 X87.415 Y99.899 E.01274
G1 X87.41 Y100.076 E.00373
G1 X87.34 Y100.595 E.0111
G1 X87.204 Y101.075 E.01055
G1 X86.954 Y101.606 E.01243
G1 X86.605 Y102.096 E.01273
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00868
G1 X85.678 Y102.855 E.00811
G1 X85.307 Y103.032 E.00869
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.579 Y102.951 E.01273
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.753 Y99.095 E.00869
G1 X80.87 Y98.717 E.00837
G1 X81.088 Y98.251 E.0109
G1 X81.361 Y97.834 E.01055
G1 X82.538 Y96.482 E.03794
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00343
G1 X76.824 Y96.119 E.00343
G1 X76.684 Y95.821 E.00696
G1 X76.654 Y95.565 E.00546
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.992 Y76.91 E.00598
G1 X77.234 Y76.775 E.00587
G1 X77.484 Y76.723 E.00539
G1 X90.536 Y76.721 E.27625
G1 X90.743 Y76.748 E.00442
G1 X90.883 Y76.794 E.00312
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.282 E.00668
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.452 E.00639
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.971 Y96.12 E.00767
G1 X85.192 Y96.12 E.15283
; WIPE_START
M204 S6000
G1 X87.192 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.425 Y96.891 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.971 Y97.507 E.01619
G1 X87.168 Y97.769 E.00644
G1 X87.399 Y98.157 E.00889
G1 X87.543 Y98.471 E.00679
G1 X87.655 Y98.779 E.00645
G1 X87.763 Y99.22 E.00893
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.108 E.00426
G1 X87.742 Y100.679 E.01132
G1 X87.59 Y101.213 E.01092
G1 X87.409 Y101.627 E.00888
G1 X87.304 Y101.818 E.0043
G1 X87.05 Y102.197 E.00897
G1 X86.912 Y102.368 E.0043
G1 X86.597 Y102.693 E.00892
G1 X86.246 Y102.979 E.00891
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.113 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.487 Y98.569 E.00881
G1 X80.73 Y98.051 E.01126
G1 X81.034 Y97.586 E.01093
G1 X81.639 Y96.891 E.01813
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.006
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.368 E.00448
G1 X76.42 Y96.248 E.00283
G1 X76.322 Y96.039 E.00454
G1 X76.282 Y95.904 E.00277
G1 X76.245 Y95.589 E.00625
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.598 Y76.715 E.00444
G1 X76.738 Y76.588 E.00372
G1 X76.889 Y76.485 E.0036
G1 X77.094 Y76.389 E.00445
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.562 Y76.312 E.2577
G1 X90.834 Y76.347 E.0054
G1 X91.045 Y76.417 E.00438
G1 X91.241 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.667 Y77.611 E.00361
G1 X77.525 Y77.761 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.31 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.681 Y96.882 E.00448
G1 X90.529 Y96.891 E.00301
G1 X86.485 Y96.891 E.07954
; WIPE_START
M204 S6000
G1 X86.971 Y97.507 E-.14908
G1 X87.168 Y97.769 E-.06225
G1 X87.399 Y98.157 E-.08591
G1 X87.543 Y98.471 E-.06556
G1 X87.574 Y98.556 E-.0172
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




G1 X85.942 Y97.563
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397966
G1 F1500
M204 S6000
G1 X85.924 Y97.545 E.00048
; LINE_WIDTH: 0.415452
G1 X85.82 Y97.45 E.00273
; LINE_WIDTH: 0.449338
G1 X85.697 Y97.34 E.00349
; LINE_WIDTH: 0.477669
G1 X85.475 Y97.161 E.00641
M204 S10000
G1 X85.942 Y97.563 F18000
; LINE_WIDTH: 0.361012
G1 F1500
M204 S6000
G1 X86.299 Y97.934 E.00861
G1 X86.55 Y98.271 E.00703
G1 X86.701 Y98.527 E.00498
G1 X86.9 Y99.01 E.00873
G1 X87.008 Y99.525 E.0088
G1 X87.026 Y100.05 E.00879
G1 X86.965 Y100.517 E.00787
G1 X86.843 Y100.945 E.00744
G1 X86.703 Y101.274 E.00597
G1 X86.413 Y101.731 E.00905
G1 X86.063 Y102.111 E.00865
G1 X85.774 Y102.34 E.00615
G1 X85.613 Y102.45 E.00327
G1 X85.304 Y102.616 E.00587
G1 X84.957 Y102.75 E.0062
G1 X84.463 Y102.865 E.00849
G1 X84.09 Y102.899 E.00628
G1 X83.694 Y102.88 E.00662
G1 X83.18 Y102.775 E.00879
G1 X82.743 Y102.607 E.00783
G1 X82.434 Y102.43 E.00595
G1 X82.141 Y102.228 E.00595
G1 X81.713 Y101.799 E.01013
G1 X81.429 Y101.385 E.0084
G1 X81.257 Y101.029 E.00662
G1 X81.138 Y100.672 E.00629
G1 X81.047 Y100.155 E.00878
G1 X81.047 Y99.647 E.0085
G1 X81.124 Y99.184 E.00785
G1 X81.226 Y98.855 E.00576
G1 X81.418 Y98.435 E.00772
G1 X81.702 Y98.018 E.00844
G1 X82.092 Y97.599 E.00958
; LINE_WIDTH: 0.40847
G1 X82.217 Y97.475 E.00336
; LINE_WIDTH: 0.441722
G1 X82.406 Y97.313 E.00517
; LINE_WIDTH: 0.474721
G1 X82.573 Y97.171 E.0049
; WIPE_START
G1 X82.406 Y97.313 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.148815
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00162
G1 X77.127 Y96.034 E.00092
G1 X77.044 Y95.951 E.00072
G1 X76.959 Y95.801 E.00106
; LINE_WIDTH: 0.123693
G1 X76.927 Y95.711 E.00046
; LINE_WIDTH: 0.0937137
G1 X76.896 Y95.622 E.00032
; WIPE_START
G1 X76.927 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.911 Y88.079 Z3.24 F18000
G1 X76.889 Y77.601 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.0996071
G1 F1500
M204 S6000
G1 X76.96 Y77.387 E.00083
; LINE_WIDTH: 0.154163
G1 X77.108 Y77.191 E.00158
G1 X77.23 Y77.079 E.00106
; LINE_WIDTH: 0.129311
G1 X77.427 Y76.991 E.00112
; LINE_WIDTH: 0.0897774
G1 X77.531 Y76.955 E.00035
; WIPE_START
G1 X77.427 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.99 Y80.888 Z3.24 F18000
G1 X93.178 Y86.344 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 24/49
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I-.958 J-.751 P1  F18000
G1 X85.254 Y97.115 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.786 Y96.949 E.01051
G1 X84.263 Y96.862 E.01123
G1 X83.716 Y96.87 E.01156
G1 X83.18 Y96.975 E.01157
G1 X82.796 Y97.126 E.00873
G1 X82.681 Y96.963 E.00423
G1 X83.045 Y96.544 E.01174
G1 X85.024 Y96.544 E.04187
G1 X85.377 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X84.786 Y96.949 E-.09831
G1 X84.263 Y96.862 E-.10082
G1 X83.716 Y96.87 E-.10381
G1 X83.318 Y96.948 E-.07706
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.449 Y100.909 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.357 Y101.117 E.0048
G1 X86.106 Y101.509 E.00986
G1 X85.732 Y101.899 E.01145
G1 X85.282 Y102.207 E.01154
G1 X84.845 Y102.394 E.01006
G1 X84.396 Y102.497 E.00975
G1 X84.074 Y102.521 E.00683
G1 X83.752 Y102.506 E.00683
G1 X83.3 Y102.417 E.00975
G1 X82.862 Y102.246 E.00995
G1 X82.462 Y101.999 E.00995
M73 P71 R7
G1 X82.109 Y101.68 E.01006
G1 X81.783 Y101.244 E.01153
G1 X81.553 Y100.748 E.01157
G1 X81.432 Y100.212 E.01164
G1 X81.423 Y99.671 E.01144
G1 X81.507 Y99.203 E.01006
G1 X81.669 Y98.772 E.00975
G1 X81.826 Y98.49 E.00683
G1 X82.011 Y98.237 E.00663
G1 X82.224 Y98.007 E.00664
G1 X82.47 Y97.798 E.00683
G1 X82.862 Y97.556 E.00975
G1 X83.3 Y97.384 E.00995
G1 X83.761 Y97.294 E.00995
G1 X84.231 Y97.286 E.00995
G1 X84.685 Y97.362 E.00975
G1 X84.992 Y97.462 E.00683
G1 X85.285 Y97.597 E.00683
G1 X85.669 Y97.851 E.00975
G1 X86.007 Y98.173 E.00987
G1 X86.238 Y98.484 E.0082
G1 X86.367 Y98.705 E.0054
G1 X86.54 Y99.128 E.00968
G1 X86.638 Y99.588 E.00995
G1 X86.652 Y100.058 E.00995
G1 X86.583 Y100.513 E.00975
G1 X86.488 Y100.822 E.00683
G1 X86.473 Y100.854 E.00076
M204 S250
G1 X86.075 Y100.743 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.995 Y100.922 E.00386
G1 X85.783 Y101.255 E.00777
G1 X85.465 Y101.586 E.00902
G1 X85.084 Y101.847 E.0091
G1 X84.718 Y102.004 E.00783
G1 X84.335 Y102.091 E.00774
G1 X84.068 Y102.111 E.00526
G1 X83.801 Y102.099 E.00526
G1 X83.415 Y102.023 E.00774
G1 X83.046 Y101.878 E.0078
G1 X82.709 Y101.67 E.0078
G1 X82.413 Y101.403 E.00783
G1 X82.136 Y101.033 E.00909
G1 X81.942 Y100.615 E.00905
G1 X81.84 Y100.163 E.00913
G1 X81.832 Y99.704 E.00901
G1 X81.904 Y99.313 E.00783
G1 X82.042 Y98.944 E.00774
G1 X82.172 Y98.711 E.00526
G1 X82.327 Y98.497 E.0052
G1 X82.507 Y98.303 E.0052
G1 X82.711 Y98.13 E.00526
G1 X83.046 Y97.924 E.00773
G1 X83.415 Y97.779 E.0078
G1 X83.804 Y97.702 E.0078
G1 X84.2 Y97.696 E.00779
G1 X84.588 Y97.761 E.00773
G1 X84.842 Y97.843 E.00526
G1 X85.085 Y97.956 E.00526
G1 X85.413 Y98.172 E.00774
G1 X85.699 Y98.445 E.00777
G1 X85.896 Y98.71 E.0065
G1 X85.999 Y98.886 E.00401
G1 X86.147 Y99.249 E.00771
G1 X86.23 Y99.637 E.0078
G1 X86.242 Y100.033 E.0078
G1 X86.183 Y100.422 E.00773
G1 X86.104 Y100.677 E.00526
G1 X86.1 Y100.688 E.00022
; WIPE_START
M204 S6000
G1 X85.995 Y100.922 E-.0487
G1 X85.783 Y101.255 E-.07501
G1 X85.465 Y101.586 E-.08709
G1 X85.084 Y101.847 E-.08788
G1 X84.718 Y102.004 E-.07563
G1 X84.689 Y102.01 E-.0057
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12136
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03825
G1 X86.825 Y97.992 E.00385
G1 X87.04 Y98.353 E.00889
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.076 E.01261
G1 X87.341 Y100.591 E.011
G1 X87.203 Y101.078 E.01071
G1 X86.95 Y101.611 E.01249
G1 X86.605 Y102.096 E.01261
G1 X86.318 Y102.393 E.00875
G1 X86.086 Y102.586 E.00638
G1 X85.678 Y102.855 E.01034
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00869
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.579 Y102.951 E.01273
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.941 Y101.261 E.00837
G1 X80.773 Y100.779 E.0108
G1 X80.677 Y100.285 E.01064
G1 X80.655 Y99.89 E.00838
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.87 Y98.717 E.00837
G1 X81.086 Y98.254 E.0108
G1 X81.361 Y97.834 E.01064
G1 X82.538 Y96.482 E.03793
G1 X77.571 Y96.482 E.10513
G1 X77.243 Y96.43 E.00703
G1 X77.104 Y96.365 E.00325
G1 X76.926 Y96.233 E.00469
G1 X76.776 Y96.045 E.00509
G1 X76.683 Y95.816 E.00524
G1 X76.654 Y95.565 E.00535
G1 X76.654 Y77.625 E.37972
G1 X76.693 Y77.349 E.00589
G1 X76.798 Y77.121 E.00532
G1 X76.991 Y76.911 E.00603
G1 X77.243 Y76.772 E.00609
G1 X77.493 Y76.723 E.0054
G1 X90.537 Y76.721 E.27609
G1 X90.742 Y76.748 E.00438
G1 X90.883 Y76.794 E.00313
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.283 E.00669
G1 X77.181 Y77.529 E.00717
G1 X77.052 Y77.807 E.00648
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00951
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15328
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.108 E.00427
G1 X87.743 Y100.675 E.01123
G1 X87.59 Y101.214 E.01103
G1 X87.457 Y101.526 E.00666
G1 X87.303 Y101.82 E.00654
G1 X87.05 Y102.197 E.00893
G1 X86.912 Y102.367 E.0043
G1 X86.596 Y102.694 E.00893
G1 X86.334 Y102.911 E.00669
G1 X86.06 Y103.104 E.00661
G1 X85.871 Y103.216 E.00432
G1 X85.459 Y103.413 E.00898
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.422 E.00881
G1 X80.377 Y100.886 E.01117
G1 X80.27 Y100.336 E.01101
G1 X80.245 Y99.889 E.00882
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.487 Y98.569 E.00881
G1 X80.727 Y98.055 E.01117
G1 X81.034 Y97.586 E.01102
G1 X81.639 Y96.891 E.01813
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X77.097 Y96.814 E.00277
G1 X76.893 Y96.719 E.00442
G1 X76.648 Y96.536 E.00601
G1 X76.499 Y96.368 E.00442
G1 X76.419 Y96.247 E.00286
G1 X76.337 Y96.078 E.00369
G1 X76.281 Y95.902 E.00363
G1 X76.245 Y95.589 E.00621
G1 X76.245 Y77.609 E.35364
G1 X76.26 Y77.413 E.00387
G1 X76.3 Y77.231 E.00366
G1 X76.367 Y77.055 E.00371
G1 X76.457 Y76.894 E.00363
G1 X76.598 Y76.715 E.00447
G1 X76.736 Y76.589 E.00369
G1 X76.889 Y76.485 E.00363
G1 X77.097 Y76.388 E.00451
G1 X77.234 Y76.347 E.00283
G1 X77.463 Y76.313 E.00454
G1 X90.563 Y76.312 E.25768
G1 X90.834 Y76.347 E.00537
G1 X91.045 Y76.417 E.00438
G1 X91.24 Y76.522 E.00435
M73 P71 R6
G1 X91.473 Y76.717 E.00598
G1 X91.632 Y76.926 E.00515
G1 X91.747 Y77.162 E.00516
G1 X91.804 Y77.375 E.00434
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00362
G1 X77.524 Y77.762 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16881
G1 X87.167 Y97.767 E-.04155
G1 X87.401 Y98.159 E-.08669
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04135
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




G1 X86.279 Y97.914
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.376864
G1 F1500
M204 S6000
G1 X85.931 Y97.549 E.00883
; LINE_WIDTH: 0.403562
G1 X85.904 Y97.523 E.00071
; LINE_WIDTH: 0.430158
G1 X85.694 Y97.343 E.00559
; LINE_WIDTH: 0.4761
G1 X85.484 Y97.163 E.00623
; WIPE_START
G1 X85.694 Y97.343 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.279 Y97.914 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.360248
G1 F1500
M204 S6000
G1 X86.414 Y98.079 E.00356
G1 X86.703 Y98.53 E.00894
G1 X86.901 Y99.013 E.00872
G1 X87.012 Y99.528 E.00878
G1 X87.031 Y100.051 E.00873
G1 X86.968 Y100.513 E.00779
G1 X86.846 Y100.948 E.00753
G1 X86.692 Y101.283 E.00616
G1 X86.391 Y101.753 E.00931
G1 X86.057 Y102.112 E.00818
G1 X85.855 Y102.28 E.00439
G1 X85.478 Y102.531 E.00755
G1 X85.007 Y102.739 E.0086
G1 X84.653 Y102.832 E.0061
G1 X84.292 Y102.888 E.00609
G1 X83.766 Y102.888 E.00878
G1 X83.404 Y102.83 E.00611
G1 X83.085 Y102.744 E.00552
G1 X82.68 Y102.576 E.00731
G1 X82.224 Y102.291 E.00897
G1 X81.88 Y101.986 E.00768
G1 X81.652 Y101.713 E.00593
G1 X81.448 Y101.421 E.00594
G1 X81.194 Y100.852 E.0104
G1 X81.059 Y100.273 E.00992
G1 X81.041 Y99.891 E.00638
G1 X81.059 Y99.536 E.00593
G1 X81.14 Y99.117 E.00712
G1 X81.325 Y98.626 E.00876
G1 X81.506 Y98.297 E.00626
G1 X81.713 Y98.005 E.00598
G1 X82.092 Y97.599 E.00926
; LINE_WIDTH: 0.408476
G1 X82.217 Y97.475 E.00337
; LINE_WIDTH: 0.441503
G1 X82.405 Y97.314 E.00513
; LINE_WIDTH: 0.474017
G1 X82.57 Y97.174 E.00486
; WIPE_START
G1 X82.405 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.472 Y96.256 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.15383
G1 F1500
M204 S6000
G1 X77.117 Y96.025 E.00271
G1 X77.043 Y95.954 E.00065
G1 X76.972 Y95.828 E.00092
; LINE_WIDTH: 0.126609
G1 X76.934 Y95.725 E.00055
; LINE_WIDTH: 0.0941053
G1 X76.896 Y95.622 E.00037
; WIPE_START
G1 X76.934 Y95.725 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.916 Y88.093 Z3.36 F18000
G1 X76.891 Y77.598 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.100254
G1 F1500
M204 S6000
G1 X76.944 Y77.423 E.00068
; LINE_WIDTH: 0.152782
G1 X76.983 Y77.346 E.00055
G1 X77.108 Y77.191 E.00126
G1 X77.23 Y77.079 E.00105
; LINE_WIDTH: 0.130136
G1 X77.432 Y76.988 E.00115
; LINE_WIDTH: 0.0926098
G1 X77.529 Y76.954 E.00034
; WIPE_START
G1 X77.432 Y76.988 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.993 Y80.887 Z3.36 F18000
G1 X93.178 Y86.344 Z3.36
M73 P72 R6
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/49
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I-.958 J-.751 P1  F18000
G1 X85.254 Y97.116 Z3.36
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.786 Y96.949 E.01052
G1 X84.263 Y96.862 E.01123
G1 X83.707 Y96.87 E.01176
G1 X83.108 Y96.999 E.01297
G1 X82.8 Y97.124 E.00704
G1 X82.683 Y96.961 E.00425
G1 X83.045 Y96.544 E.01167
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.01141
G1 X85.29 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X84.786 Y96.949 E-.09843
G1 X84.263 Y96.862 E-.10082
G1 X83.707 Y96.87 E-.10553
G1 X83.32 Y96.953 E-.07523
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.44 Y100.925 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.285 Y101.245 E.00753
G1 X86.011 Y101.623 E.00987
G1 X85.722 Y101.906 E.00858
G1 X85.282 Y102.207 E.01128
G1 X84.854 Y102.391 E.00986
G1 X84.541 Y102.472 E.00683
G1 X84.221 Y102.515 E.00683
G1 X83.761 Y102.508 E.00975
G1 X83.3 Y102.417 E.00995
G1 X82.871 Y102.249 E.00975
G1 X82.591 Y102.088 E.00683
G1 X82.34 Y101.9 E.00664
G1 X82.114 Y101.683 E.00663
G1 X81.909 Y101.434 E.00683
G1 X81.673 Y101.038 E.00975
G1 X81.507 Y100.598 E.00995
G1 X81.424 Y100.136 E.00995
G1 X81.424 Y99.675 E.00975
G1 X81.472 Y99.356 E.00683
G1 X81.559 Y99.04 E.00694
G1 X81.78 Y98.565 E.01108
G1 X82.007 Y98.241 E.00838
G1 X82.224 Y98.007 E.00675
G1 X82.47 Y97.798 E.00683
G1 X82.859 Y97.558 E.00967
G1 X83.234 Y97.406 E.00856
G1 X83.755 Y97.294 E.0113
G1 X84.231 Y97.286 E.01006
G1 X84.685 Y97.362 E.00975
G1 X84.992 Y97.462 E.00683
G1 X85.285 Y97.597 E.00683
G1 X85.669 Y97.851 E.00975
G1 X86.013 Y98.18 E.01007
G1 X86.324 Y98.624 E.01148
G1 X86.535 Y99.114 E.0113
G1 X86.613 Y99.433 E.00694
G1 X86.652 Y99.753 E.00683
G1 X86.638 Y100.204 E.00955
G1 X86.58 Y100.522 E.00683
G1 X86.485 Y100.831 E.00683
G1 X86.466 Y100.871 E.00095
M204 S250
G1 X86.071 Y100.748 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.933 Y101.035 E.00627
G1 X85.7 Y101.354 E.00777
G1 X85.461 Y101.589 E.00659
G1 X85.084 Y101.847 E.00898
G1 X84.721 Y102.002 E.00777
G1 X84.462 Y102.07 E.00526
G1 X84.197 Y102.106 E.00526
G1 X83.804 Y102.1 E.00773
G1 X83.415 Y102.023 E.0078
G1 X83.049 Y101.879 E.00773
G1 X82.817 Y101.746 E.00526
G1 X82.605 Y101.587 E.0052
G1 X82.414 Y101.404 E.0052
G1 X82.245 Y101.198 E.00526
G1 X82.043 Y100.86 E.00774
G1 X81.904 Y100.489 E.0078
G1 X81.833 Y100.099 E.0078
G1 X81.833 Y99.706 E.00773
G1 X81.873 Y99.441 E.00526
G1 X81.944 Y99.182 E.00529
G1 X82.136 Y98.771 E.00892
G1 X82.326 Y98.498 E.00653
G1 X82.507 Y98.303 E.00524
G1 X82.711 Y98.13 E.00526
G1 X83.045 Y97.924 E.00771
G1 X83.355 Y97.798 E.00658
G1 X83.802 Y97.702 E.009
G1 X84.2 Y97.696 E.00783
G1 X84.588 Y97.761 E.00773
G1 X84.842 Y97.843 E.00526
G1 X85.085 Y97.956 E.00526
G1 X85.413 Y98.172 E.00773
G1 X85.701 Y98.448 E.00784
G1 X85.965 Y98.824 E.00905
G1 X86.146 Y99.245 E.009
G1 X86.21 Y99.506 E.0053
G1 X86.242 Y99.772 E.00526
G1 X86.23 Y100.162 E.00767
G1 X86.182 Y100.425 E.00526
G1 X86.103 Y100.681 E.00526
G1 X86.097 Y100.693 E.00028
; WIPE_START
M204 S6000
G1 X85.933 Y101.035 E-.07196
G1 X85.7 Y101.354 E-.07509
G1 X85.461 Y101.589 E-.0637
G1 X85.084 Y101.847 E-.08677
G1 X84.721 Y102.002 E-.07504
G1 X84.683 Y102.012 E-.00744
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10531
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.992 E.00385
G1 X87.04 Y98.353 E.00888
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.076 E.01261
G1 X87.342 Y100.587 E.0109
G1 X87.203 Y101.078 E.01081
G1 X86.946 Y101.619 E.01268
G1 X86.599 Y102.103 E.0126
G1 X86.318 Y102.393 E.00856
G1 X86.089 Y102.583 E.00629
G1 X85.678 Y102.855 E.01044
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.327 Y103.269 E.00868
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.579 Y102.951 E.01272
G1 X82.227 Y102.757 E.0085
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.708 Y100.494 E.00838
G1 X80.659 Y99.991 E.01071
G1 X80.681 Y99.484 E.01074
G1 X80.754 Y99.086 E.00857
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03804
G1 X77.571 Y96.482 E.10512
G1 X77.32 Y96.452 E.00535
G1 X77.211 Y96.418 E.00243
G1 X77.014 Y96.31 E.00475
G1 X76.826 Y96.122 E.00562
G1 X76.731 Y95.957 E.00402
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.99 Y76.912 E.00592
G1 X77.238 Y76.774 E.00601
G1 X77.489 Y76.723 E.00543
G1 X90.539 Y76.721 E.27621
G1 X90.742 Y76.748 E.00434
G1 X90.878 Y76.793 E.00302
G1 X91.054 Y76.891 E.00427
G1 X91.004 Y77.082 E.00416
G1 X77.981 Y77.082 E.27565
G1 X77.692 Y77.133 E.00621
G1 X77.414 Y77.282 E.00668
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.779 E.00796
G1 X77.617 Y96.047 E.00951
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.1533
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.109 E.00427
G1 X87.744 Y100.67 E.01114
G1 X87.589 Y101.214 E.01113
G1 X87.459 Y101.521 E.00657
G1 X87.184 Y102.009 E.01101
G1 X86.91 Y102.37 E.00891
G1 X86.596 Y102.694 E.00887
G1 X86.338 Y102.908 E.0066
G1 X86.06 Y103.104 E.0067
G1 X85.871 Y103.216 E.00432
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.562 E.00882
G1 X80.248 Y100.002 E.01107
G1 X80.274 Y99.438 E.01111
G1 X80.355 Y98.994 E.00887
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.233 Y96.854 E.00621
G1 X77.059 Y96.799 E.00359
G1 X76.888 Y96.717 E.00372
G1 X76.623 Y96.512 E.00659
G1 X76.418 Y96.246 E.00661
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.893 E.00448
G1 X76.598 Y76.715 E.00445
G1 X76.735 Y76.59 E.00366
G1 X76.889 Y76.485 E.00367
G1 X77.095 Y76.389 E.00447
G1 X77.274 Y76.339 E.00365
G1 X77.462 Y76.313 E.00373
G1 X90.565 Y76.312 E.25773
G1 X90.834 Y76.347 E.00533
G1 X91.044 Y76.417 E.00435
G1 X91.274 Y76.546 E.00519
G1 X91.474 Y76.718 E.00518
G1 X91.61 Y76.89 E.00432
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16881
G1 X87.167 Y97.767 E-.04153
G1 X87.401 Y98.159 E-.08668
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04137
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




G1 X86.288 Y97.923
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.376388
G1 F1500
M204 S6000
G1 X85.931 Y97.549 E.00903
; LINE_WIDTH: 0.403707
G1 X85.904 Y97.523 E.00071
; LINE_WIDTH: 0.43025
G1 X85.694 Y97.343 E.00558
; LINE_WIDTH: 0.476079
G1 X85.484 Y97.163 E.00622
; WIPE_START
G1 X85.694 Y97.343 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.288 Y97.923 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.359506
G1 F1500
M204 S6000
G1 X86.413 Y98.08 E.00335
G1 X86.701 Y98.532 E.00891
G1 X86.9 Y99.014 E.00869
G1 X87.009 Y99.525 E.00869
G1 X87.027 Y100.051 E.00877
G1 X86.969 Y100.509 E.00769
G1 X86.846 Y100.948 E.00759
G1 X86.618 Y101.428 E.00885
G1 X86.309 Y101.857 E.0088
G1 X86.057 Y102.113 E.00598
G1 X85.858 Y102.277 E.0043
G1 X85.478 Y102.531 E.00761
G1 X85.006 Y102.739 E.00858
G1 X84.654 Y102.835 E.00609
G1 X84.256 Y102.892 E.00668
G1 X83.768 Y102.888 E.00813
G1 X83.242 Y102.794 E.00889
G1 X82.741 Y102.606 E.00892
G1 X82.431 Y102.435 E.00589
G1 X82.142 Y102.227 E.00593
G1 X81.843 Y101.948 E.00681
G1 X81.594 Y101.641 E.00659
G1 X81.327 Y101.189 E.00874
G1 X81.165 Y100.769 E.00749
G1 X81.087 Y100.431 E.00578
G1 X81.041 Y99.981 E.00753
G1 X81.061 Y99.527 E.00756
G1 X81.125 Y99.177 E.00594
G1 X81.301 Y98.681 E.00875
G1 X81.458 Y98.364 E.00589
G1 X81.706 Y98.012 E.00716
G1 X82.092 Y97.599 E.00942
; LINE_WIDTH: 0.408499
G1 X82.217 Y97.475 E.00337
; LINE_WIDTH: 0.44178
G1 X82.406 Y97.313 E.00517
; LINE_WIDTH: 0.474802
G1 X82.573 Y97.171 E.00491
; WIPE_START
G1 X82.406 Y97.313 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.454 Y96.253 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.150439
G1 F1500
M204 S6000
G1 X77.184 Y96.08 E.00199
G1 X77.061 Y95.968 E.00104
G1 X76.982 Y95.849 E.00089
G1 X76.882 Y95.627 E.00151
; WIPE_START
G1 X76.982 Y95.849 E-.10593
G1 X77.061 Y95.968 E-.06218
G1 X77.184 Y96.08 E-.07255
G1 X77.454 Y96.253 E-.13934
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.223 Y88.624 Z3.48 F18000
G1 X76.889 Y77.601 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.0995478
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00083
; LINE_WIDTH: 0.154137
G1 X77.108 Y77.19 E.00158
G1 X77.23 Y77.079 E.00106
; LINE_WIDTH: 0.129858
G1 X77.429 Y76.99 E.00114
; LINE_WIDTH: 0.0922727
G1 X77.53 Y76.953 E.00036
; WIPE_START
M73 P73 R6
G1 X77.429 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.992 Y80.887 Z3.48 F18000
G1 X93.178 Y86.344 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/49
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I-.959 J-.75 P1  F18000
G1 X85.273 Y97.12 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.802 Y96.951 E.01059
G1 X84.263 Y96.862 E.01156
G1 X83.716 Y96.87 E.01156
G1 X83.196 Y96.972 E.01123
G1 X82.803 Y97.113 E.00883
G1 X82.692 Y96.951 E.00416
G1 X83.046 Y96.544 E.0114
G1 X85.024 Y96.544 E.04187
G1 X85.383 Y96.958 E.0116
G1 X85.306 Y97.07 E.00289
; WIPE_START
M204 S6000
G1 X84.802 Y96.951 E-.09856
G1 X84.263 Y96.862 E-.10381
G1 X83.716 Y96.87 E-.10381
G1 X83.335 Y96.945 E-.07383
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.444 Y100.92 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.357 Y101.116 E.00455
G1 X86.109 Y101.505 E.00975
G1 X85.795 Y101.842 E.00975
G1 X85.543 Y102.044 E.00683
G1 X85.269 Y102.213 E.00683
G1 X84.845 Y102.394 E.00975
G1 X84.396 Y102.497 E.00975
G1 X84.074 Y102.521 E.00683
G1 X83.752 Y102.506 E.00683
G1 X83.3 Y102.417 E.00975
G1 X82.862 Y102.246 E.00995
G1 X82.462 Y101.999 E.00995
G1 X82.12 Y101.69 E.00975
G1 X81.915 Y101.441 E.00683
G1 X81.741 Y101.169 E.00683
G1 X81.554 Y100.748 E.00975
G1 X81.442 Y100.292 E.00995
G1 X81.415 Y99.832 E.00975
G1 X81.444 Y99.51 E.00683
G1 X81.511 Y99.195 E.00683
G1 X81.673 Y98.763 E.00975
G1 X81.916 Y98.355 E.01006
G1 X82.278 Y97.955 E.01143
G1 X82.711 Y97.638 E.01135
G1 X83.005 Y97.491 E.00695
G1 X83.309 Y97.382 E.00683
G1 X83.761 Y97.294 E.00975
G1 X84.231 Y97.286 E.00995
G1 X84.694 Y97.363 E.00995
G1 X85.133 Y97.521 E.00987
G1 X85.467 Y97.708 E.00809
G1 X85.678 Y97.86 E.00551
G1 X86.013 Y98.179 E.0098
G1 X86.323 Y98.621 E.01143
G1 X86.539 Y99.123 E.01155
G1 X86.638 Y99.588 E.01007
G1 X86.652 Y100.058 E.00995
G1 X86.583 Y100.513 E.00975
G1 X86.488 Y100.822 E.00683
G1 X86.469 Y100.865 E.00101
M204 S250
G1 X86.07 Y100.754 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.995 Y100.922 E.00363
G1 X85.784 Y101.253 E.00773
G1 X85.516 Y101.541 E.00773
G1 X85.307 Y101.708 E.00526
G1 X85.08 Y101.849 E.00526
G1 X84.718 Y102.004 E.00774
G1 X84.335 Y102.091 E.00774
G1 X84.068 Y102.111 E.00526
G1 X83.801 Y102.099 E.00526
G1 X83.415 Y102.023 E.00774
G1 X83.046 Y101.878 E.0078
G1 X82.709 Y101.67 E.0078
G1 X82.416 Y101.407 E.00773
G1 X82.247 Y101.2 E.00526
G1 X82.103 Y100.975 E.00526
G1 X81.943 Y100.615 E.00773
G1 X81.849 Y100.23 E.0078
G1 X81.825 Y99.838 E.00774
G1 X81.849 Y99.571 E.00526
G1 X81.905 Y99.31 E.00526
G1 X82.043 Y98.942 E.00773
G1 X82.247 Y98.6 E.00783
G1 X82.554 Y98.26 E.009
G1 X82.925 Y97.989 E.00905
G1 X83.166 Y97.868 E.0053
G1 X83.418 Y97.778 E.00526
G1 X83.804 Y97.702 E.00773
G1 X84.2 Y97.696 E.00779
G1 X84.591 Y97.761 E.0078
G1 X84.963 Y97.894 E.00777
G1 X85.247 Y98.054 E.0064
G1 X85.416 Y98.175 E.0041
G1 X85.701 Y98.447 E.00775
G1 X85.964 Y98.822 E.009
G1 X86.147 Y99.247 E.00911
G1 X86.23 Y99.637 E.00783
G1 X86.242 Y100.033 E.0078
G1 X86.183 Y100.422 E.00773
G1 X86.104 Y100.678 E.00526
G1 X86.095 Y100.699 E.00046
; WIPE_START
M204 S6000
G1 X85.995 Y100.922 E-.04642
G1 X85.784 Y101.253 E-.07471
G1 X85.516 Y101.541 E-.07467
G1 X85.307 Y101.708 E-.05083
G1 X85.08 Y101.849 E-.05082
G1 X84.718 Y102.004 E-.07473
G1 X84.678 Y102.013 E-.00782
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03825
G1 X86.825 Y97.992 E.00385
G1 X87.04 Y98.353 E.00889
G1 X87.267 Y98.91 E.01273
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.076 E.01242
G1 X87.343 Y100.582 E.01081
G1 X87.201 Y101.084 E.01103
G1 X86.951 Y101.609 E.0123
G1 X86.664 Y102.02 E.01062
G1 X86.313 Y102.397 E.0109
G1 X86.092 Y102.58 E.00607
G1 X85.678 Y102.855 E.01053
G1 X85.307 Y103.032 E.00869
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01273
G1 X82.579 Y102.951 E.01273
G1 X82.227 Y102.757 E.00849
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.941 Y101.261 E.00838
G1 X80.776 Y100.787 E.01061
G1 X80.677 Y100.285 E.01084
G1 X80.655 Y99.89 E.00837
G1 X80.68 Y99.49 E.00849
G1 X80.754 Y99.086 E.00869
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.239 Y96.429 E.0071
G1 X77.005 Y96.303 E.00562
G1 X76.845 Y96.145 E.00478
G1 X76.771 Y96.036 E.00278
G1 X76.683 Y95.812 E.00509
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.988 Y76.913 E.00589
G1 X77.238 Y76.774 E.00604
G1 X77.489 Y76.723 E.00543
G1 X90.54 Y76.721 E.27623
G1 X90.742 Y76.748 E.00431
G1 X90.878 Y76.793 E.00302
G1 X91.054 Y76.892 E.00428
G1 X91.004 Y77.082 E.00416
G1 X77.981 Y77.082 E.27565
G1 X77.692 Y77.133 E.00621
G1 X77.418 Y77.28 E.00659
G1 X77.193 Y77.513 E.00684
G1 X77.053 Y77.802 E.00681
G1 X77.016 Y78.056 E.00543
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.00639
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.971 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.4 Y98.159 E.00897
G1 X87.496 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00427
G1 X87.745 Y100.665 E.01105
G1 X87.589 Y101.216 E.01126
G1 X87.508 Y101.417 E.00426
G1 X87.303 Y101.819 E.00887
G1 X86.984 Y102.278 E.01099
G1 X86.595 Y102.695 E.01122
G1 X86.342 Y102.906 E.00647
G1 X85.871 Y103.216 E.0111
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.00431
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.422 E.00881
G1 X80.38 Y100.895 E.01098
G1 X80.27 Y100.336 E.0112
G1 X80.245 Y99.889 E.00881
G1 X80.273 Y99.44 E.00885
G1 X80.355 Y98.994 E.00891
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X76.921 Y96.734 E.00654
G1 X76.651 Y96.54 E.00654
G1 X76.523 Y96.399 E.00376
G1 X76.417 Y96.244 E.00368
G1 X76.352 Y96.114 E.00286
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.893 E.00448
G1 X76.598 Y76.715 E.00445
G1 X76.734 Y76.591 E.00362
G1 X76.889 Y76.485 E.0037
G1 X77.095 Y76.389 E.00447
G1 X77.272 Y76.339 E.00362
G1 X77.462 Y76.313 E.00376
G1 X90.567 Y76.312 E.25776
G1 X90.834 Y76.347 E.0053
G1 X91.044 Y76.417 E.00435
G1 X91.275 Y76.547 E.00523
G1 X91.471 Y76.715 E.00509
G1 X91.653 Y76.959 E.00597
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00377
G1 X77.668 Y77.611 E.00358
G1 X77.533 Y77.75 E.00382
G1 X77.448 Y77.924 E.00379
G1 X77.425 Y78.086 E.00322
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16882
G1 X87.167 Y97.767 E-.04153
G1 X87.4 Y98.159 E-.08669
G1 X87.496 Y98.356 E-.04162
G1 X87.572 Y98.56 E-.04135
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




G1 X85.943 Y97.561
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360289
G1 F1500
M204 S6000
G1 X86.308 Y97.947 E.00887
G1 X86.642 Y98.424 E.00972
G1 X86.906 Y99.03 E.01103
G1 X87.013 Y99.536 E.00863
G1 X87.031 Y100.046 E.00852
G1 X86.969 Y100.505 E.00773
G1 X86.843 Y100.956 E.00782
G1 X86.621 Y101.413 E.00849
G1 X86.397 Y101.746 E.0067
G1 X86.053 Y102.121 E.0085
G1 X85.768 Y102.345 E.00605
G1 X85.454 Y102.543 E.00619
G1 X84.947 Y102.757 E.00918
G1 X84.44 Y102.869 E.00868
G1 X84.089 Y102.895 E.00586
G1 X83.719 Y102.882 E.00618
G1 X83.243 Y102.794 E.00809
G1 X82.741 Y102.606 E.00895
G1 X82.433 Y102.432 E.0059
G1 X82.143 Y102.225 E.00594
G1 X81.838 Y101.942 E.00694
G1 X81.648 Y101.716 E.00494
G1 X81.45 Y101.42 E.00594
G1 X81.295 Y101.109 E.0058
G1 X81.145 Y100.687 E.00748
G1 X81.069 Y100.333 E.00604
G1 X81.037 Y99.838 E.00827
G1 X81.073 Y99.445 E.0066
G1 X81.168 Y99.023 E.00721
G1 X81.34 Y98.587 E.00783
G1 X81.623 Y98.118 E.00913
G1 X82.006 Y97.68 E.00972
; LINE_WIDTH: 0.393492
G1 X82.213 Y97.488 E.00517
; LINE_WIDTH: 0.43358
G1 X82.394 Y97.322 E.005
; LINE_WIDTH: 0.47101
G1 X82.575 Y97.156 E.00546
; WIPE_START
G1 X82.394 Y97.322 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.494 Y97.172 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.47091
G1 F1500
M204 S6000
G1 X85.817 Y97.445 E.0094
; LINE_WIDTH: 0.419487
G1 X85.924 Y97.543 E.00284
; LINE_WIDTH: 0.40062
G1 X85.943 Y97.561 E.00049
; WIPE_START
G1 X85.924 Y97.543 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.378 Y96.394 Z3.6 F18000
G1 X77.473 Y96.256 Z3.6
M73 P74 R6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.148567
G1 F1500
M204 S6000
G1 X77.252 Y96.126 E.00157
G1 X77.061 Y95.966 E.00153
G1 X76.982 Y95.848 E.00087
G1 X76.882 Y95.626 E.00149
; WIPE_START
G1 X76.982 Y95.848 E-.10365
G1 X77.061 Y95.966 E-.06069
G1 X77.252 Y96.126 E-.10615
G1 X77.473 Y96.256 E-.10951
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.234 Y88.628 Z3.6 F18000
G1 X76.889 Y77.603 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.0899601
G1 F1500
M204 S6000
G1 X76.928 Y77.486 E.0004
; LINE_WIDTH: 0.118027
G1 X76.968 Y77.369 E.00057
; LINE_WIDTH: 0.15463
G1 X77.108 Y77.19 E.00146
G1 X77.231 Y77.08 E.00106
; LINE_WIDTH: 0.130007
G1 X77.43 Y76.989 E.00114
; LINE_WIDTH: 0.0922671
G1 X77.53 Y76.953 E.00035
; WIPE_START
G1 X77.43 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.992 Y80.887 Z3.6 F18000
G1 X93.178 Y86.344 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/49
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-.954 J-.755 P1  F18000
G1 X85.195 Y97.078 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X84.615 Y96.908 E.01281
G1 X83.983 Y96.853 E.01343
G1 X83.364 Y96.927 E.01318
G1 X82.8 Y97.11 E.01255
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X84.957 Y96.544 E.04045
G1 X85.297 Y96.913 E.01063
G1 X85.227 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X84.615 Y96.908 E-.11851
G1 X83.983 Y96.853 E-.12055
G1 X83.364 Y96.927 E-.1183
G1 X83.251 Y96.964 E-.02264
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.431 Y100.941 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.247 Y101.307 E.00866
G1 X85.907 Y101.737 E.01161
G1 X85.54 Y102.048 E.01018
G1 X85.071 Y102.309 E.01137
G1 X84.547 Y102.473 E.01161
G1 X84.083 Y102.521 E.00987
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00684
G1 X83.004 Y102.312 E.00975
G1 X82.591 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00975
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.455 Y97.809 E.00956
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.456 Y97.343 E.00985
G1 X83.99 Y97.28 E.01137
G1 X84.536 Y97.327 E.01161
G1 X84.984 Y97.458 E.00987
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.195 Y98.417 E.00975
G1 X86.36 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.488 Y100.827 E.01005
G1 X86.457 Y100.888 E.00144
M204 S250
G1 X86.065 Y100.758 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.9 Y101.086 E.00722
G1 X85.611 Y101.451 E.00916
G1 X85.306 Y101.71 E.00787
G1 X84.908 Y101.931 E.00895
G1 X84.464 Y102.07 E.00916
G1 X84.071 Y102.111 E.00777
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.00779
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.863 E.00774
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.00779
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.706 Y98.134 E.00767
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00776
G1 X83.996 Y97.691 E.00895
G1 X84.46 Y97.731 E.00916
G1 X84.84 Y97.842 E.00777
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.859 Y98.653 E.00773
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00773
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.104 Y100.679 E.00783
G1 X86.092 Y100.704 E.00055
; WIPE_START
M204 S6000
G1 X85.9 Y101.086 E-.08112
G1 X85.611 Y101.451 E-.08847
G1 X85.306 Y101.71 E-.076
G1 X84.908 Y101.931 E-.08646
G1 X84.668 Y102.006 E-.04795
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.2 Y96.12 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12292
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.476 Y96.482 E.10649
G1 X86.579 Y97.675 E.03439
G1 X86.829 Y98 E.00868
G1 X87.119 Y98.517 E.01254
G1 X87.263 Y98.901 E.00868
G1 X87.361 Y99.3 E.00869
G1 X87.415 Y99.893 E.01261
G1 X87.363 Y100.49 E.01267
G1 X87.206 Y101.071 E.01273
G1 X86.952 Y101.606 E.01255
G1 X86.667 Y102.017 E.01058
G1 X86.315 Y102.395 E.01093
G1 X86.001 Y102.65 E.00857
G1 X85.678 Y102.855 E.00811
G1 X85.307 Y103.032 E.00868
G1 X84.919 Y103.164 E.00869
G1 X84.327 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01274
G1 X82.579 Y102.951 E.01272
G1 X82.227 Y102.757 E.0085
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.708 Y100.494 E.00839
G1 X80.659 Y100 E.01051
G1 X80.681 Y99.484 E.01093
G1 X80.753 Y99.095 E.00837
G1 X80.871 Y98.712 E.00849
G1 X81.038 Y98.337 E.00869
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.32 Y96.452 E.00536
G1 X77.213 Y96.419 E.00236
G1 X77.106 Y96.367 E.0025
G1 X76.923 Y96.231 E.00484
G1 X76.771 Y96.036 E.00524
G1 X76.683 Y95.812 E.00509
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.624 E.37973
G1 X76.692 Y77.352 E.00581
G1 X76.75 Y77.207 E.00331
G1 X76.83 Y77.076 E.00324
G1 X77.002 Y76.901 E.0052
G1 X77.226 Y76.778 E.0054
G1 X77.484 Y76.723 E.00559
G1 X90.542 Y76.721 E.27639
G1 X90.742 Y76.748 E.00427
G1 X90.883 Y76.794 E.00314
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00795
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.14 Y96.12 E.15173
; WIPE_START
M204 S6000
G1 X87.14 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.411 Y96.891 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01393
G1 X87.168 Y97.77 E.00891
G1 X87.401 Y98.159 E.00891
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.824 Y99.89 E.00893
G1 X87.81 Y100.216 E.00642
G1 X87.767 Y100.561 E.00684
G1 X87.694 Y100.88 E.00644
G1 X87.591 Y101.212 E.00684
G1 X87.463 Y101.513 E.00644
G1 X87.303 Y101.819 E.00678
G1 X86.987 Y102.274 E.01091
G1 X86.595 Y102.694 E.01129
G1 X86.245 Y102.979 E.00887
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00437
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.034 Y103.556 E.00437
G1 X82.822 Y103.491 E.00436
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.562 E.00882
G1 X80.249 Y100.011 E.01089
G1 X80.274 Y99.438 E.01129
G1 X80.354 Y98.997 E.00881
G1 X80.488 Y98.567 E.00885
G1 X80.672 Y98.153 E.00891
G1 X80.778 Y97.962 E.0043
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.233 Y96.854 E.00622
G1 X77.062 Y96.8 E.00353
G1 X76.894 Y96.719 E.00367
G1 X76.647 Y96.536 E.00605
G1 X76.522 Y96.398 E.00367
G1 X76.417 Y96.244 E.00365
G1 X76.352 Y96.114 E.00286
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.609 E.35365
G1 X76.259 Y77.418 E.00377
G1 X76.299 Y77.232 E.00373
G1 X76.383 Y77.022 E.00444
G1 X76.501 Y76.831 E.00442
G1 X76.652 Y76.661 E.00448
G1 X76.762 Y76.568 E.00283
G1 X76.959 Y76.447 E.00454
G1 X77.091 Y76.39 E.00283
G1 X77.314 Y76.33 E.00454
G1 X77.46 Y76.313 E.00289
G1 X90.568 Y76.312 E.25784
G1 X90.834 Y76.347 E.00526
G1 X91.045 Y76.417 E.00439
G1 X91.24 Y76.522 E.00436
G1 X91.473 Y76.718 E.00597
G1 X91.629 Y76.922 E.00506
G1 X91.747 Y77.162 E.00526
G1 X91.804 Y77.375 E.00433
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00362
G1 X77.525 Y77.762 E.00407
G1 X77.448 Y77.925 E.00356
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.471 Y96.891 E.07974
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12706
G1 X87.168 Y97.77 E-.08607
G1 X87.401 Y98.159 E-.08609
G1 X87.495 Y98.356 E-.0416
G1 X87.568 Y98.549 E-.03918
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




G1 X86.162 Y97.784
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.375748
G1 F1500
M204 S6000
G1 X85.983 Y97.612 E.00434
; LINE_WIDTH: 0.408414
G1 X85.777 Y97.416 E.00543
; LINE_WIDTH: 0.445749
G1 X85.596 Y97.272 E.00486
; LINE_WIDTH: 0.479732
G1 X85.415 Y97.127 E.00525
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.360568
G1 F1500
M204 S6000
G1 X86.512 Y98.209 E.00919
G1 X86.702 Y98.528 E.0062
G1 X86.896 Y99.015 E.00876
G1 X86.985 Y99.38 E.00628
G1 X87.036 Y99.897 E.00867
G1 X86.99 Y100.424 E.00884
G1 X86.85 Y100.94 E.00892
G1 X86.744 Y101.174 E.00429
G1 X86.554 Y101.523 E.00663
G1 X86.186 Y101.985 E.00988
G1 X85.777 Y102.344 E.00909
G1 X85.493 Y102.515 E.00553
G1 X85.164 Y102.679 E.00614
G1 X84.638 Y102.835 E.00916
G1 X84.29 Y102.886 E.00588
G1 X83.768 Y102.888 E.00872
G1 X83.243 Y102.791 E.00892
G1 X82.844 Y102.651 E.00707
G1 X82.431 Y102.435 E.00778
G1 X82.144 Y102.224 E.00594
G1 X81.881 Y101.985 E.00594
G1 X81.6 Y101.652 E.00728
G1 X81.346 Y101.226 E.00828
G1 X81.195 Y100.86 E.00661
G1 X81.097 Y100.498 E.00628
G1 X81.037 Y99.989 E.00855
G1 X81.06 Y99.527 E.00774
G1 X81.126 Y99.186 E.00579
G1 X81.228 Y98.848 E.0059
M73 P75 R6
G1 X81.455 Y98.373 E.00879
G1 X81.66 Y98.071 E.00611
G1 X82.025 Y97.669 E.00907
; LINE_WIDTH: 0.401008
G1 X82.195 Y97.496 E.00453
; LINE_WIDTH: 0.438408
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477117
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.439 Y96.25 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.146924
G1 F1500
M204 S6000
G1 X77.115 Y96.023 E.00239
G1 X77.061 Y95.967 E.00047
G1 X76.982 Y95.849 E.00086
G1 X76.882 Y95.627 E.00147
; WIPE_START
G1 X76.982 Y95.849 E-.10766
G1 X77.061 Y95.967 E-.06298
G1 X77.115 Y96.023 E-.03445
G1 X77.439 Y96.25 E-.17491
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.215 Y88.62 Z3.72 F18000
G1 X76.891 Y77.598 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.099716
G1 F1500
M204 S6000
G1 X76.942 Y77.427 E.00066
; LINE_WIDTH: 0.150159
G1 X76.993 Y77.332 E.00067
G1 X77.136 Y77.162 E.00138
G1 X77.244 Y77.074 E.00086
; LINE_WIDTH: 0.128536
G1 X77.408 Y76.997 E.00093
; LINE_WIDTH: 0.0961999
G1 X77.499 Y76.963 E.00034
; LINE_WIDTH: 0.0812155
G1 X77.531 Y76.955 E.00009
; WIPE_START
G1 X77.499 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.049 Y80.882 Z3.72 F18000
G1 X93.178 Y86.344 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/49
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I-.958 J-.751 P1  F18000
G1 X85.254 Y97.115 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.614 Y96.908 E.01144
G1 X83.98 Y96.853 E.01348
G1 X83.364 Y96.927 E.01312
G1 X82.8 Y97.11 E.01255
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02984
G1 X84.614 Y96.908 E-.10271
G1 X83.98 Y96.853 E-.12104
G1 X83.364 Y96.927 E-.11779
G1 X83.321 Y96.941 E-.00862
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.439 Y100.931 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.108 E.0041
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00975
G1 X85.54 Y102.048 E.01005
G1 X85.073 Y102.308 E.01132
G1 X84.547 Y102.473 E.01166
G1 X84.069 Y102.523 E.01018
G1 X83.537 Y102.475 E.01132
G1 X83.01 Y102.314 E.01166
G1 X82.59 Y102.089 E.01008
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00994
G1 X81.673 Y101.039 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.414 Y99.965 E.00693
G1 X81.454 Y99.441 E.01112
G1 X81.606 Y98.912 E.01167
G1 X81.825 Y98.489 E.01007
G1 X82.117 Y98.113 E.01007
G1 X82.533 Y97.752 E.01166
G1 X83 Y97.492 E.01132
G1 X83.456 Y97.343 E.01015
G1 X83.987 Y97.28 E.01132
G1 X84.536 Y97.327 E.01166
G1 X84.984 Y97.458 E.00988
G1 X85.276 Y97.593 E.00682
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.195 Y98.417 E.00975
G1 X86.361 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.492 Y100.813 E.00975
G1 X86.464 Y100.876 E.00146
M204 S250
G1 X86.066 Y100.764 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00333
G1 X85.86 Y101.149 E.00526
G1 X85.61 Y101.452 E.00774
G1 X85.306 Y101.71 E.00783
G1 X84.911 Y101.93 E.0089
G1 X84.464 Y102.07 E.00921
G1 X84.066 Y102.112 E.00787
G1 X83.615 Y102.071 E.0089
G1 X83.168 Y101.935 E.00921
G1 X82.817 Y101.746 E.00784
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00779
G1 X82.043 Y100.86 E.0078
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.962 E.00529
G1 X81.859 Y99.514 E.00884
G1 X81.988 Y99.064 E.00921
G1 X82.172 Y98.711 E.00783
G1 X82.415 Y98.396 E.00784
G1 X82.769 Y98.089 E.00921
G1 X83.164 Y97.868 E.0089
G1 X83.544 Y97.745 E.00786
G1 X83.994 Y97.691 E.00891
G1 X84.46 Y97.731 E.00921
G1 X84.839 Y97.842 E.00777
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.86 Y98.653 E.00774
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00773
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.105 Y100.675 E.00774
G1 X86.09 Y100.71 E.00075
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.04356
G1 X85.86 Y101.149 E-.05082
G1 X85.61 Y101.452 E-.07474
G1 X85.306 Y101.71 E-.07561
G1 X84.911 Y101.93 E-.086
G1 X84.663 Y102.008 E-.04928
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03825
G1 X86.825 Y97.992 E.00385
G1 X87.04 Y98.353 E.00889
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.41 Y100.076 E.01262
G1 X87.345 Y100.574 E.01062
G1 X87.202 Y101.079 E.01111
G1 X86.948 Y101.614 E.01255
G1 X86.601 Y102.101 E.01265
G1 X86.32 Y102.391 E.00855
G1 X86.001 Y102.65 E.00868
G1 X85.678 Y102.855 E.00811
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00869
G1 X83.734 Y103.267 E.01254
G1 X83.156 Y103.165 E.01243
G1 X82.683 Y102.996 E.01061
G1 X82.222 Y102.753 E.01103
G1 X81.902 Y102.522 E.00837
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.753 Y99.095 E.00869
G1 X80.87 Y98.716 E.00839
G1 X81.077 Y98.27 E.01042
G1 X81.362 Y97.833 E.01103
G1 X82.538 Y96.482 E.03792
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.13 Y96.38 E.00457
G1 X77.027 Y96.318 E.00254
G1 X76.843 Y96.142 E.00539
G1 X76.774 Y96.041 E.00259
G1 X76.683 Y95.816 E.00513
G1 X76.654 Y95.565 E.00536
G1 X76.654 Y77.624 E.37973
G1 X76.693 Y77.348 E.0059
G1 X76.799 Y77.121 E.00531
G1 X76.986 Y76.914 E.00589
G1 X77.234 Y76.775 E.00602
G1 X77.484 Y76.723 E.00539
G1 X90.543 Y76.722 E.27642
G1 X90.742 Y76.748 E.00423
G1 X90.877 Y76.793 E.00302
G1 X91.053 Y76.892 E.00428
G1 X91.003 Y77.082 E.00416
G1 X77.981 Y77.082 E.27564
G1 X77.692 Y77.133 E.0062
G1 X77.414 Y77.282 E.00668
G1 X77.181 Y77.529 E.00718
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00532
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00795
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.401 Y98.159 E.00897
G1 X87.495 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
M73 P75 R5
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.109 E.00427
G1 X87.746 Y100.656 E.01086
G1 X87.589 Y101.215 E.01141
G1 X87.465 Y101.509 E.00628
G1 X87.302 Y101.821 E.00693
G1 X87.125 Y102.091 E.00634
G1 X86.91 Y102.369 E.00691
G1 X86.597 Y102.693 E.00887
G1 X86.246 Y102.979 E.00891
G1 X86.061 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.038 Y103.557 E.00427
G1 X82.518 Y103.372 E.01086
G1 X82.006 Y103.102 E.01138
G1 X81.643 Y102.84 E.00881
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.113 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.487 Y98.569 E.00882
G1 X80.718 Y98.071 E.0108
G1 X81.034 Y97.586 E.01138
G1 X81.639 Y96.891 E.01812
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.953 Y96.751 E.00597
G1 X76.791 Y96.654 E.0037
G1 X76.65 Y96.539 E.00358
G1 X76.521 Y96.396 E.00379
G1 X76.418 Y96.246 E.00358
G1 X76.335 Y96.072 E.00379
G1 X76.281 Y95.903 E.00349
G1 X76.245 Y95.589 E.00622
G1 X76.245 Y77.609 E.35365
G1 X76.259 Y77.419 E.00374
G1 X76.3 Y77.231 E.00379
G1 X76.364 Y77.061 E.00358
G1 X76.457 Y76.893 E.00377
G1 X76.598 Y76.715 E.00447
G1 X76.731 Y76.593 E.00356
G1 X76.889 Y76.485 E.00377
G1 X77.094 Y76.389 E.00444
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.57 Y76.312 E.25787
G1 X90.834 Y76.347 E.00523
G1 X91.044 Y76.417 E.00435
G1 X91.278 Y76.548 E.00529
G1 X91.473 Y76.717 E.00508
G1 X91.61 Y76.89 E.00433
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.524 Y77.762 E.00407
G1 X77.448 Y77.926 E.00356
G1 X77.425 Y78.086 E.00318
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16881
G1 X87.167 Y97.767 E-.04153
G1 X87.401 Y98.159 E-.08669
G1 X87.495 Y98.356 E-.0416
G1 X87.572 Y98.56 E-.04136
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




G1 X86.162 Y97.784
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378816
G1 F1500
M204 S6000
G1 X85.985 Y97.609 E.00438
; LINE_WIDTH: 0.41932
G1 X85.783 Y97.411 E.00557
; LINE_WIDTH: 0.468133
G1 X85.484 Y97.162 E.00858
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.359418
G1 F1500
M204 S6000
G1 X86.414 Y98.079 E.00646
G1 X86.703 Y98.53 E.00892
G1 X86.848 Y98.874 E.00621
G1 X86.988 Y99.369 E.00856
G1 X87.036 Y99.908 E.00901
G1 X86.986 Y100.422 E.00859
G1 X86.845 Y100.95 E.0091
G1 X86.697 Y101.272 E.0059
G1 X86.494 Y101.61 E.00657
G1 X86.181 Y101.994 E.00825
G1 X85.777 Y102.344 E.00889
M73 P76 R5
G1 X85.496 Y102.514 E.00548
G1 X85.205 Y102.658 E.00539
G1 X84.64 Y102.84 E.00989
G1 X84.088 Y102.896 E.00924
G1 X83.768 Y102.882 E.00532
; LINE_WIDTH: 0.361219
G1 X83.481 Y102.844 E.00484
G1 X83.261 Y102.793 E.00379
G1 X82.85 Y102.656 E.00725
G1 X82.423 Y102.43 E.00809
G1 X82.144 Y102.224 E.00579
G1 X81.881 Y101.985 E.00595
G1 X81.6 Y101.652 E.00729
G1 X81.327 Y101.189 E.009
G1 X81.165 Y100.769 E.00753
G1 X81.072 Y100.358 E.00706
G1 X81.039 Y99.981 E.00632
G1 X81.061 Y99.546 E.0073
G1 X81.127 Y99.187 E.00611
G1 X81.251 Y98.787 E.007
G1 X81.503 Y98.301 E.00917
G1 X81.832 Y97.866 E.00912
G1 X82.064 Y97.632 E.00553
; LINE_WIDTH: 0.418024
G1 X82.275 Y97.421 E.00582
; LINE_WIDTH: 0.444197
G1 X82.307 Y97.393 E.0009
; LINE_WIDTH: 0.470518
G1 X82.584 Y97.168 E.00791
; WIPE_START
G1 X82.307 Y97.393 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.148867
G1 F1500
M204 S6000
G1 X77.254 Y96.127 E.00158
G1 X77.127 Y96.035 E.00096
G1 X77.044 Y95.951 E.00072
G1 X76.97 Y95.825 E.0009
; LINE_WIDTH: 0.126454
G1 X76.933 Y95.723 E.00054
; LINE_WIDTH: 0.0941226
G1 X76.896 Y95.622 E.00037
; WIPE_START
G1 X76.933 Y95.723 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.915 Y88.091 Z3.84 F18000
G1 X76.891 Y77.598 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.100322
G1 F1500
M204 S6000
G1 X76.944 Y77.421 E.00069
; LINE_WIDTH: 0.152725
G1 X77.108 Y77.19 E.00179
G1 X77.231 Y77.079 E.00105
; LINE_WIDTH: 0.129244
G1 X77.427 Y76.991 E.00111
; LINE_WIDTH: 0.0897812
G1 X77.531 Y76.955 E.00035
; WIPE_START
G1 X77.427 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.99 Y80.888 Z3.84 F18000
G1 X93.178 Y86.344 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 29/49
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I-.958 J-.751 P1  F18000
G1 X85.254 Y97.115 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.06 E.00282
G1 X84.614 Y96.908 E.01145
G1 X83.977 Y96.853 E.01354
G1 X83.364 Y96.927 E.01306
G1 X82.8 Y97.11 E.01254
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.06 E-.02982
G1 X84.614 Y96.908 E-.10277
G1 X83.977 Y96.853 E-.12157
G1 X83.364 Y96.927 E-.11728
G1 X83.321 Y96.941 E-.00855
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y100.946 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.289 Y101.237 E.00685
G1 X86.108 Y101.504 E.00683
G1 X85.895 Y101.747 E.00683
G1 X85.54 Y102.048 E.00985
G1 X85.076 Y102.307 E.01126
G1 X84.548 Y102.473 E.01171
G1 X84.069 Y102.523 E.01018
G1 X83.539 Y102.475 E.01126
G1 X83.01 Y102.315 E.01172
G1 X82.591 Y102.089 E.01008
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.038 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.51 E.00975
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00976
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.455 Y97.809 E.00955
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.456 Y97.344 E.00984
G1 X83.984 Y97.28 E.01127
G1 X84.536 Y97.327 E.01172
G1 X84.984 Y97.458 E.00988
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.201 Y98.424 E.00995
G1 X86.43 Y98.835 E.00995
G1 X86.579 Y99.27 E.00975
G1 X86.636 Y99.588 E.00683
G1 X86.656 Y99.91 E.00683
G1 X86.614 Y100.369 E.00975
G1 X86.489 Y100.822 E.00995
G1 X86.456 Y100.891 E.00163
M204 S250
G1 X86.061 Y100.768 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.934 Y101.032 E.00576
G1 X85.783 Y101.253 E.00526
G1 X85.607 Y101.455 E.00526
G1 X85.306 Y101.71 E.00777
G1 X84.913 Y101.929 E.00885
G1 X84.464 Y102.07 E.00925
G1 X84.066 Y102.112 E.00787
G1 X83.618 Y102.071 E.00885
G1 X83.168 Y101.935 E.00926
G1 X82.817 Y101.746 E.00783
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.86 E.0078
G1 X81.905 Y100.492 E.00773
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00773
G1 X81.943 Y99.186 E.00779
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.706 Y98.134 E.00767
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00776
G1 X83.991 Y97.691 E.00886
G1 X84.46 Y97.731 E.00926
G1 X84.84 Y97.842 E.00778
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.862 Y98.656 E.0078
G1 X86.054 Y99.002 E.00779
G1 X86.182 Y99.374 E.00773
G1 X86.229 Y99.637 E.00526
G1 X86.245 Y99.904 E.00526
G1 X86.21 Y100.296 E.00773
G1 X86.105 Y100.678 E.0078
G1 X86.087 Y100.714 E.00079
; WIPE_START
M204 S6000
G1 X85.934 Y101.032 E-.06708
G1 X85.783 Y101.253 E-.05085
G1 X85.607 Y101.455 E-.05082
G1 X85.306 Y101.71 E-.07502
G1 X84.913 Y101.929 E-.08551
G1 X84.658 Y102.009 E-.05072
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03825
G1 X86.825 Y97.992 E.00386
G1 X87.04 Y98.353 E.00888
G1 X87.263 Y98.901 E.01254
G1 X87.389 Y99.48 E.01254
G1 X87.415 Y99.894 E.00877
G1 X87.363 Y100.49 E.01268
G1 X87.206 Y101.071 E.01273
G1 X86.946 Y101.619 E.01285
G1 X86.599 Y102.103 E.01259
G1 X86.317 Y102.394 E.00858
G1 X86.103 Y102.572 E.0059
G1 X85.678 Y102.855 E.01081
G1 X85.307 Y103.032 E.00869
G1 X84.918 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.155 Y103.165 E.01244
G1 X82.687 Y102.998 E.01051
G1 X82.222 Y102.753 E.01113
G1 X81.902 Y102.522 E.00836
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.941 Y101.26 E.00839
G1 X80.779 Y100.8 E.01032
G1 X80.677 Y100.284 E.01113
G1 X80.655 Y99.89 E.00836
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.87 Y98.716 E.00839
G1 X81.075 Y98.274 E.01032
G1 X81.362 Y97.833 E.01113
G1 X82.538 Y96.482 E.03791
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00343
G1 X76.824 Y96.119 E.00343
G1 X76.731 Y95.957 E.00394
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.896 Y76.998 E.00324
G1 X77.01 Y76.896 E.00324
G1 X77.23 Y76.776 E.0053
G1 X77.49 Y76.723 E.00562
G1 X90.545 Y76.722 E.27632
G1 X90.742 Y76.748 E.0042
G1 X90.883 Y76.794 E.00314
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.133 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.971 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.4 Y98.159 E.00897
G1 X87.496 Y98.356 E.00431
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.824 Y99.89 E.00893
G1 X87.811 Y100.206 E.00623
G1 X87.767 Y100.561 E.00702
G1 X87.697 Y100.871 E.00625
G1 X87.59 Y101.212 E.00703
G1 X87.467 Y101.505 E.00625
G1 X87.184 Y102.009 E.01137
G1 X86.91 Y102.37 E.00891
G1 X86.596 Y102.694 E.00888
G1 X86.353 Y102.897 E.00623
G1 X86.06 Y103.104 E.00706
G1 X85.871 Y103.216 E.00432
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00892
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.038 Y103.557 E.00428
G1 X82.523 Y103.374 E.01077
G1 X82.006 Y103.102 E.01148
G1 X81.643 Y102.84 E.00881
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.422 E.00882
G1 X80.383 Y100.908 E.01071
G1 X80.27 Y100.336 E.01147
G1 X80.245 Y99.889 E.00881
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.487 Y98.569 E.00882
G1 X80.716 Y98.075 E.01071
G1 X81.035 Y97.586 E.01148
G1 X81.639 Y96.891 E.01812
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.006
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.368 E.00448
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.597 Y76.716 E.00442
G1 X76.765 Y76.567 E.00442
G1 X76.959 Y76.447 E.00448
G1 X77.092 Y76.39 E.00286
G1 X77.268 Y76.34 E.00358
G1 X77.462 Y76.313 E.00386
G1 X90.572 Y76.312 E.25786
G1 X90.834 Y76.347 E.00519
G1 X91.045 Y76.417 E.00439
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
M73 P77 R5
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.304 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16881
G1 X87.167 Y97.767 E-.04156
G1 X87.4 Y98.159 E-.08666
G1 X87.496 Y98.356 E-.04162
G1 X87.572 Y98.56 E-.04136
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




G1 X86.162 Y97.784
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378814
G1 F1500
M204 S6000
G1 X85.985 Y97.609 E.00438
; LINE_WIDTH: 0.41929
G1 X85.783 Y97.411 E.00556
; LINE_WIDTH: 0.468115
G1 X85.484 Y97.162 E.00858
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.360008
G1 F1500
M204 S6000
G1 X86.502 Y98.201 E.00897
G1 X86.7 Y98.532 E.00643
G1 X86.896 Y99.015 E.0087
G1 X86.944 Y99.188 E.00299
G1 X87.011 Y99.526 E.00575
G1 X87.034 Y99.928 E.00671
G1 X86.989 Y100.425 E.00832
G1 X86.849 Y100.941 E.00891
G1 X86.617 Y101.429 E.00901
G1 X86.398 Y101.741 E.00636
G1 X86.151 Y102.024 E.00627
G1 X85.767 Y102.347 E.00837
G1 X85.24 Y102.647 E.01011
G1 X84.816 Y102.792 E.00747
G1 X84.29 Y102.886 E.00892
G1 X84.057 Y102.896 E.00389
G1 X83.768 Y102.883 E.00481
G1 X83.484 Y102.845 E.00478
G1 X83.26 Y102.793 E.00383
G1 X82.85 Y102.656 E.00722
G1 X82.395 Y102.412 E.00861
G1 X81.974 Y102.078 E.00897
G1 X81.648 Y101.716 E.00812
G1 X81.453 Y101.418 E.00594
G1 X81.292 Y101.11 E.0058
G1 X81.144 Y100.7 E.00726
G1 X81.056 Y100.237 E.00787
G1 X81.037 Y99.891 E.00577
G1 X81.072 Y99.439 E.00755
G1 X81.202 Y98.918 E.00896
G1 X81.406 Y98.457 E.00841
G1 X81.667 Y98.063 E.00788
G1 X82.025 Y97.669 E.00888
; LINE_WIDTH: 0.400988
G1 X82.195 Y97.496 E.00453
; LINE_WIDTH: 0.438396
G1 X82.402 Y97.319 E.00562
; LINE_WIDTH: 0.477118
G1 X82.582 Y97.165 E.00534
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.146294
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00159
G1 X77.058 Y95.971 E.00146
G1 X76.983 Y95.851 E.00085
G1 X76.882 Y95.627 E.00148
; WIPE_START
G1 X76.983 Y95.851 E-.10448
G1 X77.058 Y95.971 E-.06001
G1 X77.247 Y96.123 E-.10323
G1 X77.48 Y96.249 E-.11228
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.238 Y88.62 Z3.96 F18000
G1 X76.889 Y77.602 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.0995431
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00083
; LINE_WIDTH: 0.154354
G1 X77.107 Y77.192 E.00157
G1 X77.242 Y77.073 E.00116
; LINE_WIDTH: 0.128444
G1 X77.425 Y76.991 E.00103
; LINE_WIDTH: 0.0927512
G1 X77.53 Y76.954 E.00037
; WIPE_START
G1 X77.425 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.988 Y80.888 Z3.96 F18000
G1 X93.178 Y86.344 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.691 Y86.344 E.01086
G1 X93.691 Y86.857 E.01086
G1 X93.178 Y86.857 E.01086
G1 X93.178 Y86.404 E.00959
M204 S10000
G1 X92.754 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.116 Y85.92 E.02882
G1 X94.116 Y87.282 E.02882
G1 X92.754 Y87.282 E.02882
G1 X92.754 Y85.98 E.02755
M204 S250
G1 X92.345 Y85.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.525 Y85.511 E.04288
G1 X94.525 Y87.691 E.04288
G1 X92.345 Y87.691 E.04288
G1 X92.345 Y85.571 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.344 Y85.516 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/49
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I-.872 J-.849 P1  F18000
G1 X83.603 Y96.544 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.056 Y96.544 E.03075
G1 X85.415 Y96.97 E.0118
G1 X85.291 Y97.133 E.00433
G1 X85.133 Y97.06 E.00369
G1 X84.614 Y96.908 E.01145
G1 X83.974 Y96.853 E.0136
G1 X83.363 Y96.927 E.01301
G1 X82.757 Y97.124 E.01349
G1 X82.65 Y96.966 E.00405
G1 X83.001 Y96.544 E.01161
G1 X83.543 Y96.544 E.01145
; WIPE_START
M204 S6000
G1 X85.056 Y96.544 E-.28746
G1 X85.37 Y96.916 E-.09254
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.449 Y100.912 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.43 Y100.967 E.00124
G1 X86.201 Y101.378 E.00995
G1 X85.903 Y101.741 E.00995
G1 X85.551 Y102.039 E.00976
G1 X85.276 Y102.208 E.00683
G1 X84.984 Y102.344 E.00683
G1 X84.541 Y102.473 E.00975
G1 X84.07 Y102.523 E.01004
G1 X83.542 Y102.476 E.01121
G1 X83.01 Y102.315 E.01177
G1 X82.591 Y102.089 E.01008
G1 X82.223 Y101.796 E.00995
G1 X81.911 Y101.439 E.01004
G1 X81.646 Y100.98 E.01121
G1 X81.471 Y100.452 E.01177
G1 X81.414 Y99.979 E.01008
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00975
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.455 Y97.809 E.00956
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.455 Y97.344 E.00984
G1 X83.981 Y97.28 E.01121
G1 X84.536 Y97.327 E.01177
G1 X84.984 Y97.458 E.00988
G1 X85.277 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.195 Y98.417 E.00975
G1 X86.361 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.892 E.00975
G1 X86.636 Y100.214 E.00683
G1 X86.579 Y100.531 E.00683
G1 X86.468 Y100.855 E.00724
M204 S250
G1 X86.061 Y100.78 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.054 Y100.8 E.00043
G1 X85.861 Y101.146 E.00779
G1 X85.61 Y101.452 E.00779
G1 X85.31 Y101.707 E.00774
G1 X85.082 Y101.847 E.00526
G1 X84.84 Y101.96 E.00526
G1 X84.462 Y102.07 E.00774
G1 X84.066 Y102.112 E.00783
G1 X83.62 Y102.072 E.00881
G1 X83.168 Y101.935 E.0093
G1 X82.817 Y101.746 E.00784
G1 X82.507 Y101.499 E.0078
G1 X82.245 Y101.199 E.00783
G1 X82.021 Y100.812 E.00881
G1 X81.872 Y100.363 E.0093
G1 X81.825 Y99.967 E.00784
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.00779
G1 X82.102 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.706 Y98.134 E.00767
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00776
G1 X83.989 Y97.691 E.00881
G1 X84.46 Y97.731 E.0093
G1 X84.84 Y97.842 E.00778
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.859 Y98.653 E.00773
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00774
G1 X86.245 Y99.898 E.00773
G1 X86.229 Y100.165 E.00526
G1 X86.182 Y100.428 E.00526
G1 X86.081 Y100.723 E.00613
; WIPE_START
M204 S6000
G1 X86.054 Y100.8 E-.01553
G1 X85.861 Y101.146 E-.0753
G1 X85.61 Y101.452 E-.07529
G1 X85.31 Y101.707 E-.07475
G1 X85.082 Y101.847 E-.0508
G1 X84.84 Y101.96 E-.05081
G1 X84.65 Y102.015 E-.03751
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.309 Y96.12 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12061
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.558 Y96.482 E.10477
G1 X86.757 Y97.901 E.03932
G1 X87.038 Y98.351 E.01122
G1 X87.202 Y98.72 E.00855
G1 X87.315 Y99.086 E.00811
G1 X87.389 Y99.49 E.00869
G1 X87.415 Y99.899 E.00869
G1 X87.41 Y100.077 E.00376
G1 X87.346 Y100.565 E.01042
G1 X87.202 Y101.08 E.01131
G1 X86.948 Y101.615 E.01255
G1 X86.6 Y102.101 E.01265
G1 X86.317 Y102.394 E.00862
G1 X86.107 Y102.57 E.0058
G1 X85.678 Y102.855 E.0109
G1 X85.308 Y103.032 E.00868
G1 X84.918 Y103.164 E.0087
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.155 Y103.165 E.01244
G1 X82.691 Y103 E.01042
G1 X82.222 Y102.753 E.01122
G1 X81.902 Y102.522 E.00836
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.941 Y101.26 E.0084
G1 X80.78 Y100.804 E.01022
G1 X80.677 Y100.284 E.01122
G1 X80.655 Y99.89 E.00836
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.871 Y98.711 E.00849
G1 X81.033 Y98.349 E.00839
G1 X81.286 Y97.938 E.01023
G1 X82.501 Y96.482 E.04014
G1 X77.571 Y96.482 E.10436
G1 X77.24 Y96.429 E.00709
G1 X77.006 Y96.304 E.00562
G1 X76.841 Y96.14 E.00491
G1 X76.771 Y96.037 E.00265
G1 X76.683 Y95.812 E.00511
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.75 Y77.207 E.00324
G1 X76.835 Y77.069 E.00343
G1 X77.01 Y76.896 E.00521
G1 X77.226 Y76.778 E.0052
G1 X77.484 Y76.723 E.00558
G1 X90.546 Y76.722 E.27649
G1 X90.741 Y76.748 E.00416
G1 X90.877 Y76.792 E.00302
G1 X91.053 Y76.892 E.00428
G1 X91.003 Y77.082 E.00415
G1 X77.984 Y77.082 E.27556
G1 X77.708 Y77.127 E.00593
G1 X77.42 Y77.278 E.00688
G1 X77.191 Y77.515 E.00698
G1 X77.053 Y77.803 E.00675
G1 X77.016 Y78.056 E.00541
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.616 Y96.047 E.00951
G1 X77.971 Y96.12 E.00768
G1 X85.249 Y96.12 E.15403
; WIPE_START
M204 S6000
G1 X87.249 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.439 Y96.891 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.088 Y97.659 E.01979
G1 X87.4 Y98.158 E.01157
G1 X87.583 Y98.57 E.00887
G1 X87.714 Y98.994 E.00873
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00427
G1 X87.748 Y100.647 E.01068
G1 X87.589 Y101.215 E.01159
G1 X87.469 Y101.5 E.0061
G1 X87.302 Y101.822 E.00712
G1 X87.131 Y102.084 E.00615
G1 X86.91 Y102.369 E.0071
G1 X86.596 Y102.694 E.00889
G1 X86.356 Y102.894 E.00614
G1 X86.06 Y103.105 E.00716
G1 X85.871 Y103.216 E.00432
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00892
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.038 Y103.557 E.00427
G1 X82.527 Y103.376 E.01068
G1 X82.006 Y103.102 E.01157
G1 X81.643 Y102.84 E.00881
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.422 E.00882
G1 X80.385 Y100.913 E.01061
G1 X80.27 Y100.336 E.01157
G1 X80.245 Y99.889 E.00881
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.567 E.00885
G1 X80.67 Y98.158 E.00882
G1 X80.953 Y97.698 E.01062
G1 X81.627 Y96.891 E.02068
G1 X77.547 Y96.891 E.08025
G1 X77.231 Y96.854 E.00625
G1 X76.916 Y96.731 E.00666
G1 X76.651 Y96.54 E.00641
G1 X76.519 Y96.394 E.00389
G1 X76.417 Y96.244 E.00355
G1 X76.352 Y96.114 E.00286
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.383 Y77.022 E.00442
G1 X76.502 Y76.828 E.00448
G1 X76.595 Y76.718 E.00283
G1 X76.765 Y76.567 E.00448
G1 X76.959 Y76.447 E.00448
G1 X77.091 Y76.39 E.00283
G1 X77.314 Y76.33 E.00454
G1 X77.46 Y76.313 E.00289
G1 X90.573 Y76.312 E.25793
G1 X90.834 Y76.347 E.00516
G1 X91.043 Y76.416 E.00435
G1 X91.281 Y76.55 E.00536
G1 X91.472 Y76.716 E.00499
G1 X91.627 Y76.917 E.00499
G1 X91.747 Y77.162 E.00536
G1 X91.804 Y77.375 E.00433
M73 P78 R5
G1 X91.811 Y77.491 E.00229
G1 X78.018 Y77.491 E.27131
G1 X77.839 Y77.52 E.00356
G1 X77.668 Y77.61 E.00379
G1 X77.531 Y77.752 E.00389
G1 X77.448 Y77.924 E.00375
G1 X77.425 Y78.086 E.00321
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.499 Y96.891 E.0792
; WIPE_START
M204 S6000
G1 X87.088 Y97.659 E-.18399
G1 X87.4 Y98.158 E-.11174
G1 X87.58 Y98.563 E-.08427
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




G1 X86.162 Y97.784
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.379974
G1 F1500
M204 S6000
G1 X85.986 Y97.608 E.0044
; LINE_WIDTH: 0.424073
G1 X85.787 Y97.411 E.00557
; LINE_WIDTH: 0.468513
G1 X85.521 Y97.181 E.00776
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.35995
G1 F1500
M204 S6000
G1 X86.448 Y98.126 E.00743
G1 X86.702 Y98.529 E.00795
G1 X86.848 Y98.856 E.00597
G1 X86.982 Y99.351 E.00855
G1 X87.035 Y99.898 E.00917
G1 X87.01 Y100.249 E.00586
G1 X86.938 Y100.637 E.00658
G1 X86.777 Y101.106 E.00827
G1 X86.616 Y101.421 E.00589
G1 X86.308 Y101.852 E.00884
G1 X86.056 Y102.113 E.00604
G1 X85.761 Y102.349 E.0063
G1 X85.465 Y102.537 E.00585
G1 X85.105 Y102.702 E.0066
G1 X84.599 Y102.842 E.00875
G1 X84.29 Y102.886 E.00521
G1 X84.057 Y102.896 E.00388
G1 X83.768 Y102.883 E.00482
G1 X83.487 Y102.845 E.00473
G1 X83.26 Y102.793 E.00388
G1 X82.85 Y102.656 E.00721
G1 X82.395 Y102.412 E.00861
G1 X81.974 Y102.078 E.00897
G1 X81.648 Y101.716 E.00812
G1 X81.454 Y101.418 E.00593
G1 X81.29 Y101.11 E.00581
G1 X81.151 Y100.703 E.00718
G1 X81.059 Y100.236 E.00794
G1 X81.037 Y99.891 E.00576
G1 X81.072 Y99.439 E.00755
G1 X81.202 Y98.918 E.00896
G1 X81.404 Y98.465 E.00827
G1 X81.604 Y98.147 E.00627
G1 X82.024 Y97.668 E.01063
; LINE_WIDTH: 0.405973
G1 X82.192 Y97.493 E.0046
; LINE_WIDTH: 0.443878
G1 X82.38 Y97.327 E.00523
; LINE_WIDTH: 0.477352
G1 X82.542 Y97.186 E.00486
; WIPE_START
G1 X82.38 Y97.327 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.473 Y96.256 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.150389
G1 F1500
M204 S6000
G1 X77.248 Y96.123 E.00163
G1 X77.058 Y95.972 E.00151
G1 X76.882 Y95.626 E.00241
; WIPE_START
G1 X77.058 Y95.972 E-.16504
G1 X77.248 Y96.123 E-.10356
G1 X77.473 Y96.256 E-.1114
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.234 Y88.628 Z4.08 F18000
G1 X76.889 Y77.603 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.100821
G1 F1500
M204 S6000
G1 X76.945 Y77.423 E.00071
; LINE_WIDTH: 0.153115
G1 X76.993 Y77.33 E.00066
G1 X77.097 Y77.201 E.00106
G1 X77.251 Y77.067 E.00129
; LINE_WIDTH: 0.128515
G1 X77.407 Y76.997 E.00088
; LINE_WIDTH: 0.0972556
G1 X77.499 Y76.964 E.00035
; LINE_WIDTH: 0.0820025
G1 X77.535 Y76.955 E.0001
; WIPE_START
G1 X77.499 Y76.964 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.055 Y80.873 Z4.08 F18000
G1 X93.098 Y86.264 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.771 Y86.264 E.01425
G1 X93.771 Y86.937 E.01425
G1 X93.098 Y86.937 E.01425
G1 X93.098 Y86.324 E.01298
M204 S10000
G1 X92.674 Y85.84 F18000
G1 F1500
M204 S500
G1 X94.196 Y85.84 E.0322
G1 X94.196 Y87.362 E.0322
G1 X92.674 Y87.362 E.0322
G1 X92.674 Y85.9 E.03093
M204 S250
G1 X92.265 Y85.431 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2536.476
M204 S500
G1 X94.605 Y85.431 E.04603
G1 X94.605 Y87.771 E.04603
G1 X92.265 Y87.771 E.04603
G1 X92.265 Y85.491 E.04485
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X94.264 Y85.44 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/49
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I-.963 J-.744 P1  F18000
G1 X85.244 Y97.112 Z4.08
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.155 Y97.066 E.00211
G1 X84.639 Y96.915 E.01137
G1 X84.266 Y96.865 E.00797
G1 X83.938 Y96.857 E.00694
G1 X83.363 Y96.927 E.01226
G1 X82.8 Y97.11 E.01253
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.374 Y96.946 E.01127
G1 X85.281 Y97.064 E.00318
; WIPE_START
M204 S6000
G1 X85.155 Y97.066 E-.02389
G1 X84.639 Y96.915 E-.1021
G1 X84.266 Y96.865 E-.07155
G1 X83.938 Y96.857 E-.06232
G1 X83.363 Y96.927 E-.11004
G1 X83.313 Y96.944 E-.0101
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.449 Y100.912 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.432 Y100.964 E.00116
G1 X86.201 Y101.378 E.01003
G1 X85.902 Y101.741 E.00995
G1 X85.541 Y102.048 E.01004
G1 X85.098 Y102.295 E.01074
G1 X84.842 Y102.394 E.00579
G1 X84.532 Y102.474 E.00678
G1 X84.083 Y102.521 E.00956
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00684
G1 X83.004 Y102.312 E.00975
G1 X82.591 Y102.089 E.00994
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.039 E.00994
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.443 Y99.506 E.00984
G1 X81.569 Y99.014 E.01075
G1 X81.675 Y98.762 E.00579
G1 X81.831 Y98.482 E.00678
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.455 Y97.344 E.00984
G1 X83.959 Y97.282 E.01075
G1 X84.233 Y97.288 E.00579
G1 X84.551 Y97.331 E.00679
G1 X84.997 Y97.462 E.00983
G1 X85.448 Y97.695 E.01075
G1 X85.67 Y97.854 E.00579
G1 X85.911 Y98.071 E.00687
G1 X86.223 Y98.46 E.01055
G1 X86.361 Y98.696 E.00579
G1 X86.492 Y98.989 E.00679
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.892 E.00975
G1 X86.636 Y100.212 E.00678
G1 X86.59 Y100.481 E.00579
G1 X86.467 Y100.855 E.00832
M204 S250
G1 X86.06 Y100.785 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.055 Y100.799 E.0003
G1 X85.862 Y101.146 E.00782
G1 X85.61 Y101.452 E.0078
G1 X85.306 Y101.71 E.00783
G1 X84.923 Y101.924 E.00863
G1 X84.717 Y102.003 E.00435
G1 X84.459 Y102.07 E.00525
G1 X84.071 Y102.111 E.00767
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.00779
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00779
G1 X82.043 Y100.86 E.00779
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.57 E.00776
G1 X81.958 Y99.145 E.00863
G1 X82.044 Y98.941 E.00435
G1 X82.174 Y98.708 E.00524
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00774
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00776
G1 X83.98 Y97.692 E.00863
G1 X84.201 Y97.697 E.00435
G1 X84.465 Y97.733 E.00525
G1 X84.844 Y97.843 E.00776
G1 X85.234 Y98.045 E.00863
G1 X85.413 Y98.173 E.00435
G1 X85.613 Y98.353 E.00527
G1 X85.885 Y98.693 E.00857
G1 X85.997 Y98.883 E.00435
G1 X86.106 Y99.127 E.00525
G1 X86.21 Y99.506 E.00773
G1 X86.245 Y99.898 E.00773
G1 X86.229 Y100.164 E.00525
G1 X86.191 Y100.382 E.00435
G1 X86.078 Y100.728 E.00715
; WIPE_START
M204 S6000
G1 X86.055 Y100.799 E-.01426
G1 X85.862 Y101.146 E-.07554
G1 X85.61 Y101.452 E-.07534
G1 X85.306 Y101.71 E-.0756
G1 X84.923 Y101.924 E-.08333
G1 X84.717 Y102.003 E-.042
G1 X84.646 Y102.022 E-.01393
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.712 Y97.838 E.03805
G1 X87.031 Y98.337 E.01254
G1 X87.202 Y98.72 E.00888
G1 X87.361 Y99.3 E.01273
G1 X87.415 Y99.899 E.01273
G1 X87.41 Y100.077 E.00376
G1 X87.346 Y100.57 E.01053
G1 X87.208 Y101.065 E.01087
G1 X86.952 Y101.608 E.0127
G1 X86.673 Y102.011 E.01038
G1 X86.327 Y102.385 E.01078
G1 X86.001 Y102.65 E.00889
G1 X85.678 Y102.855 E.0081
G1 X85.128 Y103.099 E.01274
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00868
G1 X83.734 Y103.267 E.01254
G1 X83.155 Y103.165 E.01245
G1 X82.686 Y102.998 E.01053
G1 X82.235 Y102.762 E.01079
G1 X81.902 Y102.522 E.00869
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.123 Y101.617 E.0084
G1 X80.908 Y101.179 E.01034
G1 X80.75 Y100.699 E.01069
G1 X80.671 Y100.208 E.01053
G1 X80.661 Y99.699 E.01078
G1 X80.711 Y99.291 E.00869
G1 X80.806 Y98.901 E.0085
G1 X80.947 Y98.526 E.00849
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.24 Y96.429 E.00709
G1 X77.006 Y96.304 E.00562
G1 X76.824 Y96.119 E.00549
G1 X76.684 Y95.821 E.00696
G1 X76.654 Y95.565 E.00546
G1 X76.654 Y77.619 E.37984
G1 X76.694 Y77.344 E.00587
G1 X76.799 Y77.12 E.00523
G1 X76.983 Y76.917 E.0058
G1 X77.093 Y76.841 E.00283
G1 X77.239 Y76.773 E.0034
G1 X77.49 Y76.723 E.00543
G1 X90.548 Y76.722 E.27638
G1 X90.741 Y76.747 E.00413
G1 X90.883 Y76.794 E.00316
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.133 E.0062
G1 X77.414 Y77.283 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.214 Y96.12 E.15348
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.036 Y97.588 E.01816
G1 X87.291 Y97.962 E.00891
G1 X87.398 Y98.153 E.00431
G1 X87.583 Y98.57 E.00897
G1 X87.654 Y98.777 E.00431
G1 X87.763 Y99.22 E.00897
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.109 E.00428
G1 X87.749 Y100.646 E.01065
G1 X87.662 Y101 E.00718
G1 X87.471 Y101.496 E.01045
G1 X87.303 Y101.819 E.00716
G1 X86.996 Y102.263 E.01061
G1 X86.599 Y102.691 E.01149
G1 X86.246 Y102.979 E.00897
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.038 Y103.557 E.00428
G1 X82.528 Y103.376 E.01065
G1 X82.2 Y103.217 E.00718
G1 X82.011 Y103.105 E.00432
G1 X81.643 Y102.84 E.00891
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.822 E.00882
G1 X80.53 Y101.339 E.01059
G1 X80.35 Y100.785 E.01146
G1 X80.263 Y100.251 E.01065
G1 X80.245 Y99.886 E.00718
G1 X80.252 Y99.667 E.00432
G1 X80.307 Y99.217 E.00891
G1 X80.415 Y98.78 E.00885
G1 X80.573 Y98.359 E.00885
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X76.914 Y96.731 E.0067
G1 X76.652 Y96.541 E.00636
G1 X76.499 Y96.369 E.00454
G1 X76.42 Y96.248 E.00283
G1 X76.322 Y96.039 E.00454
G1 X76.282 Y95.904 E.00277
G1 X76.245 Y95.589 E.00625
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.23 E.00451
G1 X76.362 Y77.065 E.00346
G1 X76.457 Y76.893 E.00386
G1 X76.598 Y76.715 E.00447
M73 P79 R5
G1 X76.728 Y76.596 E.00346
G1 X76.889 Y76.485 E.00386
G1 X77.095 Y76.389 E.00447
G1 X77.264 Y76.341 E.00346
G1 X77.462 Y76.313 E.00392
G1 X90.575 Y76.312 E.25793
G1 X90.833 Y76.347 E.00512
G1 X91.045 Y76.417 E.00439
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00362
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00318
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.036 Y97.588 E-.1682
G1 X87.291 Y97.962 E-.08608
G1 X87.398 Y98.153 E-.04159
G1 X87.578 Y98.558 E-.08413
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




G1 X86.178 Y97.801
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.381882
G1 F1500
M204 S6000
G1 X85.914 Y97.533 E.00668
; LINE_WIDTH: 0.423639
G1 X85.802 Y97.432 E.00301
; LINE_WIDTH: 0.477419
G1 X85.475 Y97.16 E.00956
M204 S10000
G1 X86.178 Y97.801 F18000
; LINE_WIDTH: 0.359938
G1 F1500
M204 S6000
G1 X86.405 Y98.071 E.00589
G1 X86.692 Y98.51 E.00874
G1 X86.893 Y99.004 E.0089
G1 X86.985 Y99.38 E.00646
G1 X87.03 Y99.898 E.00867
G1 X87.008 Y100.264 E.00611
G1 X86.953 Y100.584 E.00541
G1 X86.755 Y101.163 E.0102
G1 X86.502 Y101.6 E.00843
G1 X86.18 Y101.993 E.00848
G1 X85.777 Y102.344 E.0089
G1 X85.496 Y102.514 E.00548
G1 X85.006 Y102.738 E.00898
G1 X84.654 Y102.835 E.00609
G1 X84.292 Y102.885 E.00609
G1 X83.768 Y102.888 E.00874
G1 X83.259 Y102.796 E.00862
G1 X82.842 Y102.653 E.00735
G1 X82.397 Y102.408 E.00847
G1 X82.142 Y102.222 E.00525
G1 X81.881 Y101.985 E.00589
G1 X81.6 Y101.651 E.00727
G1 X81.342 Y101.214 E.00847
G1 X81.161 Y100.758 E.00817
G1 X81.071 Y100.338 E.00717
G1 X81.04 Y99.963 E.00626
G1 X81.073 Y99.432 E.00888
G1 X81.173 Y99.015 E.00715
G1 X81.296 Y98.681 E.00592
G1 X81.51 Y98.285 E.00751
G1 X81.827 Y97.872 E.00867
G1 X82.021 Y97.673 E.00463
; LINE_WIDTH: 0.400638
G1 X82.195 Y97.496 E.00465
; LINE_WIDTH: 0.438425
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477116
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.459 Y96.254 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.153161
G1 F1500
M204 S6000
G1 X77.134 Y96.04 E.00247
G1 X77.044 Y95.954 E.00079
G1 X76.959 Y95.8 E.00112
; LINE_WIDTH: 0.123413
G1 X76.927 Y95.711 E.00046
; LINE_WIDTH: 0.0936248
G1 X76.896 Y95.622 E.00032
; WIPE_START
G1 X76.927 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.911 Y88.079 Z4.2 F18000
G1 X76.889 Y77.601 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.0986174
G1 F1500
M204 S6000
G1 X76.968 Y77.374 E.00087
; LINE_WIDTH: 0.155968
G1 X77.109 Y77.19 E.00151
G1 X77.231 Y77.078 E.00107
; LINE_WIDTH: 0.129835
G1 X77.43 Y76.989 E.00113
; LINE_WIDTH: 0.0923687
G1 X77.53 Y76.954 E.00035
; WIPE_START
G1 X77.43 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.004 Y80.867 Z4.2 F18000
G1 X93.018 Y86.184 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y86.184 E.01763
G1 X93.851 Y87.017 E.01763
G1 X93.018 Y87.017 E.01763
G1 X93.018 Y86.244 E.01636
M204 S10000
G1 X92.594 Y85.76 F18000
G1 F1500
M204 S500
G1 X94.276 Y85.76 E.03559
G1 X94.276 Y87.442 E.03559
G1 X92.594 Y87.442 E.03559
G1 X92.594 Y85.82 E.03432
M204 S250
G1 X92.185 Y85.351 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2536.476
M204 S500
G1 X94.685 Y85.351 E.04917
G1 X94.685 Y87.851 E.04917
G1 X92.185 Y87.851 E.04917
G1 X92.185 Y85.411 E.04799
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X94.184 Y85.363 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 32/49
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I-.968 J-.737 P1  F18000
G1 X85.244 Y97.112 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.155 Y97.066 E.00212
G1 X84.639 Y96.915 E.01137
G1 X84.266 Y96.864 E.00797
G1 X83.935 Y96.857 E.007
G1 X83.363 Y96.928 E.0122
G1 X82.8 Y97.11 E.01252
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.374 Y96.946 E.01127
G1 X85.281 Y97.064 E.00318
; WIPE_START
M204 S6000
G1 X85.155 Y97.066 E-.02397
G1 X84.639 Y96.915 E-.10206
G1 X84.266 Y96.864 E-.07158
G1 X83.935 Y96.857 E-.06283
G1 X83.363 Y96.928 E-.10954
G1 X83.313 Y96.944 E-.01002
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.441 Y100.934 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.425 Y100.975 E.00093
G1 X86.201 Y101.378 E.00975
G1 X85.902 Y101.741 E.00995
G1 X85.541 Y102.047 E.01004
G1 X85.1 Y102.294 E.01069
G1 X84.843 Y102.393 E.00584
G1 X84.532 Y102.474 E.00679
G1 X84.074 Y102.522 E.00975
G1 X83.605 Y102.487 E.00995
G1 X83.159 Y102.371 E.00975
G1 X82.863 Y102.245 E.00683
G1 X82.583 Y102.083 E.00683
G1 X82.223 Y101.796 E.00975
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.038 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
M73 P79 R4
G1 X81.415 Y99.97 E.00683
G1 X81.443 Y99.506 E.00983
G1 X81.569 Y99.017 E.01069
G1 X81.675 Y98.762 E.00585
G1 X81.831 Y98.482 E.00679
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.724 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.455 Y97.344 E.00983
G1 X83.956 Y97.282 E.01069
G1 X84.233 Y97.288 E.00584
G1 X84.55 Y97.331 E.00679
G1 X84.996 Y97.461 E.00983
G1 X85.445 Y97.693 E.01069
G1 X85.67 Y97.854 E.00584
G1 X85.901 Y98.062 E.00659
G1 X86.108 Y98.298 E.00663
G1 X86.289 Y98.564 E.00683
G1 X86.489 Y98.98 E.00976
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00683
G1 X86.462 Y100.878 E.00463
M204 S250
G1 X86.058 Y100.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.053 Y100.803 E.00026
G1 X85.862 Y101.146 E.00773
G1 X85.61 Y101.452 E.0078
G1 X85.306 Y101.71 E.00783
G1 X84.926 Y101.923 E.00858
G1 X84.717 Y102.003 E.0044
G1 X84.459 Y102.07 E.00525
G1 X84.068 Y102.111 E.00774
G1 X83.673 Y102.082 E.0078
G1 X83.292 Y101.983 E.00773
G1 X83.046 Y101.878 E.00526
G1 X82.814 Y101.744 E.00526
G1 X82.507 Y101.499 E.00773
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.86 E.0078
G1 X81.905 Y100.492 E.00773
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.57 E.00776
G1 X81.957 Y99.148 E.00858
G1 X82.044 Y98.941 E.0044
G1 X82.174 Y98.708 E.00525
G1 X82.414 Y98.397 E.00774
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00776
G1 X83.977 Y97.692 E.00858
G1 X84.201 Y97.697 E.0044
G1 X84.465 Y97.733 E.00525
G1 X84.844 Y97.843 E.00776
G1 X85.231 Y98.043 E.00858
G1 X85.413 Y98.173 E.0044
G1 X85.609 Y98.35 E.00519
G1 X85.783 Y98.549 E.0052
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00774
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.079 Y100.734 E.00382
; WIPE_START
M204 S6000
G1 X86.053 Y100.803 E-.01388
G1 X85.862 Y101.146 E-.0747
G1 X85.61 Y101.452 E-.07534
G1 X85.306 Y101.71 E-.07559
G1 X84.926 Y101.923 E-.08287
G1 X84.717 Y102.003 E-.04247
G1 X84.64 Y102.023 E-.01516
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03825
G1 X86.825 Y97.992 E.00386
G1 X87.037 Y98.349 E.00878
G1 X87.263 Y98.899 E.0126
G1 X87.389 Y99.48 E.01258
G1 X87.415 Y99.899 E.00888
G1 X87.41 Y100.077 E.00377
G1 X87.347 Y100.566 E.01043
G1 X87.208 Y101.066 E.01097
G1 X86.95 Y101.612 E.01279
G1 X86.605 Y102.096 E.01258
G1 X86.317 Y102.394 E.00878
G1 X86.114 Y102.564 E.00561
G1 X85.678 Y102.855 E.01108
G1 X85.303 Y103.034 E.00878
G1 X85.054 Y103.122 E.0056
G1 X84.734 Y103.207 E.007
G1 X84.326 Y103.269 E.00873
G1 X83.734 Y103.267 E.01254
G1 X83.155 Y103.164 E.01245
G1 X82.69 Y103 E.01043
G1 X82.235 Y102.762 E.01088
G1 X81.902 Y102.522 E.00869
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.708 Y100.493 E.00841
G1 X80.658 Y100.012 E.01023
G1 X80.679 Y99.499 E.01088
G1 X80.754 Y99.086 E.00888
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00344
G1 X76.824 Y96.119 E.00343
G1 X76.684 Y95.821 E.00696
G1 X76.654 Y95.565 E.00546
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.805 Y77.11 E.00539
G1 X76.97 Y76.928 E.0052
G1 X77.096 Y76.84 E.00324
G1 X77.239 Y76.773 E.00335
G1 X77.49 Y76.723 E.00543
G1 X90.55 Y76.722 E.27641
G1 X90.741 Y76.747 E.00409
G1 X90.883 Y76.794 E.00316
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.133 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.253 Y95.773 E.00783
G1 X77.592 Y96.035 E.00908
G1 X77.965 Y96.12 E.0081
G1 X85.214 Y96.12 E.15342
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.4 Y98.158 E.00894
G1 X87.527 Y98.432 E.00596
G1 X87.655 Y98.779 E.00727
G1 X87.763 Y99.22 E.00892
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.109 E.00428
G1 X87.75 Y100.641 E.01056
G1 X87.662 Y101.001 E.00727
G1 X87.473 Y101.492 E.01036
G1 X87.302 Y101.82 E.00728
G1 X87.05 Y102.197 E.00893
G1 X86.912 Y102.368 E.00431
G1 X86.596 Y102.694 E.00894
G1 X86.364 Y102.889 E.00595
M73 P80 R4
G1 X86.059 Y103.105 E.00734
G1 X85.871 Y103.216 E.00432
G1 X85.46 Y103.412 E.00894
G1 X85.175 Y103.513 E.00595
G1 X84.818 Y103.609 E.00728
G1 X84.369 Y103.676 E.00893
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.038 Y103.557 E.00428
G1 X82.532 Y103.378 E.01056
G1 X82.2 Y103.217 E.00727
G1 X82.011 Y103.105 E.00432
G1 X81.643 Y102.84 E.00891
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.562 E.00882
G1 X80.249 Y100.031 E.01049
G1 X80.252 Y99.661 E.00727
G1 X80.273 Y99.443 E.00432
G1 X80.355 Y98.994 E.00897
G1 X80.414 Y98.783 E.0043
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.368 E.00448
G1 X76.42 Y96.248 E.00283
G1 X76.322 Y96.039 E.00454
G1 X76.282 Y95.904 E.00277
G1 X76.245 Y95.589 E.00625
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.459 Y76.89 E.00454
G1 X76.545 Y76.774 E.00283
G1 X76.706 Y76.613 E.00448
G1 X76.89 Y76.484 E.00442
G1 X77.095 Y76.389 E.00445
G1 X77.263 Y76.341 E.00342
G1 X77.462 Y76.313 E.00396
G1 X90.577 Y76.313 E.25796
G1 X90.833 Y76.347 E.00509
G1 X91.045 Y76.417 E.00439
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.499 E.00427
G1 X77.771 Y95.656 E.00507
G1 X78.011 Y95.711 E.00484
G1 X91.817 Y95.711 E.27154
G1 X91.79 Y95.895 E.00367
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00441
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16881
G1 X87.167 Y97.767 E-.04156
G1 X87.4 Y98.158 E-.08636
G1 X87.527 Y98.432 E-.05754
G1 X87.574 Y98.559 E-.02573
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




G1 X86.165 Y97.788
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359942
G1 F1500
M204 S6000
G1 X86.417 Y98.077 E.00639
G1 X86.697 Y98.527 E.00882
G1 X86.896 Y99.013 E.00876
G1 X86.985 Y99.38 E.00631
G1 X87.031 Y99.915 E.00895
G1 X86.988 Y100.409 E.00826
G1 X86.904 Y100.777 E.00629
G1 X86.773 Y101.123 E.00616
G1 X86.619 Y101.416 E.00552
G1 X86.414 Y101.722 E.00614
G1 X86.054 Y102.115 E.00889
G1 X85.741 Y102.364 E.00666
G1 X85.271 Y102.631 E.00901
G1 X84.949 Y102.757 E.00577
G1 X84.588 Y102.848 E.00622
G1 X84.065 Y102.896 E.00875
G1 X83.558 Y102.858 E.00847
G1 X83.259 Y102.794 E.0051
G1 X82.837 Y102.648 E.00744
G1 X82.579 Y102.522 E.00479
G1 X82.383 Y102.398 E.00386
G1 X81.974 Y102.078 E.00866
G1 X81.648 Y101.716 E.00812
G1 X81.453 Y101.418 E.00593
G1 X81.289 Y101.103 E.00593
G1 X81.151 Y100.725 E.0067
G1 X81.072 Y100.357 E.00627
G1 X81.037 Y99.963 E.0066
G1 X81.075 Y99.433 E.00887
G1 X81.17 Y99.024 E.007
G1 X81.34 Y98.589 E.00778
G1 X81.51 Y98.285 E.00581
G1 X81.662 Y98.073 E.00436
G1 X82.021 Y97.673 E.00894
; LINE_WIDTH: 0.400615
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438397
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477096
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.476 Y97.16 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.477706
G1 F1500
M204 S6000
G1 X85.8 Y97.43 E.00953
; LINE_WIDTH: 0.423837
G1 X85.914 Y97.533 E.00303
; LINE_WIDTH: 0.382975
G1 X86.165 Y97.788 E.00638
; WIPE_START
G1 X85.914 Y97.533 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.368 Y96.383 Z4.32 F18000
G1 X77.47 Y96.246 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.125274
G1 F1500
M204 S6000
G1 X77.358 Y96.185 E.00063
; LINE_WIDTH: 0.153332
G1 X77.127 Y96.033 E.00176
G1 X77.039 Y95.945 E.00079
G1 X76.959 Y95.801 E.00105
; LINE_WIDTH: 0.12371
G1 X76.927 Y95.711 E.00046
; LINE_WIDTH: 0.0937187
G1 X76.896 Y95.622 E.00032
; WIPE_START
G1 X76.927 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.911 Y88.079 Z4.32 F18000
G1 X76.889 Y77.601 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.099556
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00083
; LINE_WIDTH: 0.157346
G1 X77.042 Y77.266 E.00097
G1 X77.231 Y77.079 E.00174
; LINE_WIDTH: 0.129644
G1 X77.403 Y76.995 E.00099
; LINE_WIDTH: 0.0986965
G1 X77.53 Y76.954 E.00049
; WIPE_START
G1 X77.403 Y76.995 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.987 Y80.856 Z4.32 F18000
G1 X92.938 Y86.104 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.931 Y86.104 E.02102
G1 X93.931 Y87.097 E.02102
G1 X92.938 Y87.097 E.02102
G1 X92.938 Y86.164 E.01975
M204 S10000
G1 X92.514 Y85.68 F18000
G1 F1500
M204 S500
G1 X94.356 Y85.68 E.03898
G1 X94.356 Y87.522 E.03898
G1 X92.514 Y87.522 E.03898
G1 X92.514 Y85.74 E.03771
M204 S250
G1 X92.105 Y85.271 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2536.476
M204 S500
G1 X94.765 Y85.271 E.05232
G1 X94.765 Y87.931 E.05232
G1 X92.105 Y87.931 E.05232
G1 X92.105 Y85.331 E.05114
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X94.104 Y85.286 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/49
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I-.974 J-.73 P1  F18000
G1 X85.244 Y97.112 Z4.32
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.154 Y97.066 E.00213
G1 X84.639 Y96.915 E.01136
G1 X84.265 Y96.864 E.00798
G1 X83.932 Y96.857 E.00706
G1 X83.362 Y96.928 E.01215
G1 X82.8 Y97.11 E.01251
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.374 Y96.946 E.01128
G1 X85.281 Y97.065 E.00318
; WIPE_START
M204 S6000
G1 X85.154 Y97.066 E-.02405
G1 X84.639 Y96.915 E-.10201
G1 X84.265 Y96.864 E-.07163
G1 X83.932 Y96.857 E-.06334
G1 X83.362 Y96.928 E-.10905
G1 X83.313 Y96.944 E-.00993
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.439 Y100.94 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.425 Y100.975 E.0008
G1 X86.201 Y101.378 E.00975
G1 X85.902 Y101.741 E.00995
G1 X85.541 Y102.047 E.01003
G1 X85.103 Y102.293 E.01064
G1 X84.843 Y102.393 E.0059
G1 X84.532 Y102.474 E.00679
G1 X84.074 Y102.522 E.00975
G1 X83.601 Y102.487 E.01003
G1 X83.117 Y102.355 E.01064
G1 X82.861 Y102.244 E.0059
G1 X82.583 Y102.083 E.00679
G1 X82.223 Y101.796 E.00975
G1 X81.914 Y101.442 E.00995
G1 X81.677 Y101.046 E.00975
G1 X81.556 Y100.75 E.00679
G1 X81.48 Y100.481 E.0059
G1 X81.414 Y99.983 E.01064
G1 X81.443 Y99.506 E.01011
G1 X81.568 Y99.02 E.01064
G1 X81.675 Y98.762 E.0059
G1 X81.831 Y98.482 E.00679
G1 X82.107 Y98.125 E.00956
G1 X82.339 Y97.903 E.00679
G1 X82.561 Y97.735 E.0059
G1 X83.001 Y97.491 E.01064
G1 X83.455 Y97.344 E.01011
G1 X83.954 Y97.282 E.01064
G1 X84.232 Y97.288 E.0059
G1 X84.551 Y97.331 E.00679
G1 X84.996 Y97.461 E.00983
G1 X85.443 Y97.692 E.01064
G1 X85.67 Y97.854 E.0059
G1 X85.908 Y98.068 E.00679
G1 X86.195 Y98.417 E.00955
G1 X86.361 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00683
G1 X86.46 Y100.884 E.00476
M204 S250
G1 X86.056 Y100.796 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X86.053 Y100.803 E.00014
G1 X85.861 Y101.146 E.00774
G1 X85.61 Y101.452 E.0078
G1 X85.306 Y101.71 E.00782
G1 X84.928 Y101.922 E.00853
G1 X84.717 Y102.003 E.00445
G1 X84.459 Y102.07 E.00525
G1 X84.068 Y102.111 E.00774
G1 X83.671 Y102.082 E.00782
G1 X83.253 Y101.968 E.00853
G1 X83.045 Y101.877 E.00445
G1 X82.814 Y101.744 E.00525
G1 X82.507 Y101.499 E.00773
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.863 E.00773
G1 X81.943 Y100.616 E.00525
G1 X81.882 Y100.398 E.00445
G1 X81.825 Y99.968 E.00853
G1 X81.849 Y99.57 E.00785
G1 X81.957 Y99.15 E.00853
G1 X82.044 Y98.941 E.00445
G1 X82.174 Y98.708 E.00525
G1 X82.412 Y98.4 E.00767
G1 X82.605 Y98.215 E.00525
G1 X82.785 Y98.079 E.00445
G1 X83.165 Y97.868 E.00853
G1 X83.544 Y97.745 E.00784
G1 X83.975 Y97.692 E.00854
G1 X84.201 Y97.697 E.00445
G1 X84.465 Y97.733 E.00525
G1 X84.844 Y97.843 E.00776
G1 X85.229 Y98.042 E.00853
G1 X85.413 Y98.173 E.00445
G1 X85.612 Y98.352 E.00525
G1 X85.859 Y98.653 E.00767
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00773
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.077 Y100.74 E.00394
; WIPE_START
M204 S6000
G1 X86.053 Y100.803 E-.01279
G1 X85.861 Y101.146 E-.07473
G1 X85.61 Y101.452 E-.07531
G1 X85.306 Y101.71 E-.07556
G1 X84.928 Y101.922 E-.08243
G1 X84.717 Y102.003 E-.04294
G1 X84.634 Y102.025 E-.01625
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.715 Y97.841 E.03814
G1 X87.039 Y98.351 E.01279
G1 X87.266 Y98.91 E.01277
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.077 E.01245
G1 X87.348 Y100.562 E.01034
G1 X87.208 Y101.066 E.01107
G1 X87.104 Y101.314 E.0057
G1 X86.947 Y101.616 E.00719
G1 X86.6 Y102.101 E.01264
G1 X86.175 Y102.517 E.01258
G1 X85.678 Y102.855 E.01273
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.327 Y103.269 E.00869
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.163 E.01254
G1 X82.753 Y103.029 E.00888
G1 X82.291 Y102.794 E.01097
G1 X81.899 Y102.52 E.01014
G1 X81.606 Y102.251 E.00841
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.94 Y101.26 E.00841
G1 X80.781 Y100.808 E.01014
G1 X80.678 Y100.3 E.01097
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.871 Y98.712 E.00849
G1 X81.036 Y98.341 E.00859
M73 P81 R4
G1 X81.357 Y97.839 E.01259
G1 X82.538 Y96.482 E.03809
G1 X77.571 Y96.482 E.10512
G1 X77.24 Y96.43 E.00708
G1 X77.006 Y96.304 E.00562
G1 X76.838 Y96.137 E.00501
G1 X76.771 Y96.037 E.00255
G1 X76.683 Y95.812 E.00512
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.963 Y76.933 E.00539
G1 X77.2 Y76.789 E.00588
G1 X77.33 Y76.746 E.00289
G1 X77.493 Y76.723 E.00348
G1 X90.551 Y76.722 E.27639
G1 X90.741 Y76.747 E.00405
G1 X90.883 Y76.794 E.00317
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.732 Y77.119 E.00552
G1 X77.421 Y77.276 E.00737
G1 X77.182 Y77.529 E.00737
G1 X77.052 Y77.807 E.0065
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00795
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.037 Y97.589 E.01819
G1 X87.209 Y97.833 E.00587
G1 X87.495 Y98.356 E.01174
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00428
G1 X87.751 Y100.637 E.01047
G1 X87.662 Y101.001 E.00737
G1 X87.475 Y101.488 E.01026
G1 X87.302 Y101.822 E.0074
G1 X87.139 Y102.072 E.00588
G1 X86.91 Y102.369 E.00737
G1 X86.595 Y102.695 E.00892
G1 X86.429 Y102.838 E.00431
G1 X86.059 Y103.105 E.00897
G1 X85.871 Y103.216 E.00431
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.605 Y103.411 E.00897
G1 X82.075 Y103.143 E.01167
G1 X81.642 Y102.839 E.0104
G1 X81.311 Y102.536 E.00882
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.422 E.00882
G1 X80.387 Y100.923 E.01041
G1 X80.302 Y100.558 E.00737
G1 X80.271 Y100.341 E.00431
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.567 E.00885
G1 X80.671 Y98.155 E.00888
G1 X80.82 Y97.897 E.00586
G1 X81.033 Y97.588 E.00737
G1 X81.639 Y96.891 E.01818
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X76.911 Y96.729 E.00676
G1 X76.652 Y96.54 E.00631
G1 X76.516 Y96.39 E.00399
G1 X76.417 Y96.245 E.00345
G1 X76.352 Y96.114 E.00286
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.599 Y76.714 E.00454
G1 X76.704 Y76.615 E.00283
G1 X76.892 Y76.483 E.00452
G1 X77.047 Y76.408 E.00339
G1 X77.237 Y76.347 E.00393
G1 X77.463 Y76.313 E.00449
G1 X90.579 Y76.313 E.25797
G1 X90.833 Y76.347 E.00505
G1 X91.045 Y76.417 E.0044
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.006
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.019 Y77.491 E.27127
G1 X77.856 Y77.515 E.00325
G1 X77.669 Y77.609 E.00413
G1 X77.525 Y77.762 E.00413
G1 X77.448 Y77.925 E.00356
G1 X77.425 Y78.086 E.00318
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.037 Y97.589 E-.16847
G1 X87.209 Y97.833 E-.05666
G1 X87.495 Y98.356 E-.11341
G1 X87.572 Y98.56 E-.04146
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




G1 X86.174 Y97.797
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359562
G1 F1500
M204 S6000
G1 X86.494 Y98.191 E.00846
G1 X86.702 Y98.528 E.00659
G1 X86.9 Y99.026 E.00892
G1 X86.985 Y99.38 E.00607
G1 X87.031 Y99.915 E.00894
G1 X86.988 Y100.409 E.00825
G1 X86.904 Y100.777 E.00629
G1 X86.759 Y101.156 E.00675
G1 X86.518 Y101.576 E.00808
G1 X86.179 Y101.993 E.00894
G1 X85.935 Y102.217 E.00552
G1 X85.493 Y102.516 E.00888
G1 X85.006 Y102.738 E.00891
G1 X84.654 Y102.835 E.00609
G1 X84.292 Y102.885 E.00608
G1 X83.768 Y102.884 E.00872
G1 X83.255 Y102.792 E.00868
G1 X82.748 Y102.61 E.00896
G1 X82.382 Y102.4 E.00704
G1 X82.139 Y102.22 E.00503
G1 X81.881 Y101.985 E.00582
G1 X81.6 Y101.652 E.00726
G1 X81.346 Y101.226 E.00826
G1 X81.198 Y100.863 E.00652
G1 X81.11 Y100.546 E.00549
G1 X81.037 Y99.981 E.00949
G1 X81.059 Y99.536 E.00742
G1 X81.127 Y99.187 E.00593
G1 X81.228 Y98.846 E.00592
G1 X81.375 Y98.518 E.00599
G1 X81.513 Y98.287 E.00448
G1 X81.819 Y97.882 E.00845
G1 X82.076 Y97.611 E.00623
; LINE_WIDTH: 0.404399
G1 X82.203 Y97.491 E.0033
; LINE_WIDTH: 0.437987
G1 X82.316 Y97.386 E.00316
; LINE_WIDTH: 0.474845
G1 X82.584 Y97.168 E.00775
; WIPE_START
G1 X82.316 Y97.386 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.476 Y97.16 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.477987
G1 F1500
M204 S6000
G1 X85.799 Y97.429 E.0095
; LINE_WIDTH: 0.424057
G1 X85.913 Y97.533 E.00306
; LINE_WIDTH: 0.38223
G1 X86.174 Y97.797 E.0066
; WIPE_START
G1 X85.913 Y97.533 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.367 Y96.392 Z4.44 F18000
G1 X77.473 Y96.256 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.150436
G1 F1500
M204 S6000
G1 X77.245 Y96.121 E.00165
G1 X77.055 Y95.969 E.00151
G1 X76.882 Y95.627 E.00239
; WIPE_START
G1 X77.055 Y95.969 E-.16352
G1 X77.245 Y96.121 E-.10358
G1 X77.473 Y96.256 E-.1129
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.234 Y88.628 Z4.44 F18000
G1 X76.889 Y77.602 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.0994925
G1 F1500
M204 S6000
G1 X76.944 Y77.423 E.00069
; LINE_WIDTH: 0.146335
G1 X76.999 Y77.322 E.00069
G1 X77.147 Y77.151 E.00136
G1 X77.251 Y77.064 E.00082
G1 X77.39 Y77 E.00092
; LINE_WIDTH: 0.0986825
G1 X77.539 Y76.955 E.00057
; WIPE_START
G1 X77.39 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.979 Y80.853 Z4.44 F18000
G1 X92.905 Y86.071 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.965 Y86.071 E.02243
G1 X93.965 Y87.131 E.02243
G1 X92.905 Y87.131 E.02243
G1 X92.905 Y86.131 E.02116
M204 S10000
G1 X92.481 Y85.647 F18000
G1 F1500
M204 S500
G1 X94.389 Y85.647 E.04039
G1 X94.389 Y87.555 E.04039
G1 X92.481 Y87.555 E.04039
G1 X92.481 Y85.707 E.03912
M204 S250
G1 X92.071 Y85.238 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.798 Y85.238 E.05363
G1 X94.798 Y87.964 E.05363
G1 X92.071 Y87.964 E.05363
G1 X92.071 Y85.298 E.05245
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.071 Y85.254 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/49
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I-.891 J-.828 P1  F18000
G1 X83.578 Y96.544 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.05 Y96.544 E.03117
G1 X85.409 Y96.967 E.01174
G1 X85.285 Y97.13 E.00433
G1 X85.133 Y97.059 E.00355
G1 X84.639 Y96.915 E.01089
G1 X84.265 Y96.864 E.00798
G1 X83.929 Y96.858 E.00711
G1 X83.362 Y96.928 E.01209
G1 X82.8 Y97.11 E.01251
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X83.518 Y96.544 E.01
; WIPE_START
M204 S6000
G1 X85.05 Y96.544 E-.29117
G1 X85.353 Y96.901 E-.08883
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.417 Y100.971 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.289 Y101.237 E.00624
G1 X86.108 Y101.504 E.00683
G1 X85.895 Y101.747 E.00683
G1 X85.541 Y102.047 E.00983
G1 X85.105 Y102.292 E.01059
G1 X84.843 Y102.393 E.00595
G1 X84.532 Y102.474 E.00679
G1 X84.07 Y102.523 E.00983
G1 X83.572 Y102.48 E.01058
G1 X83.298 Y102.415 E.00595
G1 X82.996 Y102.307 E.00679
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.039 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.51 E.00975
G1 X81.551 Y99.063 E.00975
G1 X81.674 Y98.764 E.00684
G1 X81.831 Y98.482 E.00683
G1 X82.107 Y98.125 E.00955
G1 X82.34 Y97.902 E.00683
G1 X82.599 Y97.708 E.00683
G1 X83.004 Y97.49 E.00975
G1 X83.455 Y97.344 E.01002
G1 X83.951 Y97.282 E.01059
G1 X84.232 Y97.288 E.00595
G1 X84.551 Y97.331 E.0068
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.201 Y98.424 E.00995
G1 X86.43 Y98.835 E.00995
G1 X86.579 Y99.27 E.00975
G1 X86.636 Y99.588 E.00683
G1 X86.656 Y99.91 E.00683
G1 X86.614 Y100.369 E.00975
G1 X86.489 Y100.822 E.00995
G1 X86.443 Y100.917 E.00224
M204 S250
G1 X86.049 Y100.794 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.934 Y101.032 E.0052
G1 X85.783 Y101.253 E.00526
G1 X85.607 Y101.454 E.00526
G1 X85.306 Y101.71 E.00776
G1 X84.93 Y101.921 E.00849
G1 X84.717 Y102.003 E.00449
G1 X84.459 Y102.07 E.00525
G1 X84.067 Y102.112 E.00776
G1 X83.637 Y102.074 E.00848
G1 X83.414 Y102.022 E.00449
G1 X83.163 Y101.932 E.00525
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.86 E.00779
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00774
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00527
G1 X82.174 Y98.708 E.00526
M73 P82 R4
G1 X82.412 Y98.4 E.00767
G1 X82.606 Y98.215 E.00526
G1 X82.82 Y98.054 E.00526
G1 X83.166 Y97.868 E.00773
G1 X83.544 Y97.745 E.00782
G1 X83.972 Y97.692 E.00849
G1 X84.201 Y97.697 E.00449
G1 X84.465 Y97.733 E.00525
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00773
G1 X85.862 Y98.656 E.0078
G1 X86.054 Y99.002 E.00779
G1 X86.182 Y99.374 E.00773
G1 X86.229 Y99.637 E.00526
G1 X86.245 Y99.904 E.00526
G1 X86.21 Y100.296 E.00773
G1 X86.105 Y100.678 E.0078
G1 X86.075 Y100.74 E.00136
; WIPE_START
M204 S6000
G1 X85.934 Y101.032 E-.06162
G1 X85.783 Y101.253 E-.05083
G1 X85.607 Y101.454 E-.0508
G1 X85.306 Y101.71 E-.07496
G1 X84.93 Y101.921 E-.08197
G1 X84.717 Y102.003 E-.0434
G1 X84.634 Y102.025 E-.01642
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.303 Y96.12 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12074
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.553 Y96.482 E.10486
G1 X86.753 Y97.894 E.03922
G1 X87.036 Y98.344 E.01126
G1 X87.266 Y98.91 E.01293
G1 X87.389 Y99.49 E.01254
G1 X87.415 Y99.899 E.00869
G1 X87.41 Y100.078 E.00378
G1 X87.349 Y100.557 E.01024
G1 X87.21 Y101.061 E.01107
G1 X86.949 Y101.614 E.01293
G1 X86.599 Y102.103 E.01273
G1 X86.316 Y102.395 E.00859
G1 X86.121 Y102.559 E.00541
G1 X85.844 Y102.756 E.00719
G1 X85.483 Y102.955 E.00872
G1 X85.062 Y103.12 E.00957
G1 X84.734 Y103.208 E.00718
G1 X84.327 Y103.269 E.00872
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.762 Y103.032 E.00869
G1 X82.4 Y102.859 E.00849
G1 X82.061 Y102.644 E.00849
G1 X81.75 Y102.391 E.00849
G1 X81.471 Y102.103 E.00849
G1 X81.23 Y101.786 E.00842
G1 X80.995 Y101.374 E.01004
G1 X80.861 Y101.063 E.00717
G1 X80.708 Y100.493 E.0125
G1 X80.659 Y100.021 E.01004
G1 X80.679 Y99.499 E.01106
G1 X80.754 Y99.086 E.00889
G1 X80.947 Y98.526 E.01253
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.243 Y96.43 E.00703
G1 X77.104 Y96.365 E.00324
G1 X76.924 Y96.232 E.00474
G1 X76.771 Y96.037 E.00524
G1 X76.683 Y95.812 E.00512
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.805 Y77.11 E.00539
G1 X76.97 Y76.928 E.0052
G1 X77.178 Y76.797 E.0052
G1 X77.332 Y76.746 E.00343
G1 X77.493 Y76.723 E.00343
G1 X90.553 Y76.722 E.27643
G1 X90.741 Y76.747 E.00402
G1 X90.883 Y76.794 E.00317
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.133 E.00621
G1 X77.414 Y77.282 E.00668
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.243 Y96.12 E.1541
; WIPE_START
M204 S6000
G1 X87.243 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.438 Y96.891 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.079 Y97.647 E.01951
G1 X87.291 Y97.962 E.00746
G1 X87.495 Y98.356 E.00874
G1 X87.656 Y98.783 E.00897
G1 X87.715 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00428
G1 X87.752 Y100.632 E.01037
G1 X87.662 Y101.001 E.00746
G1 X87.592 Y101.209 E.00431
G1 X87.409 Y101.627 E.00897
G1 X87.184 Y102.009 E.00873
G1 X86.91 Y102.37 E.00891
G1 X86.596 Y102.694 E.00888
G1 X86.371 Y102.883 E.00577
G1 X86.062 Y103.103 E.00746
G1 X85.665 Y103.322 E.00892
G1 X85.463 Y103.411 E.00434
G1 X85.184 Y103.511 E.00583
G1 X84.818 Y103.609 E.00746
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.821 Y102.977 E.00885
G1 X81.473 Y102.693 E.00885
G1 X81.16 Y102.37 E.00885
G1 X80.888 Y102.013 E.00883
G1 X80.628 Y101.557 E.01031
G1 X80.408 Y101.001 E.01176
G1 X80.303 Y100.562 E.00889
G1 X80.249 Y100.04 E.01031
G1 X80.252 Y99.661 E.00746
G1 X80.273 Y99.443 E.00431
G1 X80.355 Y98.994 E.00897
G1 X80.414 Y98.783 E.00431
G1 X80.573 Y98.359 E.00891
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X77.097 Y96.814 E.00277
G1 X76.893 Y96.719 E.00442
G1 X76.647 Y96.536 E.00602
G1 X76.515 Y96.389 E.0039
G1 X76.417 Y96.244 E.00342
G1 X76.352 Y96.114 E.00286
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.459 Y76.89 E.00454
G1 X76.545 Y76.774 E.00283
G1 X76.706 Y76.613 E.00448
G1 X76.893 Y76.483 E.00448
G1 X77.021 Y76.418 E.00283
G1 X77.237 Y76.346 E.00448
G1 X77.463 Y76.313 E.00448
G1 X90.58 Y76.313 E.25801
G1 X90.833 Y76.347 E.00502
G1 X91.045 Y76.417 E.0044
G1 X91.24 Y76.522 E.00436
G1 X91.473 Y76.718 E.00598
G1 X91.623 Y76.912 E.00482
G1 X91.747 Y77.162 E.00549
G1 X91.804 Y77.375 E.00433
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.498 Y96.891 E.07922
; WIPE_START
M204 S6000
G1 X87.079 Y97.647 E-.18126
G1 X87.291 Y97.962 E-.07206
G1 X87.495 Y98.356 E-.08442
G1 X87.574 Y98.564 E-.04226
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




G1 X86.162 Y97.784
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359713
G1 F1500
M204 S6000
G1 X86.447 Y98.123 E.00737
G1 X86.694 Y98.521 E.00781
G1 X86.777 Y98.696 E.00322
G1 X86.944 Y99.188 E.00866
G1 X87.012 Y99.536 E.00591
G1 X87.027 Y100.054 E.00863
G1 X86.976 Y100.486 E.00725
G1 X86.849 Y100.941 E.00788
G1 X86.622 Y101.421 E.00885
G1 X86.398 Y101.741 E.0065
G1 X86.151 Y102.024 E.00626
G1 X85.743 Y102.365 E.00886
G1 X85.317 Y102.611 E.00821
G1 X84.947 Y102.758 E.00663
G1 X84.612 Y102.843 E.00576
G1 X84.058 Y102.9 E.00927
G1 X83.524 Y102.854 E.00893
G1 X83.184 Y102.771 E.00584
G1 X82.831 Y102.647 E.00622
G1 X82.586 Y102.522 E.00459
G1 X82.284 Y102.334 E.00593
G1 X81.952 Y102.058 E.00719
G1 X81.6 Y101.651 E.00896
G1 X81.334 Y101.207 E.00863
G1 X81.168 Y100.779 E.00766
G1 X81.084 Y100.429 E.006
G1 X81.037 Y99.988 E.00738
G1 X81.058 Y99.546 E.00737
G1 X81.128 Y99.177 E.00626
G1 X81.297 Y98.679 E.00876
G1 X81.46 Y98.365 E.0059
G1 X81.662 Y98.073 E.00593
G1 X82.078 Y97.609 E.01037
; LINE_WIDTH: 0.407529
G1 X82.223 Y97.473 E.00378
; LINE_WIDTH: 0.447048
G1 X82.352 Y97.353 E.00371
; LINE_WIDTH: 0.479817
G1 X82.583 Y97.167 E.00672
; WIPE_START
G1 X82.352 Y97.353 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.516 Y97.178 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.468186
G1 F1500
M204 S6000
G1 X85.787 Y97.411 E.00791
; LINE_WIDTH: 0.423264
G1 X85.986 Y97.608 E.00556
; LINE_WIDTH: 0.379844
G1 X86.162 Y97.784 E.00439
; WIPE_START
G1 X85.986 Y97.608 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.448 Y96.411 Z4.56 F18000
G1 X77.459 Y96.254 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.14713
G1 F1500
M204 S6000
G1 X77.248 Y96.124 E.0015
G1 X77.053 Y95.956 E.00156
G1 X76.982 Y95.848 E.00078
G1 X76.882 Y95.627 E.00147
; WIPE_START
G1 X76.982 Y95.848 E-.10529
G1 X77.053 Y95.956 E-.05561
G1 X77.248 Y96.124 E-.11154
G1 X77.459 Y96.254 E-.10756
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.226 Y88.626 Z4.56 F18000
G1 X76.889 Y77.601 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.0995607
G1 F1500
M204 S6000
G1 X76.96 Y77.387 E.00083
; LINE_WIDTH: 0.149702
G1 X77.042 Y77.265 E.00091
G1 X77.154 Y77.145 E.00102
G1 X77.24 Y77.071 E.0007
G1 X77.393 Y76.999 E.00104
; LINE_WIDTH: 0.0998273
G1 X77.528 Y76.954 E.00053
; WIPE_START
G1 X77.393 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.973 Y80.866 Z4.56 F18000
G1 X93.012 Y86.178 Z4.56
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.858 Y86.178 E.01791
G1 X93.858 Y87.024 E.01791
G1 X93.012 Y87.024 E.01791
G1 X93.012 Y86.238 E.01664
M204 S10000
G1 X92.587 Y85.753 F18000
G1 F1500
M204 S500
G1 X94.282 Y85.753 E.03587
G1 X94.282 Y87.448 E.03587
G1 X92.587 Y87.448 E.03587
G1 X92.587 Y85.813 E.0346
M204 S250
G1 X92.178 Y85.344 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.691 Y85.344 E.04944
G1 X94.691 Y87.858 E.04944
G1 X92.178 Y87.858 E.04944
G1 X92.178 Y85.404 E.04826
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.178 Y85.356 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 35/49
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I-.969 J-.736 P1  F18000
G1 X85.254 Y97.115 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.01089
G1 X84.265 Y96.864 E.00799
G1 X83.926 Y96.858 E.00717
G1 X83.362 Y96.928 E.01204
G1 X82.8 Y97.11 E.01249
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04187
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02986
G1 X84.639 Y96.915 E-.09778
G1 X84.265 Y96.864 E-.07173
G1 X83.926 Y96.858 E-.06436
G1 X83.362 Y96.928 E-.10808
G1 X83.321 Y96.941 E-.00819
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.423 Y100.968 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.36 Y101.108 E.00325
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00975
G1 X85.551 Y102.039 E.00975
G1 X85.276 Y102.208 E.00684
G1 X84.984 Y102.344 E.00683
M73 P83 R4
G1 X84.541 Y102.473 E.00975
G1 X84.074 Y102.522 E.00995
G1 X83.615 Y102.488 E.00975
G1 X83.3 Y102.416 E.00683
G1 X82.996 Y102.307 E.00683
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.911 Y101.439 E.01002
G1 X81.661 Y101.009 E.01053
G1 X81.555 Y100.746 E.00601
G1 X81.469 Y100.437 E.00679
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.551 Y99.063 E.00975
G1 X81.674 Y98.764 E.00683
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.454 Y97.344 E.00982
G1 X83.948 Y97.282 E.01054
G1 X84.232 Y97.288 E.00601
G1 X84.551 Y97.331 E.0068
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.895 Y98.055 E.00955
G1 X86.108 Y98.298 E.00683
G1 X86.289 Y98.564 E.00683
G1 X86.489 Y98.98 E.00976
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.492 Y100.813 E.00975
G1 X86.447 Y100.913 E.00232
M204 S250
G1 X86.049 Y100.802 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00253
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.452 E.00773
G1 X85.31 Y101.707 E.00773
G1 X85.082 Y101.847 E.00526
G1 X84.839 Y101.96 E.00526
G1 X84.462 Y102.07 E.00773
G1 X84.068 Y102.111 E.0078
G1 X83.676 Y102.082 E.00773
G1 X83.415 Y102.023 E.00526
G1 X83.163 Y101.932 E.00526
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.245 Y101.199 E.00782
G1 X82.029 Y100.829 E.00844
G1 X81.943 Y100.615 E.00455
G1 X81.872 Y100.357 E.00525
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00526
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00774
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00775
G1 X83.97 Y97.692 E.00844
G1 X84.2 Y97.697 E.00454
G1 X84.465 Y97.733 E.00525
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.607 Y98.347 E.00767
G1 X85.783 Y98.549 E.00526
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00774
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.105 Y100.675 E.00773
G1 X86.073 Y100.747 E.00155
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.03587
G1 X85.859 Y101.149 E-.05082
G1 X85.61 Y101.452 E-.0747
G1 X85.31 Y101.707 E-.07468
G1 X85.082 Y101.847 E-.05086
G1 X84.839 Y101.96 E-.05085
G1 X84.626 Y102.022 E-.04222
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.992 E.00386
G1 X87.04 Y98.353 E.00888
G1 X87.266 Y98.91 E.01273
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.078 E.01246
G1 X87.35 Y100.553 E.01014
G1 X87.208 Y101.066 E.01126
G1 X87.107 Y101.306 E.00551
G1 X86.947 Y101.616 E.00739
G1 X86.6 Y102.102 E.01263
G1 X86.316 Y102.395 E.00864
G1 X86.124 Y102.556 E.00531
G1 X85.678 Y102.855 E.01137
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00868
G1 X84.327 Y103.269 E.00869
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.753 Y103.029 E.00888
G1 X82.227 Y102.757 E.01254
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.94 Y101.259 E.00842
G1 X80.783 Y100.816 E.00995
G1 X80.678 Y100.3 E.01115
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.00849
G1 X80.943 Y98.534 E.01254
G1 X81.132 Y98.17 E.00869
G1 X81.358 Y97.838 E.0085
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00344
G1 X76.824 Y96.119 E.00343
G1 X76.713 Y95.912 E.00497
G1 X76.684 Y95.818 E.00209
G1 X76.654 Y95.565 E.00539
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00578
G1 X76.795 Y77.125 E.0052
G1 X76.979 Y76.92 E.00582
G1 X77.094 Y76.841 E.00296
G1 X77.234 Y76.775 E.00328
G1 X77.484 Y76.723 E.00539
G1 X90.554 Y76.722 E.27665
G1 X90.74 Y76.747 E.00398
G1 X90.883 Y76.794 E.00317
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00951
G1 X77.971 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.4 Y98.159 E.00897
G1 X87.496 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.715 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00428
G1 X87.753 Y100.628 E.01028
G1 X87.661 Y101.001 E.00755
G1 X87.479 Y101.48 E.01008
G1 X87.301 Y101.822 E.00758
G1 X87.144 Y102.065 E.00569
G1 X86.91 Y102.369 E.00755
G1 X86.596 Y102.694 E.0089
G1 X86.375 Y102.88 E.00567
G1 X86.059 Y103.105 E.00762
G1 X85.871 Y103.216 E.00431
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.605 Y103.411 E.00898
G1 X82.405 Y103.322 E.0043
G1 X82.008 Y103.103 E.00891
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.421 E.00882
G1 X80.39 Y100.932 E.01022
G1 X80.302 Y100.558 E.00755
G1 X80.271 Y100.341 E.00431
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.564 E.00891
G1 X80.571 Y98.362 E.0043
G1 X80.78 Y97.96 E.00891
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.369 E.00448
G1 X76.419 Y96.248 E.00284
G1 X76.331 Y96.061 E.00406
G1 X76.282 Y95.903 E.00326
G1 X76.245 Y95.589 E.00623
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.598 Y76.715 E.00452
G1 X76.722 Y76.6 E.00332
G1 X76.89 Y76.485 E.004
G1 X77.094 Y76.389 E.00443
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.582 Y76.313 E.2581
G1 X90.833 Y76.347 E.00499
G1 X91.045 Y76.417 E.0044
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.718 E.00598
G1 X91.623 Y76.91 E.00479
G1 X91.747 Y77.162 E.00552
G1 X91.804 Y77.375 E.00433
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00362
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.1688
G1 X87.167 Y97.767 E-.04155
G1 X87.4 Y98.159 E-.08669
G1 X87.496 Y98.356 E-.04162
G1 X87.572 Y98.56 E-.04135
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




G1 X86.153 Y97.775
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38022
G1 F1500
M204 S6000
G1 X85.981 Y97.605 E.00429
; LINE_WIDTH: 0.419764
G1 X85.783 Y97.411 E.00545
; LINE_WIDTH: 0.468115
G1 X85.484 Y97.162 E.00858
M204 S10000
G1 X86.153 Y97.775 F18000
; LINE_WIDTH: 0.359596
G1 F1500
M204 S6000
G1 X86.417 Y98.077 E.00668
G1 X86.7 Y98.532 E.00892
G1 X86.844 Y98.862 E.006
G1 X86.979 Y99.352 E.00846
G1 X87.008 Y99.536 E.00311
G1 X87.027 Y100.054 E.00862
G1 X86.976 Y100.484 E.00721
G1 X86.841 Y100.951 E.0081
G1 X86.691 Y101.291 E.00618
G1 X86.493 Y101.61 E.00625
G1 X86.16 Y102.015 E.00874
G1 X85.782 Y102.335 E.00825
G1 X85.464 Y102.537 E.00626
G1 X85.005 Y102.736 E.00834
G1 X84.6 Y102.846 E.007
G1 X84.065 Y102.896 E.00895
G1 X83.768 Y102.884 E.00495
G1 X83.254 Y102.796 E.00869
G1 X82.832 Y102.646 E.00746
G1 X82.395 Y102.412 E.00826
G1 X81.974 Y102.078 E.00896
G1 X81.648 Y101.716 E.00811
G1 X81.453 Y101.418 E.00593
G1 X81.29 Y101.108 E.00583
G1 X81.15 Y100.711 E.00702
G1 X81.061 Y100.256 E.00772
G1 X81.037 Y99.891 E.0061
G1 X81.072 Y99.439 E.00755
G1 X81.126 Y99.187 E.00431
G1 X81.232 Y98.837 E.00608
G1 X81.461 Y98.363 E.00876
G1 X81.662 Y98.073 E.00589
G1 X82.021 Y97.673 E.00893
; LINE_WIDTH: 0.400629
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438413
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477118
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.149198
G1 F1500
M204 S6000
G1 X77.247 Y96.123 E.00163
G1 X77.125 Y96.033 E.00093
G1 X77.043 Y95.954 E.0007
G1 X76.966 Y95.816 E.00098
; LINE_WIDTH: 0.125232
G1 X76.931 Y95.719 E.00051
; LINE_WIDTH: 0.0938705
M73 P83 R3
G1 X76.896 Y95.622 E.00035
; WIPE_START
G1 X76.931 Y95.719 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.913 Y88.086 Z4.68 F18000
G1 X76.889 Y77.601 Z4.68
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.103539
G1 F1500
M204 S6000
G1 X76.959 Y77.387 E.00087
; LINE_WIDTH: 0.156362
G1 X77.109 Y77.19 E.00161
G1 X77.232 Y77.078 E.00108
; LINE_WIDTH: 0.129127
G1 X77.427 Y76.991 E.0011
; LINE_WIDTH: 0.0897794
G1 X77.531 Y76.955 E.00035
; WIPE_START
G1 X77.427 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.995 Y80.881 Z4.68 F18000
G1 X93.118 Y86.284 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.751 Y86.284 E.0134
G1 X93.751 Y86.917 E.0134
G1 X93.118 Y86.917 E.0134
G1 X93.118 Y86.344 E.01213
M204 S10000
G1 X92.694 Y85.86 F18000
G1 F1500
M204 S500
G1 X94.176 Y85.86 E.03136
G1 X94.176 Y87.342 E.03136
G1 X92.694 Y87.342 E.03136
G1 X92.694 Y85.92 E.03009
M204 S250
G1 X92.285 Y85.451 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.585 Y85.451 E.04524
G1 X94.585 Y87.751 E.04524
G1 X92.285 Y87.751 E.04524
G1 X92.285 Y85.511 E.04406
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X94.284 Y85.459 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/49
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I-.962 J-.745 P1  F18000
G1 X85.254 Y97.115 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P84 R3
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.01089
G1 X84.265 Y96.864 E.00799
G1 X83.923 Y96.858 E.00723
G1 X83.361 Y96.928 E.01198
G1 X82.8 Y97.11 E.01249
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02988
G1 X84.639 Y96.915 E-.09778
G1 X84.265 Y96.864 E-.07174
G1 X83.923 Y96.858 E-.06494
G1 X83.361 Y96.928 E-.10756
G1 X83.321 Y96.941 E-.0081
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.409 Y101.005 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.201 Y101.378 E.00904
G1 X85.902 Y101.741 E.00994
G1 X85.541 Y102.047 E.01001
G1 X85.11 Y102.29 E.01048
G1 X84.843 Y102.393 E.00606
G1 X84.532 Y102.474 E.0068
G1 X84.071 Y102.523 E.00982
G1 X83.578 Y102.481 E.01048
G1 X83.299 Y102.416 E.00606
G1 X82.996 Y102.307 E.0068
G1 X82.59 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00976
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.455 Y97.809 E.00956
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.454 Y97.344 E.00981
G1 X83.946 Y97.282 E.01048
G1 X84.232 Y97.288 E.00607
G1 X84.551 Y97.331 E.0068
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.895 Y98.055 E.00956
G1 X86.108 Y98.298 E.00683
G1 X86.289 Y98.565 E.00683
G1 X86.489 Y98.98 E.00975
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00683
G1 X86.434 Y100.951 E.00628
M204 S250
G1 X86.051 Y100.806 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.861 Y101.146 E.00767
G1 X85.61 Y101.452 E.00779
G1 X85.307 Y101.709 E.00782
G1 X84.935 Y101.919 E.00839
G1 X84.717 Y102.003 E.00459
G1 X84.459 Y102.07 E.00525
G1 X84.067 Y102.112 E.00776
G1 X83.642 Y102.075 E.00839
G1 X83.414 Y102.022 E.00459
G1 X83.163 Y101.932 E.00525
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.00779
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.863 E.00774
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.00779
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.706 Y98.134 E.00767
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00775
G1 X83.967 Y97.692 E.00839
G1 X84.2 Y97.697 E.00459
G1 X84.465 Y97.733 E.00525
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.607 Y98.347 E.00767
G1 X85.783 Y98.549 E.00526
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00773
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.073 Y100.75 E.00415
; WIPE_START
M204 S6000
G1 X85.861 Y101.146 E-.08542
G1 X85.61 Y101.452 E-.07528
G1 X85.307 Y101.709 E-.07551
G1 X84.935 Y101.919 E-.08106
G1 X84.717 Y102.003 E-.04434
G1 X84.624 Y102.028 E-.0184
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.715 Y97.842 E.03816
G1 X87.039 Y98.352 E.01278
G1 X87.263 Y98.901 E.01257
G1 X87.389 Y99.48 E.01254
G1 X87.415 Y99.899 E.00888
G1 X87.41 Y100.078 E.00379
G1 X87.35 Y100.549 E.01004
G1 X87.208 Y101.066 E.01136
G1 X87.109 Y101.302 E.00542
G1 X86.945 Y101.62 E.00757
G1 X86.599 Y102.103 E.01257
G1 X86.316 Y102.395 E.0086
G1 X86.128 Y102.554 E.00522
G1 X85.678 Y102.855 E.01146
G1 X85.303 Y103.034 E.0088
G1 X85.071 Y103.117 E.00522
G1 X84.734 Y103.208 E.00738
G1 X84.326 Y103.269 E.00872
G1 X83.734 Y103.267 E.01254
G1 X83.146 Y103.162 E.01264
G1 X82.58 Y102.951 E.01278
G1 X82.227 Y102.757 E.00853
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.94 Y101.259 E.00842
G1 X80.784 Y100.821 E.00985
G1 X80.678 Y100.3 E.01125
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.00849
G1 X80.87 Y98.715 E.00842
G1 X81.064 Y98.292 E.00985
G1 X81.352 Y97.845 E.01126
G1 X82.538 Y96.482 E.03824
G1 X77.571 Y96.482 E.10513
G1 X77.323 Y96.453 E.00527
G1 X77.178 Y96.405 E.00324
G1 X76.963 Y96.269 E.00539
G1 X76.835 Y96.133 E.00394
G1 X76.755 Y96.003 E.00324
G1 X76.682 Y95.803 E.0045
G1 X76.654 Y95.565 E.00508
G1 X76.654 Y77.619 E.37984
G1 X76.694 Y77.343 E.0059
G1 X76.8 Y77.12 E.00523
G1 X76.978 Y76.921 E.00564
G1 X77.094 Y76.841 E.00299
G1 X77.239 Y76.773 E.0034
G1 X77.491 Y76.723 E.00542
G1 X90.556 Y76.722 E.27653
G1 X90.74 Y76.747 E.00394
G1 X90.876 Y76.792 E.00303
G1 X91.052 Y76.892 E.00429
G1 X91.002 Y77.082 E.00415
G1 X77.981 Y77.082 E.2756
G1 X77.692 Y77.132 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.589 E.0182
G1 X87.201 Y97.821 E.00558
G1 X87.4 Y98.158 E.00771
G1 X87.495 Y98.356 E.00432
G1 X87.655 Y98.78 E.00891
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.109 E.00428
G1 X87.753 Y100.623 E.01019
G1 X87.662 Y101.001 E.00764
G1 X87.481 Y101.475 E.00999
G1 X87.184 Y102.009 E.01201
G1 X86.91 Y102.37 E.00892
G1 X86.596 Y102.694 E.00888
G1 X86.378 Y102.877 E.00559
G1 X86.059 Y103.105 E.00771
G1 X85.871 Y103.216 E.00431
G1 X85.46 Y103.412 E.00894
G1 X85.193 Y103.508 E.00559
G1 X84.817 Y103.609 E.00765
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.035 Y103.557 E.00434
G1 X82.762 Y103.469 E.00565
G1 X82.402 Y103.321 E.00765
G1 X82.008 Y103.103 E.00886
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.564 Y101.421 E.00883
G1 X80.391 Y100.936 E.01013
G1 X80.302 Y100.558 E.00765
G1 X80.271 Y100.341 E.00431
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.487 Y98.568 E.00883
G1 X80.702 Y98.1 E.01013
G1 X80.902 Y97.768 E.00764
G1 X81.031 Y97.59 E.00432
G1 X81.639 Y96.891 E.01822
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.893 Y96.719 E.00283
G1 X76.704 Y96.587 E.00454
G1 X76.597 Y96.486 E.00289
G1 X76.502 Y96.373 E.00289
G1 X76.384 Y96.182 E.00442
G1 X76.281 Y95.898 E.00595
G1 X76.245 Y95.589 E.00613
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.229 E.00452
G1 X76.359 Y77.073 E.00329
G1 X76.457 Y76.893 E.00403
G1 X76.598 Y76.715 E.00447
G1 X76.721 Y76.601 E.00329
G1 X76.89 Y76.485 E.00403
G1 X77.096 Y76.389 E.00447
G1 X77.256 Y76.342 E.00329
G1 X77.462 Y76.313 E.00409
G1 X90.584 Y76.313 E.25809
G1 X90.833 Y76.347 E.00495
G1 X91.043 Y76.416 E.00435
G1 X91.289 Y76.556 E.00556
G1 X91.473 Y76.717 E.00482
G1 X91.61 Y76.89 E.00434
G1 X91.747 Y77.163 E.006
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00362
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.589 E-.16855
G1 X87.201 Y97.821 E-.05395
G1 X87.4 Y98.158 E-.07443
G1 X87.495 Y98.356 E-.0417
G1 X87.572 Y98.56 E-.04137
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




G1 X86.153 Y97.775
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380255
G1 F1500
M204 S6000
G1 X85.981 Y97.605 E.00429
; LINE_WIDTH: 0.419809
G1 X85.783 Y97.411 E.00545
; LINE_WIDTH: 0.468138
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.153 Y97.775 F18000
; LINE_WIDTH: 0.359825
G1 F1500
M204 S6000
G1 X86.413 Y98.073 E.00659
G1 X86.699 Y98.53 E.00898
G1 X86.896 Y99.015 E.00872
G1 X86.985 Y99.38 E.00627
G1 X87.031 Y99.915 E.00895
G1 X86.989 Y100.409 E.00826
G1 X86.904 Y100.778 E.00631
G1 X86.774 Y101.123 E.00615
G1 X86.518 Y101.576 E.00868
G1 X86.306 Y101.854 E.00582
G1 X86.054 Y102.114 E.00603
G1 X85.743 Y102.362 E.00664
G1 X85.282 Y102.626 E.00884
G1 X84.957 Y102.755 E.00583
G1 X84.587 Y102.848 E.00636
G1 X84.059 Y102.896 E.00884
G1 X83.768 Y102.883 E.00485
G1 X83.248 Y102.795 E.0088
G1 X82.832 Y102.645 E.00736
G1 X82.395 Y102.412 E.00826
G1 X81.974 Y102.078 E.00896
G1 X81.648 Y101.716 E.00812
G1 X81.453 Y101.418 E.00593
G1 X81.291 Y101.108 E.00584
G1 X81.151 Y100.715 E.00694
G1 X81.061 Y100.256 E.0078
G1 X81.037 Y99.891 E.0061
G1 X81.072 Y99.439 E.00755
G1 X81.202 Y98.918 E.00896
G1 X81.398 Y98.471 E.00814
G1 X81.654 Y98.078 E.00781
G1 X82.025 Y97.669 E.00921
; LINE_WIDTH: 0.401022
G1 X82.195 Y97.496 E.00453
; LINE_WIDTH: 0.438422
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477112
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.42 Y96.244 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.148141
G1 F1500
M204 S6000
G1 X77.059 Y95.969 E.00277
G1 X76.882 Y95.627 E.00236
; WIPE_START
G1 X77.059 Y95.969 E-.17452
G1 X77.42 Y96.244 E-.20548
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.203 Y88.615 Z4.8 F18000
G1 X76.889 Y77.601 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.0977031
G1 F1500
M204 S6000
G1 X76.961 Y77.388 E.00081
; LINE_WIDTH: 0.122906
G1 X76.967 Y77.374 E.00008
; LINE_WIDTH: 0.155783
G1 X77.11 Y77.189 E.00151
G1 X77.232 Y77.078 E.00107
; LINE_WIDTH: 0.129787
G1 X77.43 Y76.989 E.00113
; LINE_WIDTH: 0.0924315
G1 X77.53 Y76.954 E.00035
; WIPE_START
G1 X77.43 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.053 Y80.782 Z4.8 F18000
G1 X92.391 Y85.558 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.478 Y85.558 E.04104
G1 X94.478 Y87.644 E.04104
G1 X92.391 Y87.644 E.04104
G1 X92.391 Y85.618 E.03986
; WIPE_START
M204 S6000
G1 X94.391 Y85.56 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.261 Y86.575 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X93.409 Y87.427 E.02371
G1 X92.851 Y87.427
G1 X94.261 Y86.017 E.03922
G1 X93.947 Y85.774
M73 P85 R3
G1 X92.608 Y87.113 E.03723
G1 X92.608 Y86.555
G1 X93.389 Y85.774 E.02172
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X92.608 Y86.555 E-.20986
G1 X92.608 Y87.113 E-.10593
G1 X92.847 Y86.874 E-.06421
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/49
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I-.977 J-.726 P1  F18000
G1 X85.245 Y97.112 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.153 Y97.065 E.00218
G1 X84.639 Y96.915 E.01133
G1 X84.265 Y96.864 E.00799
G1 X83.92 Y96.858 E.00729
G1 X83.361 Y96.928 E.01193
G1 X82.8 Y97.11 E.01248
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.374 Y96.947 E.01129
G1 X85.282 Y97.065 E.00318
; WIPE_START
M204 S6000
G1 X85.153 Y97.065 E-.02448
G1 X84.639 Y96.915 E-.10173
G1 X84.265 Y96.864 E-.07177
G1 X83.92 Y96.858 E-.06545
G1 X83.361 Y96.928 E-.10706
G1 X83.314 Y96.944 E-.0095
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.41 Y100.986 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.289 Y101.237 E.00589
G1 X86.108 Y101.504 E.00683
G1 X85.895 Y101.747 E.00683
G1 X85.542 Y102.047 E.00981
G1 X85.113 Y102.289 E.01043
G1 X84.843 Y102.393 E.00612
G1 X84.532 Y102.474 E.0068
G1 X84.071 Y102.523 E.00981
G1 X83.58 Y102.481 E.01043
G1 X83.299 Y102.416 E.00612
G1 X82.996 Y102.307 E.0068
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.039 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.51 E.00975
G1 X81.554 Y99.054 E.00994
G1 X81.741 Y98.633 E.00976
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00684
G1 X82.455 Y97.809 E.00955
G1 X82.724 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.454 Y97.344 E.00981
G1 X83.943 Y97.282 E.01043
G1 X84.232 Y97.288 E.00612
G1 X84.55 Y97.331 E.0068
G1 X84.995 Y97.461 E.00981
G1 X85.434 Y97.686 E.01043
G1 X85.67 Y97.853 E.00612
G1 X85.908 Y98.068 E.0068
G1 X86.201 Y98.424 E.00975
G1 X86.43 Y98.835 E.00995
G1 X86.579 Y99.27 E.00975
G1 X86.636 Y99.588 E.00683
G1 X86.656 Y99.91 E.00683
G1 X86.614 Y100.369 E.00975
G1 X86.489 Y100.822 E.00995
G1 X86.436 Y100.932 E.00259
M204 S250
G1 X86.041 Y100.809 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.934 Y101.032 E.00487
G1 X85.783 Y101.253 E.00526
G1 X85.607 Y101.455 E.00526
G1 X85.307 Y101.709 E.00775
G1 X84.937 Y101.918 E.00834
G1 X84.717 Y102.003 E.00464
G1 X84.459 Y102.07 E.00525
G1 X84.067 Y102.112 E.00776
G1 X83.644 Y102.076 E.00834
G1 X83.414 Y102.022 E.00464
G1 X83.163 Y101.932 E.00525
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.86 E.00779
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00773
G1 X81.943 Y99.186 E.00779
G1 X82.103 Y98.827 E.00774
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.706 Y98.134 E.00767
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00775
G1 X83.965 Y97.692 E.00835
G1 X84.2 Y97.697 E.00464
G1 X84.465 Y97.733 E.00525
G1 X84.843 Y97.843 E.00775
G1 X85.221 Y98.036 E.00834
G1 X85.413 Y98.173 E.00464
G1 X85.612 Y98.352 E.00525
G1 X85.861 Y98.656 E.00773
G1 X86.054 Y99.002 E.0078
G1 X86.182 Y99.374 E.00773
G1 X86.229 Y99.637 E.00526
G1 X86.245 Y99.904 E.00526
G1 X86.21 Y100.296 E.00773
G1 X86.105 Y100.678 E.0078
G1 X86.068 Y100.755 E.00168
; WIPE_START
M204 S6000
G1 X85.934 Y101.032 E-.05846
G1 X85.783 Y101.253 E-.05085
G1 X85.607 Y101.455 E-.05082
G1 X85.307 Y101.709 E-.07489
G1 X84.937 Y101.918 E-.08059
G1 X84.717 Y102.003 E-.04483
G1 X84.618 Y102.029 E-.01956
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X87.04 Y98.353 E.01273
G1 X87.214 Y98.756 E.00929
G1 X87.317 Y99.094 E.00748
G1 X87.389 Y99.49 E.00852
G1 X87.415 Y99.899 E.00869
G1 X87.41 Y100.078 E.00379
G1 X87.351 Y100.545 E.00995
G1 X87.21 Y101.061 E.01134
G1 X86.951 Y101.61 E.01285
G1 X86.6 Y102.102 E.01278
G1 X86.316 Y102.395 E.00864
G1 X86.131 Y102.551 E.00512
G1 X85.678 Y102.855 E.01155
G1 X85.307 Y103.032 E.0087
G1 X84.919 Y103.164 E.00868
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.142 Y103.161 E.01273
G1 X82.579 Y102.951 E.01273
G1 X82.227 Y102.757 E.0085
G1 X81.902 Y102.522 E.00849
G1 X81.606 Y102.251 E.0085
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.00849
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.753 Y99.095 E.00869
G1 X80.871 Y98.712 E.00849
G1 X81.038 Y98.337 E.00869
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.241 Y96.43 E.00707
G1 X77.12 Y96.374 E.00282
G1 X76.924 Y96.231 E.00512
G1 X76.773 Y96.041 E.00515
G1 X76.683 Y95.812 E.0052
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.622 E.37977
G1 X76.693 Y77.351 E.0058
G1 X76.805 Y77.111 E.00561
G1 X76.894 Y76.999 E.00302
G1 X77.01 Y76.896 E.00328
G1 X77.231 Y76.775 E.00533
G1 X77.491 Y76.723 E.00561
G1 X90.557 Y76.722 E.27656
G1 X90.74 Y76.747 E.0039
G1 X90.883 Y76.794 E.00318
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.99 Y77.082 E.2756
G1 X77.731 Y77.12 E.00552
G1 X77.429 Y77.271 E.00716
G1 X77.205 Y77.495 E.00669
G1 X77.053 Y77.797 E.00717
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00835
G1 X85.214 Y96.12 E.15349
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.00431
G1 X87.401 Y98.159 E.00897
G1 X87.496 Y98.358 E.00434
G1 X87.6 Y98.62 E.00555
G1 X87.715 Y98.997 E.00774
G1 X87.796 Y99.44 E.00886
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00428
G1 X87.754 Y100.619 E.0101
G1 X87.661 Y101.001 E.00773
G1 X87.592 Y101.209 E.00431
G1 X87.409 Y101.627 E.00897
G1 X87.15 Y102.057 E.00989
G1 X86.91 Y102.37 E.00774
G1 X86.596 Y102.694 E.00889
G1 X86.382 Y102.874 E.00549
G1 X86.059 Y103.105 E.0078
G1 X85.871 Y103.216 E.0043
G1 X85.462 Y103.412 E.00892
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.034 Y103.556 E.00436
G1 X82.822 Y103.491 E.00437
G1 X82.402 Y103.321 E.00891
G1 X82.008 Y103.103 E.00885
G1 X81.643 Y102.84 E.00885
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.561 E.00885
G1 X80.251 Y100.113 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.567 E.00885
G1 X80.672 Y98.153 E.00891
G1 X80.778 Y97.962 E.0043
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X76.911 Y96.729 E.00676
G1 X76.647 Y96.536 E.00643
G1 X76.499 Y96.368 E.0044
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.608 E.35366
G1 X76.257 Y77.434 E.00344
G1 X76.299 Y77.232 E.00406
G1 X76.383 Y77.02 E.00447
G1 X76.468 Y76.878 E.00326
G1 X76.596 Y76.717 E.00406
G1 X76.765 Y76.567 E.00443
G1 X76.959 Y76.447 E.00448
G1 X77.093 Y76.389 E.00287
G1 X77.255 Y76.343 E.00332
G1 X77.462 Y76.313 E.00412
G1 X90.585 Y76.313 E.25812
G1 X90.833 Y76.347 E.00492
G1 X91.045 Y76.417 E.0044
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.006
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.019 Y77.491 E.27127
G1 X77.856 Y77.515 E.00325
G1 X77.671 Y77.607 E.00406
G1 X77.541 Y77.737 E.00362
G1 X77.449 Y77.922 E.00406
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.761 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16875
G1 X87.167 Y97.767 E-.04162
G1 X87.401 Y98.159 E-.08666
G1 X87.496 Y98.358 E-.04194
G1 X87.576 Y98.559 E-.04103
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




G1 X86.174 Y97.797
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382331
G1 F1500
M204 S6000
G1 X85.913 Y97.532 E.00662
; LINE_WIDTH: 0.425052
G1 X85.794 Y97.425 E.00318
; LINE_WIDTH: 0.47491
G1 X85.659 Y97.303 E.00409
G1 X85.308 Y97.376 E.00803
M204 S10000
G1 X86.174 Y97.797 F18000
; LINE_WIDTH: 0.359831
G1 F1500
M204 S6000
G1 X86.502 Y98.201 E.00868
G1 X86.701 Y98.533 E.00645
G1 X86.852 Y98.885 E.00638
G1 X86.948 Y99.183 E.00523
G1 X87.012 Y99.534 E.00594
G1 X87.027 Y100.054 E.00868
G1 X86.978 Y100.476 E.00707
G1 X86.834 Y100.967 E.00853
G1 X86.627 Y101.412 E.00819
G1 X86.398 Y101.741 E.00667
G1 X86.151 Y102.024 E.00626
G1 X85.768 Y102.345 E.00833
G1 X85.285 Y102.625 E.00931
G1 X84.95 Y102.755 E.00599
G1 X84.587 Y102.844 E.00622
G1 X84.29 Y102.886 E.005
G1 X84.06 Y102.896 E.00384
G1 X83.768 Y102.883 E.00486
G1 X83.243 Y102.793 E.00888
G1 X82.832 Y102.645 E.00727
G1 X82.395 Y102.412 E.00826
G1 X81.974 Y102.078 E.00896
G1 X81.648 Y101.716 E.00812
G1 X81.453 Y101.418 E.00593
G1 X81.289 Y101.103 E.00593
G1 X81.145 Y100.701 E.00711
G1 X81.082 Y100.423 E.00476
G1 X81.042 Y100.071 E.0059
G1 X81.058 Y99.545 E.00877
G1 X81.126 Y99.187 E.00609
G1 X81.228 Y98.848 E.00589
G1 X81.455 Y98.373 E.00877
G1 X81.66 Y98.071 E.00609
G1 X82.025 Y97.669 E.00905
; LINE_WIDTH: 0.40101
G1 X82.195 Y97.496 E.00453
; LINE_WIDTH: 0.438411
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477113
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.461 Y96.249 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.146258
G1 F1500
M204 S6000
G1 X77.26 Y96.132 E.0014
G1 X77.043 Y95.953 E.00169
G1 X76.882 Y95.626 E.00219
; WIPE_START
G1 X77.043 Y95.953 E-.15746
G1 X77.26 Y96.132 E-.12174
G1 X77.461 Y96.249 E-.1008
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.227 Y88.621 Z4.92 F18000
G1 X76.89 Y77.602 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.0900035
G1 F1500
M204 S6000
G1 X76.918 Y77.514 E.0003
; LINE_WIDTH: 0.115051
G1 X76.946 Y77.426 E.00041
; LINE_WIDTH: 0.151926
G1 X76.995 Y77.323 E.00072
G1 X77.103 Y77.195 E.00106
G1 X77.265 Y77.059 E.00133
; LINE_WIDTH: 0.12446
G1 X77.43 Y76.991 E.00088
; LINE_WIDTH: 0.0898117
G1 X77.539 Y76.955 E.00037
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.43 Y76.991 E-.38
; WIPE_END
M73 P86 R3
G1 E-.02 F1800
; layer num/total_layer_count: 38/49
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I-1.134 J.441 P1  F18000
G1 X85.245 Y97.112 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.153 Y97.065 E.0022
G1 X84.639 Y96.915 E.01132
G1 X84.264 Y96.864 E.008
G1 X83.917 Y96.858 E.00735
G1 X83.361 Y96.928 E.01187
G1 X82.8 Y97.11 E.01248
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.374 Y96.947 E.01129
G1 X85.282 Y97.065 E.00317
; WIPE_START
M204 S6000
G1 X85.153 Y97.065 E-.02458
G1 X84.639 Y96.915 E-.10165
G1 X84.264 Y96.864 E-.0718
G1 X83.917 Y96.858 E-.06597
G1 X83.361 Y96.928 E-.10656
G1 X83.314 Y96.944 E-.00944
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.404 Y100.996 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.272 Y101.264 E.00633
G1 X86.107 Y101.505 E.00617
G1 X85.895 Y101.747 E.0068
G1 X85.542 Y102.046 E.00981
G1 X85.115 Y102.288 E.01037
G1 X84.843 Y102.393 E.00617
G1 X84.532 Y102.474 E.0068
G1 X84.074 Y102.522 E.00975
G1 X83.603 Y102.487 E.01001
G1 X83.129 Y102.36 E.01037
G1 X82.862 Y102.244 E.00618
G1 X82.583 Y102.083 E.0068
G1 X82.223 Y101.796 E.00975
G1 X81.912 Y101.44 E.01
G1 X81.664 Y101.017 E.01038
G1 X81.555 Y100.747 E.00617
G1 X81.469 Y100.437 E.0068
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.519 E.00975
G1 X81.509 Y99.204 E.00683
G1 X81.613 Y98.898 E.00684
G1 X81.825 Y98.489 E.00975
G1 X82.113 Y98.118 E.00994
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.454 Y97.344 E.00981
G1 X83.94 Y97.282 E.01037
G1 X84.232 Y97.288 E.00618
G1 X84.55 Y97.331 E.00681
G1 X84.995 Y97.461 E.0098
G1 X85.432 Y97.684 E.01038
G1 X85.669 Y97.853 E.00617
G1 X85.91 Y98.07 E.00686
G1 X86.212 Y98.444 E.01018
G1 X86.361 Y98.695 E.00617
G1 X86.492 Y98.989 E.0068
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.489 Y100.825 E.01001
G1 X86.431 Y100.942 E.00278
M204 S250
G1 X86.037 Y100.816 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.918 Y101.057 E.00529
G1 X85.783 Y101.253 E.00469
G1 X85.607 Y101.455 E.00525
G1 X85.307 Y101.709 E.00775
G1 X84.94 Y101.917 E.0083
G1 X84.717 Y102.003 E.00469
G1 X84.459 Y102.07 E.00525
G1 X84.068 Y102.111 E.00774
G1 X83.672 Y102.082 E.00781
G1 X83.264 Y101.972 E.00829
G1 X83.046 Y101.878 E.00469
G1 X82.814 Y101.744 E.00525
G1 X82.507 Y101.499 E.00773
G1 X82.246 Y101.2 E.00781
G1 X82.032 Y100.836 E.0083
G1 X81.943 Y100.615 E.00469
G1 X81.872 Y100.357 E.00525
G1 X81.825 Y99.967 E.00773
G1 X81.848 Y99.574 E.00774
G1 X81.904 Y99.313 E.00526
G1 X81.991 Y99.06 E.00527
G1 X82.172 Y98.711 E.00773
G1 X82.414 Y98.397 E.00779
G1 X82.706 Y98.134 E.00774
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.544 Y97.745 E.00775
G1 X83.962 Y97.692 E.0083
G1 X84.2 Y97.697 E.00469
G1 X84.465 Y97.733 E.00525
G1 X84.843 Y97.843 E.00775
G1 X85.219 Y98.035 E.0083
G1 X85.413 Y98.173 E.00469
G1 X85.612 Y98.352 E.00527
G1 X85.875 Y98.678 E.00823
G1 X85.997 Y98.883 E.00469
G1 X86.105 Y99.127 E.00525
G1 X86.21 Y99.506 E.00774
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.104 Y100.679 E.00781
G1 X86.063 Y100.762 E.00182
; WIPE_START
M204 S6000
G1 X85.918 Y101.057 E-.06254
G1 X85.783 Y101.253 E-.0453
G1 X85.607 Y101.455 E-.05073
G1 X85.307 Y101.709 E-.07488
G1 X84.94 Y101.917 E-.08014
G1 X84.717 Y102.003 E-.04529
G1 X84.61 Y102.031 E-.02113
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X87.04 Y98.353 E.01273
G1 X87.212 Y98.751 E.00919
G1 X87.317 Y99.094 E.00758
G1 X87.389 Y99.49 E.00852
G1 X87.415 Y99.896 E.00861
G1 X87.362 Y100.494 E.01271
G1 X87.206 Y101.069 E.01261
G1 X86.954 Y101.606 E.01256
G1 X86.605 Y102.096 E.01273
G1 X86.168 Y102.523 E.01293
G1 X85.67 Y102.859 E.01273
G1 X85.302 Y103.034 E.00862
G1 X85.079 Y103.114 E.00502
G1 X84.733 Y103.208 E.00758
G1 X84.327 Y103.269 E.00871
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01253
G1 X82.762 Y103.032 E.00869
G1 X82.4 Y102.859 E.00849
G1 X82.061 Y102.644 E.00849
G1 X81.75 Y102.391 E.00849
G1 X81.471 Y102.103 E.00849
G1 X81.224 Y101.779 E.00862
G1 X80.939 Y101.257 E.01258
G1 X80.8 Y100.879 E.00852
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01253
G1 X80.753 Y99.095 E.00869
G1 X80.874 Y98.703 E.00869
G1 X81.132 Y98.17 E.01253
G1 X81.358 Y97.838 E.0085
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.241 Y96.43 E.00707
G1 X77.118 Y96.373 E.00286
G1 X76.924 Y96.231 E.0051
G1 X76.773 Y96.041 E.00514
G1 X76.683 Y95.812 E.0052
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00596
G1 X76.804 Y77.113 E.00533
G1 X76.969 Y76.929 E.00523
G1 X77.193 Y76.791 E.00557
G1 X77.331 Y76.746 E.00306
G1 X77.493 Y76.723 E.00347
G1 X90.559 Y76.722 E.27656
G1 X90.74 Y76.747 E.00387
G1 X90.883 Y76.794 E.00318
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.133 E.0062
G1 X77.414 Y77.282 E.00669
G1 X77.181 Y77.529 E.00717
G1 X77.052 Y77.807 E.00648
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.452 E.00639
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.214 Y96.12 E.15348
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01823
G1 X87.167 Y97.767 E.00431
G1 X87.4 Y98.159 E.00897
G1 X87.496 Y98.358 E.00435
G1 X87.599 Y98.616 E.00546
G1 X87.715 Y98.997 E.00783
G1 X87.796 Y99.44 E.00886
G1 X87.824 Y99.891 E.00889
G1 X87.814 Y100.165 E.0054
G1 X87.766 Y100.562 E.00787
G1 X87.707 Y100.831 E.00541
G1 X87.591 Y101.211 E.00783
G1 X87.409 Y101.627 E.00892
G1 X87.304 Y101.818 E.0043
G1 X87.05 Y102.197 E.00897
G1 X86.912 Y102.368 E.0043
G1 X86.595 Y102.695 E.00897
G1 X86.251 Y102.975 E.00872
G1 X85.868 Y103.218 E.00891
G1 X85.46 Y103.412 E.00889
G1 X85.202 Y103.505 E.0054
G1 X84.817 Y103.609 E.00783
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.821 Y102.977 E.00885
G1 X81.473 Y102.693 E.00885
G1 X81.16 Y102.37 E.00885
G1 X80.886 Y102.01 E.00889
G1 X80.743 Y101.776 E.0054
G1 X80.563 Y101.421 E.00783
G1 X80.407 Y100.998 E.00886
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.564 E.00891
G1 X80.571 Y98.362 E.0043
G1 X80.78 Y97.96 E.00891
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X76.91 Y96.728 E.00679
G1 X76.647 Y96.536 E.0064
G1 X76.499 Y96.368 E.0044
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.459 Y76.891 E.00452
G1 X76.558 Y76.76 E.00322
G1 X76.706 Y76.614 E.0041
G1 X76.892 Y76.483 E.00447
G1 X77.039 Y76.411 E.00322
G1 X77.237 Y76.347 E.00409
G1 X77.463 Y76.313 E.00449
G1 X90.587 Y76.313 E.25814
G1 X90.833 Y76.347 E.00489
G1 X91.045 Y76.417 E.0044
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.524 Y77.762 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.31 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.304 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16879
G1 X87.167 Y97.767 E-.04159
G1 X87.4 Y98.159 E-.08665
G1 X87.496 Y98.358 E-.04199
G1 X87.576 Y98.558 E-.04098
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




G1 X86.176 Y97.8
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360593
G1 F1500
M204 S6000
G1 X86.413 Y98.08 E.00612
G1 X86.704 Y98.532 E.00898
G1 X86.855 Y98.879 E.00633
G1 X86.982 Y99.351 E.00817
G1 X87.036 Y99.9 E.00922
G1 X87.023 Y100.102 E.00338
G1 X86.984 Y100.451 E.00586
G1 X86.836 Y100.973 E.00907
G1 X86.698 Y101.271 E.00548
G1 X86.415 Y101.726 E.00895
G1 X86.048 Y102.12 E.009
G1 X85.768 Y102.344 E.00599
G1 X85.287 Y102.624 E.00928
G1 X84.965 Y102.752 E.00579
G1 X84.587 Y102.848 E.00651
G1 X84.065 Y102.896 E.00876
G1 X83.555 Y102.857 E.00855
G1 X83.253 Y102.792 E.00516
G1 X82.906 Y102.678 E.0061
G1 X82.585 Y102.524 E.00594
G1 X82.381 Y102.401 E.00398
G1 X82.007 Y102.11 E.00791
G1 X81.762 Y101.852 E.00594
G1 X81.54 Y101.562 E.0061
G1 X81.289 Y101.105 E.00872
G1 X81.165 Y100.769 E.00598
G1 X81.102 Y100.522 E.00427
G1 X81.042 Y100.071 E.00759
G1 X81.058 Y99.546 E.00879
G1 X81.123 Y99.186 E.00611
G1 X81.231 Y98.837 E.0061
G1 X81.461 Y98.363 E.00879
G1 X81.663 Y98.072 E.00591
G1 X82.021 Y97.673 E.00896
; LINE_WIDTH: 0.400616
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438413
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477117
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.309 Y97.375 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.473243
G1 F1500
M204 S6000
G1 X85.659 Y97.303 E.00797
G1 X85.793 Y97.424 E.00404
; LINE_WIDTH: 0.425269
G1 X85.912 Y97.532 E.00321
; LINE_WIDTH: 0.382107
G1 X86.176 Y97.8 E.00668
; WIPE_START
G1 X85.912 Y97.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.366 Y96.387 Z5.04 F18000
G1 X77.461 Y96.249 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.146278
G1 F1500
M204 S6000
G1 X77.259 Y96.131 E.00141
G1 X77.043 Y95.953 E.00168
G1 X76.882 Y95.626 E.00219
; WIPE_START
G1 X77.043 Y95.953 E-.15746
G1 X77.259 Y96.131 E-.12119
G1 X77.461 Y96.249 E-.10134
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.227 Y88.621 Z5.04 F18000
G1 X76.889 Y77.601 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.0995031
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00083
; LINE_WIDTH: 0.149649
G1 X77.153 Y77.146 E.00191
G1 X77.24 Y77.071 E.00071
G1 X77.391 Y77 E.00104
; LINE_WIDTH: 0.100158
G1 X77.529 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M73 P87 R3
G1 X77.391 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/49
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I-1.133 J.443 P1  F18000
G1 X85.254 Y97.115 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.01089
G1 X84.264 Y96.864 E.00801
G1 X83.914 Y96.858 E.00741
G1 X83.36 Y96.928 E.01182
G1 X82.869 Y97.088 E.01093
G1 X82.763 Y96.922 E.00416
G1 X83.112 Y96.544 E.01089
G1 X85.024 Y96.544 E.04046
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02986
G1 X84.639 Y96.915 E-.09778
G1 X84.264 Y96.864 E-.07187
G1 X83.914 Y96.858 E-.06648
G1 X83.36 Y96.928 E-.1061
G1 X83.321 Y96.941 E-.0079
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.402 Y101.001 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.274 Y101.262 E.00616
G1 X86.107 Y101.505 E.00623
G1 X85.895 Y101.747 E.00681
G1 X85.542 Y102.046 E.00981
G1 X85.118 Y102.287 E.01032
G1 X84.843 Y102.393 E.00623
G1 X84.532 Y102.474 E.00681
G1 X84.083 Y102.521 E.00955
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00683
G1 X83.004 Y102.312 E.00975
G1 X82.591 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.912 Y101.44 E.01
G1 X81.665 Y101.019 E.01032
G1 X81.555 Y100.747 E.00623
G1 X81.469 Y100.437 E.00681
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.508 E.01
G1 X81.562 Y99.035 E.01032
G1 X81.674 Y98.763 E.00623
G1 X81.831 Y98.482 E.00681
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.454 Y97.344 E.0098
G1 X83.937 Y97.283 E.01032
G1 X84.232 Y97.288 E.00623
G1 X84.551 Y97.331 E.00681
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.904 Y98.063 E.0098
G1 X86.211 Y98.442 E.01032
G1 X86.361 Y98.695 E.00623
G1 X86.492 Y98.989 E.00681
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.489 Y100.824 E.01
G1 X86.428 Y100.947 E.00289
M204 S250
G1 X86.035 Y100.82 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.919 Y101.055 E.00514
G1 X85.783 Y101.253 E.00473
G1 X85.607 Y101.455 E.00526
G1 X85.307 Y101.709 E.00775
G1 X84.942 Y101.916 E.00825
G1 X84.717 Y102.003 E.00474
G1 X84.459 Y102.07 E.00525
G1 X84.071 Y102.111 E.00767
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.00779
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00781
G1 X82.033 Y100.838 E.00825
G1 X81.943 Y100.615 E.00474
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.00781
G1 X81.951 Y99.164 E.00825
G1 X82.043 Y98.942 E.00474
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00775
G1 X83.96 Y97.692 E.00825
G1 X84.2 Y97.697 E.00474
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.35 E.00775
G1 X85.874 Y98.676 E.00825
G1 X85.997 Y98.883 E.00474
G1 X86.105 Y99.127 E.00525
G1 X86.21 Y99.506 E.00774
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.104 Y100.679 E.00781
G1 X86.061 Y100.767 E.00193
; WIPE_START
M204 S6000
G1 X85.919 Y101.055 E-.06104
G1 X85.783 Y101.253 E-.04574
G1 X85.607 Y101.455 E-.05077
G1 X85.307 Y101.709 E-.07489
G1 X84.942 Y101.916 E-.07966
G1 X84.717 Y102.003 E-.04577
G1 X84.605 Y102.033 E-.02215
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.712 Y97.838 E.03805
G1 X87.034 Y98.342 E.01267
G1 X87.137 Y98.561 E.00511
G1 X87.266 Y98.909 E.00786
G1 X87.389 Y99.49 E.01256
G1 X87.415 Y99.899 E.00869
G1 X87.41 Y100.079 E.0038
G1 X87.353 Y100.536 E.00975
G1 X87.21 Y101.061 E.01153
G1 X87.041 Y101.446 E.00888
G1 X86.725 Y101.947 E.01254
G1 X86.323 Y102.389 E.01266
G1 X86.138 Y102.546 E.00512
G1 X85.678 Y102.855 E.01173
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.327 Y103.269 E.00868
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01253
G1 X82.762 Y103.032 E.00869
G1 X82.403 Y102.86 E.00843
G1 X82.023 Y102.615 E.00956
G1 X81.612 Y102.258 E.01152
G1 X81.345 Y101.947 E.00869
G1 X81.121 Y101.613 E.00849
G1 X80.94 Y101.258 E.00843
G1 X80.787 Y100.833 E.00956
G1 X80.678 Y100.3 E.01153
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.0085
G1 X80.871 Y98.712 E.00849
G1 X81.033 Y98.347 E.00844
G1 X81.268 Y97.962 E.00955
G1 X81.49 Y97.676 E.00766
G1 X82.593 Y96.482 E.03441
G1 X77.571 Y96.482 E.10629
G1 X77.243 Y96.43 E.00703
G1 X77.016 Y96.311 E.00543
G1 X76.913 Y96.22 E.00289
G1 X76.764 Y96.022 E.00525
G1 X76.683 Y95.812 E.00477
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.974 Y76.924 E.0057
G1 X77.094 Y76.841 E.00309
G1 X77.24 Y76.773 E.0034
G1 X77.491 Y76.723 E.00542
G1 X90.56 Y76.722 E.27662
G1 X90.74 Y76.747 E.00383
G1 X90.883 Y76.794 E.00319
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.981 Y77.082 E.27579
G1 X77.692 Y77.132 E.0062
G1 X77.416 Y77.282 E.00665
G1 X77.187 Y77.521 E.00701
G1 X77.052 Y77.804 E.00663
G1 X77.016 Y78.056 E.00538
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.00639
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.036 Y97.588 E.01816
G1 X87.291 Y97.962 E.00891
G1 X87.514 Y98.402 E.00971
G1 X87.656 Y98.783 E.00798
G1 X87.715 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.109 E.00429
G1 X87.756 Y100.61 E.00991
G1 X87.661 Y101.001 E.00792
G1 X87.592 Y101.209 E.00431
G1 X87.409 Y101.627 E.00897
G1 X87.304 Y101.818 E.0043
G1 X87.051 Y102.195 E.00891
G1 X86.756 Y102.538 E.00891
G1 X86.598 Y102.692 E.00434
G1 X86.39 Y102.869 E.00537
G1 X86.059 Y103.105 E.00798
G1 X85.871 Y103.216 E.00431
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.00431
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.203 Y103.218 E.00883
G1 X81.782 Y102.947 E.00985
G1 X81.47 Y102.691 E.00792
G1 X81.313 Y102.538 E.00431
G1 X81.018 Y102.195 E.00891
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.421 E.00883
G1 X80.394 Y100.95 E.00985
G1 X80.302 Y100.558 E.00792
G1 X80.271 Y100.341 E.00431
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.488 Y98.567 E.00885
G1 X80.67 Y98.157 E.00883
G1 X80.93 Y97.729 E.00985
G1 X81.177 Y97.411 E.00792
G1 X81.658 Y96.891 E.01393
G1 X77.547 Y96.891 E.08086
G1 X77.231 Y96.854 E.00625
G1 X77.097 Y96.814 E.00277
G1 X76.887 Y96.716 E.00454
G1 X76.612 Y96.5 E.00689
G1 X76.415 Y96.24 E.00643
G1 X76.352 Y96.114 E.00275
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.598 Y76.714 E.00452
G1 X76.717 Y76.604 E.00319
G1 X76.89 Y76.485 E.00413
G1 X77.096 Y76.389 E.00447
G1 X77.252 Y76.343 E.00319
G1 X77.462 Y76.313 E.00418
G1 X90.589 Y76.313 E.25818
G1 X90.833 Y76.347 E.00485
G1 X91.045 Y76.417 E.00441
G1 X91.24 Y76.522 E.00436
G1 X91.474 Y76.719 E.00601
G1 X91.61 Y76.89 E.0043
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.667 Y77.611 E.0036
G1 X77.528 Y77.756 E.00395
G1 X77.448 Y77.924 E.00366
G1 X77.425 Y78.086 E.0032
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.036 Y97.588 E-.16821
G1 X87.291 Y97.962 E-.08606
G1 X87.514 Y98.402 E-.09378
G1 X87.573 Y98.56 E-.03196
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




G1 X86.165 Y97.786
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378418
G1 F1500
M204 S6000
G1 X85.987 Y97.611 E.0044
; LINE_WIDTH: 0.419152
G1 X85.783 Y97.411 E.0056
; LINE_WIDTH: 0.468112
G1 X85.484 Y97.162 E.00858
M204 S10000
G1 X86.165 Y97.786 F18000
; LINE_WIDTH: 0.359245
G1 F1500
M204 S6000
G1 X86.405 Y98.071 E.0062
G1 X86.696 Y98.516 E.00885
G1 X86.9 Y99.025 E.00912
G1 X86.979 Y99.352 E.0056
G1 X87.008 Y99.536 E.0031
G1 X87.027 Y100.055 E.00864
G1 X86.98 Y100.467 E.0069
G1 X86.843 Y100.943 E.00823
G1 X86.697 Y101.273 E.006
G1 X86.422 Y101.716 E.00868
M73 P87 R2
G1 X86.15 Y102.023 E.00682
G1 X85.904 Y102.241 E.00547
G1 X85.494 Y102.516 E.00822
G1 X85.006 Y102.738 E.00892
G1 X84.654 Y102.835 E.00608
G1 X84.292 Y102.885 E.00608
G1 X83.768 Y102.888 E.00872
G1 X83.341 Y102.816 E.00719
G1 X82.905 Y102.679 E.00761
G1 X82.59 Y102.524 E.00585
G1 X82.251 Y102.307 E.0067
G1 X81.953 Y102.057 E.00647
G1 X81.648 Y101.716 E.00762
G1 X81.453 Y101.418 E.00592
G1 X81.29 Y101.107 E.00584
G1 X81.154 Y100.727 E.00671
G1 X81.061 Y100.256 E.00799
G1 X81.037 Y99.891 E.00609
G1 X81.068 Y99.465 E.0071
G1 X81.2 Y98.927 E.00921
G1 X81.371 Y98.525 E.00728
G1 X81.583 Y98.179 E.00674
; LINE_WIDTH: 0.373371
G1 X81.825 Y97.871 E.0068
G1 X82.199 Y97.5 E.00912
; LINE_WIDTH: 0.406699
G1 X82.22 Y97.481 E.00054
; LINE_WIDTH: 0.449143
G1 X82.463 Y97.274 E.00675
G1 X82.487 Y97.279 E.00051
; LINE_WIDTH: 0.434767
G1 X82.51 Y97.284 E.00049
; LINE_WIDTH: 0.396472
G1 X82.786 Y97.351 E.00524
; WIPE_START
G1 X82.51 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.472 Y96.256 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.148692
G1 F1500
M204 S6000
G1 X77.229 Y96.111 E.00174
G1 X77.061 Y95.967 E.00136
G1 X76.982 Y95.848 E.00087
G1 X76.882 Y95.627 E.00149
; WIPE_START
G1 X76.982 Y95.848 E-.10383
G1 X77.061 Y95.967 E-.0608
G1 X77.229 Y96.111 E-.09447
G1 X77.472 Y96.256 E-.1209
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.234 Y88.628 Z5.16 F18000
G1 X76.889 Y77.602 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.100258
G1 F1500
M204 S6000
G1 X76.945 Y77.423 E.0007
; LINE_WIDTH: 0.153324
G1 X76.999 Y77.321 E.00074
G1 X77.232 Y77.078 E.00214
; LINE_WIDTH: 0.129818
G1 X77.431 Y76.989 E.00113
; LINE_WIDTH: 0.092465
G1 X77.529 Y76.954 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
M73 P88 R2
G1 F1500
G1 X77.431 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/49
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I-1.134 J.441 P1  F18000
G1 X85.254 Y97.115 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.06 E.00282
G1 X84.639 Y96.915 E.0109
G1 X84.264 Y96.864 E.00801
G1 X83.911 Y96.858 E.00746
G1 X83.36 Y96.928 E.01177
G1 X82.8 Y97.11 E.01246
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.06 E-.02984
G1 X84.639 Y96.915 E-.09782
G1 X84.264 Y96.864 E-.07191
G1 X83.911 Y96.858 E-.067
G1 X83.36 Y96.928 E-.10562
G1 X83.321 Y96.941 E-.00782
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.398 Y101.024 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.201 Y101.378 E.00857
G1 X85.902 Y101.741 E.00995
G1 X85.542 Y102.046 E.01
G1 X85.12 Y102.286 E.01027
G1 X84.844 Y102.393 E.00628
G1 X84.532 Y102.474 E.00681
G1 X84.074 Y102.522 E.00975
G1 X83.603 Y102.487 E.01
G1 X83.134 Y102.362 E.01027
G1 X82.862 Y102.244 E.00628
G1 X82.583 Y102.083 E.00681
G1 X82.223 Y101.796 E.00975
G1 X81.914 Y101.442 E.00995
G1 X81.673 Y101.039 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.508 E.0098
G1 X81.561 Y99.037 E.01027
G1 X81.674 Y98.763 E.00628
G1 X81.831 Y98.482 E.00681
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.453 Y97.344 E.0098
G1 X83.935 Y97.283 E.01027
G1 X84.232 Y97.288 E.00629
G1 X84.551 Y97.331 E.00681
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.904 Y98.062 E.0098
G1 X86.209 Y98.439 E.01027
G1 X86.361 Y98.695 E.00628
G1 X86.492 Y98.989 E.00681
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00683
G1 X86.427 Y100.971 E.00673
M204 S250
G1 X86.041 Y100.825 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.862 Y101.146 E.00724
G1 X85.61 Y101.452 E.0078
G1 X85.307 Y101.709 E.00781
G1 X84.944 Y101.915 E.0082
G1 X84.717 Y102.003 E.00478
G1 X84.459 Y102.07 E.00525
G1 X84.068 Y102.111 E.00774
G1 X83.672 Y102.082 E.00781
G1 X83.269 Y101.974 E.0082
G1 X83.046 Y101.878 E.00478
G1 X82.814 Y101.744 E.00526
G1 X82.507 Y101.499 E.00773
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.86 E.0078
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00775
G1 X81.95 Y99.166 E.0082
G1 X82.043 Y98.941 E.00479
G1 X82.174 Y98.708 E.00525
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00774
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00775
G1 X83.957 Y97.692 E.0082
G1 X84.2 Y97.697 E.00478
G1 X84.465 Y97.733 E.00526
G1 X84.84 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.35 E.00775
G1 X85.873 Y98.674 E.0082
G1 X85.997 Y98.883 E.00478
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00774
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.553 E.00527
G1 X86.065 Y100.77 E.00457
; WIPE_START
M204 S6000
G1 X85.862 Y101.146 E-.0813
G1 X85.61 Y101.452 E-.07534
G1 X85.307 Y101.709 E-.07547
G1 X84.944 Y101.915 E-.0792
G1 X84.717 Y102.003 E-.04622
G1 X84.603 Y102.033 E-.02247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.992 E.00386
G1 X87.038 Y98.35 E.00882
G1 X87.266 Y98.909 E.01277
G1 X87.389 Y99.49 E.01256
G1 X87.41 Y100.079 E.01248
G1 X87.354 Y100.531 E.00965
G1 X87.207 Y101.07 E.01182
G1 X86.95 Y101.611 E.01268
G1 X86.698 Y101.98 E.00946
G1 X86.322 Y102.39 E.01176
G1 X86.141 Y102.543 E.00502
G1 X85.678 Y102.855 E.01183
G1 X85.302 Y103.034 E.00881
G1 X85.087 Y103.112 E.00483
G1 X84.733 Y103.208 E.00776
G1 X84.327 Y103.269 E.00871
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.762 Y103.032 E.00869
G1 X82.4 Y102.859 E.0085
G1 X82.061 Y102.644 E.00849
G1 X81.75 Y102.391 E.00849
G1 X81.471 Y102.103 E.00849
G1 X81.224 Y101.778 E.00862
G1 X80.939 Y101.257 E.01258
G1 X80.8 Y100.879 E.00852
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01254
G1 X80.753 Y99.095 E.00869
G1 X80.874 Y98.703 E.00869
G1 X81.132 Y98.17 E.01253
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.059 Y96.34 E.00626
G1 X76.932 Y96.24 E.00343
G1 X76.824 Y96.119 E.00343
G1 X76.731 Y95.957 E.00394
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.342 E.00591
G1 X76.8 Y77.119 E.00523
G1 X76.973 Y76.925 E.00551
G1 X77.094 Y76.841 E.00312
G1 X77.24 Y76.773 E.00341
G1 X77.491 Y76.723 E.00542
G1 X90.562 Y76.722 E.27665
G1 X90.739 Y76.747 E.00379
G1 X90.875 Y76.792 E.00303
G1 X91.051 Y76.892 E.00429
G1 X91.001 Y77.082 E.00414
G1 X77.982 Y77.082 E.27556
G1 X77.7 Y77.13 E.00606
G1 X77.424 Y77.276 E.00661
G1 X77.206 Y77.495 E.00653
G1 X77.053 Y77.797 E.00717
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.252 Y95.772 E.00781
G1 X77.586 Y96.033 E.00896
G1 X77.964 Y96.12 E.00821
G1 X85.214 Y96.12 E.15345
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.00431
G1 X87.4 Y98.158 E.00895
G1 X87.513 Y98.398 E.00522
G1 X87.656 Y98.783 E.00807
G1 X87.715 Y98.994 E.00432
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.11 E.00429
G1 X87.757 Y100.605 E.00982
G1 X87.661 Y101.001 E.00801
G1 X87.508 Y101.417 E.00873
G1 X87.302 Y101.82 E.0089
G1 X87.023 Y102.23 E.00976
G1 X86.756 Y102.538 E.00801
G1 X86.393 Y102.866 E.00963
G1 X86.059 Y103.105 E.00807
G1 X85.871 Y103.216 E.00432
G1 X85.46 Y103.412 E.00895
G1 X85.211 Y103.503 E.00521
G1 X84.817 Y103.609 E.00801
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.821 Y102.977 E.00885
G1 X81.473 Y102.693 E.00885
G1 X81.16 Y102.37 E.00885
G1 X80.886 Y102.01 E.00889
G1 X80.747 Y101.784 E.00521
G1 X80.563 Y101.421 E.00801
G1 X80.407 Y100.998 E.00886
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.488 Y98.564 E.00891
G1 X80.571 Y98.362 E.0043
G1 X80.78 Y97.96 E.00891
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.951 Y96.75 E.00601
G1 X76.829 Y96.68 E.00277
G1 X76.65 Y96.539 E.00448
G1 X76.499 Y96.368 E.00448
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.229 E.00453
G1 X76.356 Y77.079 E.00316
G1 X76.457 Y76.893 E.00416
G1 X76.598 Y76.714 E.00447
G1 X76.716 Y76.605 E.00316
G1 X76.89 Y76.485 E.00416
G1 X77.096 Y76.388 E.00447
G1 X77.25 Y76.344 E.00316
G1 X77.462 Y76.313 E.00422
G1 X90.59 Y76.313 E.25821
G1 X90.833 Y76.347 E.00482
G1 X91.043 Y76.416 E.00435
G1 X91.294 Y76.56 E.00569
G1 X91.473 Y76.717 E.00469
G1 X91.61 Y76.89 E.00435
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.017 Y77.491 E.27132
G1 X77.834 Y77.522 E.00366
G1 X77.67 Y77.609 E.00365
G1 X77.542 Y77.737 E.00357
G1 X77.449 Y77.922 E.00407
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.499 E.00427
G1 X77.767 Y95.654 E.00498
G1 X78.011 Y95.711 E.00493
G1 X91.817 Y95.711 E.27155
G1 X91.79 Y95.895 E.00367
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16877
G1 X87.167 Y97.767 E-.0416
G1 X87.4 Y98.158 E-.08647
G1 X87.513 Y98.398 E-.05038
G1 X87.573 Y98.56 E-.03278
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




G1 X86.164 Y97.786
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378475
G1 F1500
M204 S6000
G1 X85.986 Y97.61 E.0044
; LINE_WIDTH: 0.419203
G1 X85.783 Y97.411 E.00559
; LINE_WIDTH: 0.46814
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.164 Y97.786 F18000
; LINE_WIDTH: 0.360133
G1 F1500
M204 S6000
G1 X86.413 Y98.08 E.00642
G1 X86.701 Y98.527 E.00888
G1 X86.9 Y99.025 E.00894
G1 X86.985 Y99.38 E.0061
G1 X87.031 Y99.915 E.00896
G1 X86.989 Y100.409 E.00827
G1 X86.903 Y100.78 E.00635
G1 X86.788 Y101.092 E.00556
G1 X86.619 Y101.415 E.00608
G1 X86.395 Y101.744 E.00664
G1 X86.061 Y102.109 E.00825
G1 X85.744 Y102.361 E.00676
G1 X85.293 Y102.621 E.00868
G1 X84.969 Y102.751 E.00581
G1 X84.587 Y102.848 E.00657
G1 X84.065 Y102.896 E.00875
G1 X83.555 Y102.857 E.00853
G1 X83.253 Y102.792 E.00516
G1 X82.906 Y102.678 E.00609
G1 X82.585 Y102.524 E.00594
G1 X82.381 Y102.401 E.00397
G1 X82.007 Y102.11 E.0079
G1 X81.763 Y101.852 E.00593
G1 X81.54 Y101.562 E.0061
G1 X81.29 Y101.104 E.0087
G1 X81.151 Y100.725 E.00673
G1 X81.069 Y100.338 E.0066
G1 X81.039 Y99.988 E.00586
G1 X81.073 Y99.435 E.00924
G1 X81.231 Y98.837 E.01033
G1 X81.461 Y98.363 E.00878
G1 X81.662 Y98.073 E.0059
G1 X82.021 Y97.673 E.00895
; LINE_WIDTH: 0.400603
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438383
G1 X82.402 Y97.319 E.00562
; LINE_WIDTH: 0.477102
G1 X82.582 Y97.165 E.00534
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.467 Y96.246 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.124171
G1 F1500
M204 S6000
G1 X77.357 Y96.185 E.00062
; LINE_WIDTH: 0.149154
G1 X77.247 Y96.124 E.00077
G1 X77.043 Y95.953 E.00164
G1 X76.882 Y95.627 E.00224
; WIPE_START
G1 X77.043 Y95.953 E-.18292
G1 X77.247 Y96.124 E-.13386
G1 X77.357 Y96.185 E-.06322
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.165 Y88.555 Z5.28 F18000
G1 X76.889 Y77.604 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.0908916
G1 F1500
M204 S6000
G1 X76.932 Y77.48 E.00043
; LINE_WIDTH: 0.121357
G1 X76.976 Y77.356 E.00063
; LINE_WIDTH: 0.149063
G1 X77.155 Y77.144 E.00171
G1 X77.256 Y77.064 E.0008
G1 X77.394 Y76.999 E.00093
; LINE_WIDTH: 0.100141
G1 X77.532 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.394 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 41/49
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I-1.134 J.443 P1  F18000
M73 P89 R2
G1 X85.254 Y97.115 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.01089
G1 X84.264 Y96.864 E.00801
G1 X83.909 Y96.858 E.00752
G1 X83.36 Y96.929 E.01171
G1 X82.8 Y97.11 E.01245
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02987
G1 X84.639 Y96.915 E-.0978
G1 X84.264 Y96.864 E-.07192
G1 X83.909 Y96.858 E-.06752
G1 X83.36 Y96.929 E-.10514
G1 X83.321 Y96.941 E-.00776
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.398 Y101.01 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.276 Y101.258 E.00584
G1 X86.107 Y101.504 E.00634
G1 X85.901 Y101.74 E.00661
G1 X85.669 Y101.949 E.00661
G1 X85.425 Y102.122 E.00634
G1 X84.995 Y102.341 E.01022
G1 X84.541 Y102.473 E.00999
G1 X84.072 Y102.523 E.00999
G1 X83.591 Y102.483 E.01021
G1 X83.299 Y102.416 E.00634
G1 X82.996 Y102.307 E.00681
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.912 Y101.44 E.00999
G1 X81.668 Y101.024 E.01022
G1 X81.555 Y100.747 E.00634
G1 X81.469 Y100.437 E.00681
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.508 E.00999
G1 X81.56 Y99.04 E.01022
G1 X81.674 Y98.763 E.00634
G1 X81.831 Y98.482 E.00681
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.453 Y97.344 E.00979
G1 X83.932 Y97.283 E.01022
G1 X84.232 Y97.288 E.00634
G1 X84.551 Y97.331 E.00681
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00975
G1 X86.195 Y98.417 E.00975
G1 X86.361 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.489 Y100.824 E.00999
G1 X86.424 Y100.956 E.00311
M204 S250
G1 X86.03 Y100.83 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.922 Y101.051 E.00483
G1 X85.783 Y101.253 E.00483
G1 X85.609 Y101.452 E.0052
G1 X85.413 Y101.629 E.00519
G1 X85.213 Y101.771 E.00483
G1 X84.843 Y101.959 E.00815
G1 X84.462 Y102.07 E.00781
G1 X84.067 Y102.112 E.00781
G1 X83.654 Y102.078 E.00815
G1 X83.415 Y102.022 E.00483
G1 X83.163 Y101.932 E.00526
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00781
G1 X82.035 Y100.843 E.00815
G1 X81.943 Y100.615 E.00484
G1 X81.872 Y100.357 E.00525
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.00781
G1 X81.95 Y99.169 E.00815
G1 X82.043 Y98.942 E.00483
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00774
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00775
G1 X83.955 Y97.692 E.00815
G1 X84.2 Y97.697 E.00483
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00774
G1 X85.859 Y98.653 E.00773
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00774
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.104 Y100.678 E.00781
G1 X86.057 Y100.776 E.00214
; WIPE_START
M204 S6000
G1 X85.922 Y101.051 E-.0581
G1 X85.783 Y101.253 E-.04667
G1 X85.609 Y101.452 E-.05019
G1 X85.413 Y101.629 E-.05016
G1 X85.213 Y101.771 E-.0467
G1 X84.843 Y101.959 E-.07876
G1 X84.593 Y102.032 E-.04943
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.716 Y97.843 E.03818
G1 X87.039 Y98.352 E.01277
G1 X87.266 Y98.91 E.01275
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.079 E.01249
G1 X87.355 Y100.527 E.00955
G1 X87.207 Y101.068 E.01186
G1 X86.949 Y101.613 E.01277
G1 X86.605 Y102.096 E.01255
G1 X86.315 Y102.396 E.00882
G1 X86.145 Y102.54 E.00473
G1 X85.678 Y102.855 E.01192
G1 X85.307 Y103.032 E.00868
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.153 Y103.164 E.01249
G1 X82.727 Y103.016 E.00956
G1 X82.392 Y102.855 E.00785
G1 X81.902 Y102.522 E.01256
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.0085
G1 X81.121 Y101.613 E.00849
G1 X80.94 Y101.258 E.00845
G1 X80.79 Y100.842 E.00936
G1 X80.678 Y100.3 E.01172
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.00849
G1 X80.871 Y98.714 E.00845
G1 X81.053 Y98.311 E.00935
G1 X81.352 Y97.845 E.01172
G1 X82.538 Y96.482 E.03824
G1 X77.571 Y96.482 E.10513
G1 X77.241 Y96.43 E.00706
G1 X77.115 Y96.371 E.00295
G1 X76.925 Y96.232 E.005
G1 X76.773 Y96.041 E.00516
G1 X76.683 Y95.812 E.0052
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.621 E.37979
G1 X76.695 Y77.341 E.00599
G1 X76.801 Y77.118 E.00522
G1 X76.972 Y76.926 E.00546
G1 X77.094 Y76.841 E.00315
G1 X77.241 Y76.773 E.00341
G1 X77.492 Y76.723 E.00541
G1 X90.563 Y76.722 E.27668
G1 X90.739 Y76.747 E.00376
G1 X90.883 Y76.794 E.0032
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.982 Y77.082 E.27576
G1 X77.699 Y77.13 E.00608
G1 X77.415 Y77.281 E.0068
G1 X77.182 Y77.529 E.00721
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.616 Y96.047 E.00951
G1 X77.971 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.589 E.01821
G1 X87.189 Y97.801 E.00512
G1 X87.4 Y98.159 E.00817
G1 X87.495 Y98.356 E.00431
G1 X87.656 Y98.783 E.00897
G1 X87.715 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.11 E.00429
G1 X87.758 Y100.601 E.00973
G1 X87.661 Y101.001 E.0081
G1 X87.49 Y101.454 E.00953
G1 X87.302 Y101.821 E.00811
G1 X87.05 Y102.197 E.00891
G1 X86.912 Y102.368 E.00431
G1 X86.595 Y102.695 E.00895
G1 X86.397 Y102.863 E.00512
G1 X86.059 Y103.105 E.00816
G1 X85.871 Y103.216 E.00431
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.038 Y103.557 E.00429
G1 X82.57 Y103.395 E.00973
G1 X82.199 Y103.217 E.0081
G1 X82.011 Y103.105 E.00431
G1 X81.643 Y102.84 E.00891
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.421 E.00884
G1 X80.397 Y100.959 E.00967
G1 X80.302 Y100.558 E.00811
G1 X80.271 Y100.341 E.0043
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.487 Y98.568 E.00884
G1 X80.69 Y98.121 E.00966
G1 X80.903 Y97.767 E.0081
G1 X81.031 Y97.59 E.00431
G1 X81.639 Y96.891 E.01823
G1 X77.547 Y96.891 E.08049
G1 X77.231 Y96.854 E.00625
G1 X76.906 Y96.726 E.00689
G1 X76.647 Y96.536 E.0063
G1 X76.499 Y96.368 E.0044
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.608 E.35366
G1 X76.256 Y77.44 E.00331
G1 X76.3 Y77.229 E.00425
G1 X76.35 Y77.093 E.00284
G1 X76.458 Y76.893 E.00448
G1 X76.598 Y76.714 E.00447
G1 X76.715 Y76.606 E.00313
G1 X76.89 Y76.485 E.00419
G1 X77.096 Y76.388 E.00448
G1 X77.248 Y76.344 E.00312
G1 X77.462 Y76.313 E.00425
G1 X90.592 Y76.313 E.25825
G1 X90.833 Y76.347 E.00478
G1 X91.045 Y76.417 E.0044
G1 X91.241 Y76.522 E.00436
G1 X91.474 Y76.718 E.00599
G1 X91.617 Y76.902 E.00459
G1 X91.747 Y77.163 E.00572
G1 X91.804 Y77.375 E.00432
G1 X91.811 Y77.491 E.00229
G1 X78.017 Y77.491 E.27132
G1 X77.833 Y77.522 E.00367
G1 X77.667 Y77.611 E.0037
G1 X77.525 Y77.762 E.00408
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.5 E.00431
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.589 E-.16863
G1 X87.189 Y97.801 E-.04945
G1 X87.4 Y98.159 E-.0789
G1 X87.495 Y98.356 E-.04165
G1 X87.572 Y98.56 E-.04137
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




G1 X86.162 Y97.784
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359699
G1 F1500
M204 S6000
G1 X86.412 Y98.077 E.00641
G1 X86.703 Y98.529 E.00897
G1 X86.9 Y99.026 E.00891
G1 X86.979 Y99.352 E.00559
G1 X87.008 Y99.536 E.00311
G1 X87.027 Y100.056 E.00866
G1 X86.982 Y100.459 E.00676
G1 X86.835 Y100.971 E.00888
G1 X86.621 Y101.419 E.00827
G1 X86.417 Y101.724 E.00611
G1 X86.162 Y102.01 E.00638
G1 X85.898 Y102.251 E.00595
G1 X85.492 Y102.518 E.0081
G1 X85.119 Y102.697 E.00689
G1 X84.628 Y102.837 E.00851
G1 X84.29 Y102.886 E.00569
G1 X84.061 Y102.896 E.00381
G1 X83.545 Y102.855 E.00863
G1 X83.202 Y102.781 E.00584
G1 X82.831 Y102.647 E.00657
G1 X82.397 Y102.408 E.00826
G1 X81.974 Y102.078 E.00895
G1 X81.648 Y101.716 E.00811
G1 X81.453 Y101.418 E.00593
G1 X81.29 Y101.106 E.00587
G1 X81.156 Y100.735 E.00657
G1 X81.061 Y100.256 E.00814
G1 X81.037 Y99.891 E.00609
G1 X81.073 Y99.436 E.00761
G1 X81.205 Y98.91 E.00903
G1 X81.39 Y98.491 E.00764
G1 X81.656 Y98.08 E.00815
G1 X82.021 Y97.673 E.0091
; LINE_WIDTH: 0.400615
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.43839
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477095
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.484 Y97.162 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.468122
G1 F1500
M204 S6000
G1 X85.782 Y97.411 E.00857
; LINE_WIDTH: 0.419328
G1 X85.985 Y97.609 E.00557
; LINE_WIDTH: 0.378827
G1 X86.162 Y97.784 E.00438
; WIPE_START
G1 X85.985 Y97.609 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.447 Y96.411 Z5.4 F18000
G1 X77.472 Y96.256 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.149253
G1 F1500
M204 S6000
G1 X77.258 Y96.129 E.00154
G1 X77.058 Y95.971 E.00157
G1 X76.983 Y95.851 E.00087
G1 X76.882 Y95.627 E.00152
; WIPE_START
G1 X76.983 Y95.851 E-.10492
G1 X77.058 Y95.971 E-.06015
G1 X77.258 Y96.129 E-.10866
G1 X77.472 Y96.256 E-.10628
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.234 Y88.628 Z5.4 F18000
G1 X76.89 Y77.6 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.09968
G1 F1500
M204 S6000
G1 X76.96 Y77.387 E.00083
; LINE_WIDTH: 0.149138
G1 X77.154 Y77.145 E.00191
G1 X77.243 Y77.07 E.00072
G1 X77.392 Y76.999 E.00102
; LINE_WIDTH: 0.100326
G1 X77.531 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M73 P90 R2
G1 X77.392 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/49
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I-1.133 J.443 P1  F18000
G1 X85.254 Y97.115 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.01089
G1 X84.264 Y96.864 E.00802
G1 X83.906 Y96.858 E.00758
G1 X83.36 Y96.929 E.01165
G1 X82.8 Y97.11 E.01245
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02987
G1 X84.639 Y96.915 E-.0978
G1 X84.264 Y96.864 E-.07196
G1 X83.906 Y96.858 E-.06802
G1 X83.36 Y96.929 E-.10462
G1 X83.321 Y96.941 E-.00772
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.39 Y101.039 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.201 Y101.378 E.00821
G1 X85.902 Y101.741 E.00995
G1 X85.551 Y102.039 E.00975
G1 X85.276 Y102.208 E.00683
G1 X84.984 Y102.344 E.00683
G1 X84.541 Y102.473 E.00975
G1 X84.083 Y102.521 E.00975
G1 X83.761 Y102.507 E.00683
G1 X83.442 Y102.454 E.00683
G1 X83.004 Y102.312 E.00975
G1 X82.591 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.913 Y101.441 E.00999
G1 X81.669 Y101.027 E.01016
G1 X81.555 Y100.747 E.0064
G1 X81.469 Y100.437 E.00681
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.552 Y99.063 E.00975
G1 X81.674 Y98.764 E.00683
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.453 Y97.344 E.00979
G1 X83.929 Y97.283 E.01016
G1 X84.231 Y97.288 E.00639
G1 X84.55 Y97.331 E.00682
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.904 Y98.062 E.00979
G1 X86.207 Y98.435 E.01016
G1 X86.361 Y98.695 E.00639
G1 X86.492 Y98.989 E.00681
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.892 E.00975
G1 X86.636 Y100.214 E.00683
G1 X86.579 Y100.531 E.00683
G1 X86.43 Y100.967 E.00975
G1 X86.419 Y100.987 E.00047
M204 S250
G1 X86.032 Y100.84 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.861 Y101.146 E.0069
G1 X85.61 Y101.452 E.00779
G1 X85.31 Y101.707 E.00774
G1 X85.082 Y101.847 E.00526
G1 X84.839 Y101.96 E.00526
G1 X84.462 Y102.07 E.00773
G1 X84.071 Y102.111 E.00774
G1 X83.804 Y102.099 E.00526
G1 X83.54 Y102.055 E.00527
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.0078
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00781
G1 X82.036 Y100.845 E.00811
G1 X81.943 Y100.615 E.00488
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00526
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00775
G1 X83.952 Y97.692 E.0081
G1 X84.2 Y97.697 E.00488
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.35 E.00775
G1 X85.87 Y98.67 E.00811
G1 X85.997 Y98.883 E.00488
G1 X86.105 Y99.127 E.00525
G1 X86.21 Y99.506 E.00774
G1 X86.245 Y99.898 E.00773
G1 X86.229 Y100.165 E.00526
G1 X86.182 Y100.428 E.00526
G1 X86.059 Y100.786 E.00745
; WIPE_START
M204 S6000
G1 X85.861 Y101.146 E-.07805
G1 X85.61 Y101.452 E-.0753
G1 X85.31 Y101.707 E-.07473
G1 X85.082 Y101.847 E-.05083
G1 X84.839 Y101.96 E-.05082
G1 X84.585 Y102.034 E-.05027
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00344
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.712 Y97.838 E.03805
G1 X87.036 Y98.345 E.01273
G1 X87.266 Y98.91 E.01292
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.079 E.01249
G1 X87.356 Y100.523 E.00946
G1 X87.207 Y101.068 E.01195
G1 X86.949 Y101.613 E.01277
G1 X86.605 Y102.096 E.01256
G1 X86.175 Y102.517 E.01273
G1 X85.678 Y102.855 E.01273
G1 X85.301 Y103.035 E.00883
G1 X85.096 Y103.109 E.00463
G1 X84.733 Y103.208 E.00795
G1 X84.326 Y103.269 E.0087
G1 X83.734 Y103.267 E.01254
G1 X83.153 Y103.164 E.01249
G1 X82.731 Y103.018 E.00946
G1 X82.235 Y102.762 E.01181
G1 X81.902 Y102.522 E.00869
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.0085
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.662 Y99.68 E.00869
G1 X80.753 Y99.095 E.01254
G1 X80.871 Y98.714 E.00845
G1 X81.051 Y98.315 E.00926
G1 X81.352 Y97.845 E.01181
G1 X82.538 Y96.482 E.03824
G1 X77.571 Y96.482 E.10512
G1 X77.323 Y96.453 E.00527
G1 X77.178 Y96.405 E.00324
G1 X77.016 Y96.311 E.00397
G1 X76.91 Y96.217 E.00299
G1 X76.764 Y96.023 E.00515
G1 X76.683 Y95.812 E.00478
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.804 Y77.112 E.00535
G1 X76.969 Y76.929 E.00522
G1 X77.188 Y76.793 E.00545
G1 X77.331 Y76.746 E.00319
G1 X77.493 Y76.723 E.00345
G1 X90.565 Y76.722 E.27669
G1 X90.739 Y76.747 E.00372
G1 X90.883 Y76.794 E.0032
G1 X91.059 Y76.889 E.00424
G1 X91.01 Y77.082 E.0042
G1 X77.982 Y77.082 E.27576
G1 X77.698 Y77.131 E.00609
G1 X77.416 Y77.281 E.00676
G1 X77.185 Y77.524 E.00709
G1 X77.052 Y77.805 E.00659
G1 X77.016 Y78.056 E.00536
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00775
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.214 Y96.12 E.15348
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.036 Y97.588 E.01817
G1 X87.291 Y97.962 E.00891
G1 X87.496 Y98.356 E.00873
G1 X87.656 Y98.783 E.00897
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.11 E.00429
G1 X87.759 Y100.596 E.00963
G1 X87.661 Y101.001 E.00819
G1 X87.492 Y101.45 E.00944
G1 X87.302 Y101.821 E.00819
G1 X87.05 Y102.197 E.00892
G1 X86.912 Y102.368 E.00431
G1 X86.595 Y102.695 E.00897
G1 X86.429 Y102.838 E.00431
G1 X86.059 Y103.105 E.00897
G1 X85.871 Y103.216 E.0043
G1 X85.46 Y103.413 E.00896
G1 X85.219 Y103.5 E.00503
G1 X84.817 Y103.609 E.0082
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.038 Y103.557 E.00429
G1 X82.575 Y103.397 E.00964
G1 X82.199 Y103.216 E.0082
G1 X82.011 Y103.105 E.00431
G1 X81.643 Y102.84 E.00891
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.997 E.00891
G1 X80.487 Y98.568 E.00884
G1 X80.688 Y98.125 E.00957
G1 X80.903 Y97.767 E.00819
G1 X81.031 Y97.59 E.00431
G1 X81.639 Y96.891 E.01822
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.89 Y96.718 E.00289
G1 X76.767 Y96.637 E.0029
G1 X76.608 Y96.497 E.00416
G1 X76.415 Y96.24 E.00633
G1 X76.352 Y96.114 E.00276
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.459 Y76.89 E.00453
G1 X76.553 Y76.765 E.00309
G1 X76.706 Y76.614 E.00422
G1 X76.892 Y76.483 E.00447
G1 X77.033 Y76.413 E.00309
G1 X77.237 Y76.346 E.00423
G1 X77.463 Y76.313 E.00449
G1 X90.594 Y76.313 E.25827
G1 X90.833 Y76.347 E.00475
G1 X91.045 Y76.417 E.00441
G1 X91.241 Y76.522 E.00436
G1 X91.472 Y76.717 E.00594
G1 X91.653 Y76.959 E.00594
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.811 Y77.491 E.00229
G1 X78.017 Y77.491 E.27132
G1 X77.832 Y77.523 E.00368
G1 X77.667 Y77.611 E.00369
G1 X77.527 Y77.758 E.00399
G1 X77.448 Y77.925 E.00363
G1 X77.425 Y78.086 E.0032
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.036 Y97.588 E-.16822
G1 X87.291 Y97.962 E-.08607
G1 X87.496 Y98.356 E-.08433
G1 X87.572 Y98.56 E-.04139
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




G1 X86.164 Y97.786
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378551
G1 F1500
M204 S6000
G1 X85.986 Y97.61 E.0044
; LINE_WIDTH: 0.419237
G1 X85.782 Y97.411 E.00559
; LINE_WIDTH: 0.468138
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.164 Y97.786 F18000
; LINE_WIDTH: 0.359763
G1 F1500
M204 S6000
G1 X86.406 Y98.071 E.00623
G1 X86.698 Y98.52 E.00893
G1 X86.9 Y99.026 E.00909
G1 X86.985 Y99.38 E.00607
G1 X87.03 Y99.874 E.00826
G1 X87.011 Y100.249 E.00625
G1 X86.94 Y100.638 E.00659
G1 X86.776 Y101.122 E.00852
G1 X86.503 Y101.602 E.0092
G1 X86.179 Y101.993 E.00847
G1 X85.939 Y102.214 E.00543
G1 X85.494 Y102.521 E.00902
G1 X85.128 Y102.694 E.00674
G1 X84.629 Y102.841 E.00867
G1 X84.292 Y102.885 E.00567
G1 X83.768 Y102.888 E.00873
G1 X83.341 Y102.817 E.0072
G1 X82.869 Y102.665 E.00826
G1 X82.397 Y102.408 E.00896
G1 X82.142 Y102.223 E.00525
G1 X81.881 Y101.985 E.00589
G1 X81.598 Y101.649 E.00732
G1 X81.336 Y101.205 E.00859
G1 X81.194 Y100.859 E.00622
G1 X81.097 Y100.498 E.00624
G1 X81.039 Y100.005 E.00826
G1 X81.058 Y99.546 E.00767
G1 X81.126 Y99.186 E.00609
G1 X81.227 Y98.849 E.00587
G1 X81.388 Y98.494 E.00649
G1 X81.656 Y98.08 E.00822
G1 X82.021 Y97.673 E.0091
; LINE_WIDTH: 0.400642
G1 X82.195 Y97.496 E.00465
; LINE_WIDTH: 0.438436
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477132
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.414 Y96.244 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.148518
G1 F1500
M204 S6000
G1 X77.117 Y96.023 E.00227
G1 X77.053 Y95.956 E.00057
G1 X76.982 Y95.848 E.00079
G1 X76.882 Y95.627 E.00149
; WIPE_START
G1 X76.982 Y95.848 E-.11064
G1 X77.053 Y95.956 E-.05847
G1 X77.117 Y96.023 E-.04215
G1 X77.414 Y96.244 E-.16874
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.199 Y88.615 Z5.52 F18000
G1 X76.889 Y77.602 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.0885018
G1 F1500
M204 S6000
G1 X76.926 Y77.491 E.00037
; LINE_WIDTH: 0.113678
G1 X76.963 Y77.381 E.00051
; LINE_WIDTH: 0.149709
G1 X77.153 Y77.146 E.00187
G1 X77.243 Y77.069 E.00073
G1 X77.392 Y77 E.00102
; LINE_WIDTH: 0.10006
G1 X77.531 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
M73 P91 R2
G1 F1500
G1 X77.392 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/49
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I-1.133 J.443 P1  F18000
G1 X85.254 Y97.116 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.0109
G1 X84.263 Y96.864 E.00802
G1 X83.903 Y96.858 E.00764
G1 X83.359 Y96.929 E.0116
G1 X82.8 Y97.11 E.01243
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.01141
G1 X85.29 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02989
G1 X84.639 Y96.915 E-.09785
G1 X84.263 Y96.864 E-.07197
G1 X83.903 Y96.858 E-.06856
G1 X83.359 Y96.929 E-.10417
G1 X83.321 Y96.941 E-.00758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.402 Y101.014 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.361 Y101.108 E.00218
G1 X86.195 Y101.385 E.00683
G1 X85.902 Y101.741 E.00975
G1 X85.544 Y102.045 E.00995
G1 X85.145 Y102.275 E.00975
G1 X84.844 Y102.393 E.00683
G1 X84.532 Y102.474 E.00683
G1 X84.074 Y102.522 E.00976
G1 X83.605 Y102.487 E.00995
G1 X83.159 Y102.371 E.00975
G1 X82.863 Y102.245 E.00682
G1 X82.599 Y102.093 E.00645
G1 X82.224 Y101.797 E.01011
G1 X81.914 Y101.442 E.00999
G1 X81.673 Y101.039 E.00994
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.51 E.00975
G1 X81.551 Y99.063 E.00975
G1 X81.674 Y98.764 E.00684
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.453 Y97.344 E.00979
G1 X83.927 Y97.283 E.01011
G1 X84.231 Y97.288 E.00645
G1 X84.55 Y97.331 E.00682
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.902 Y98.061 E.00976
G1 X86.201 Y98.424 E.00995
G1 X86.431 Y98.836 E.00998
G1 X86.583 Y99.289 E.01011
G1 X86.636 Y99.589 E.00645
G1 X86.656 Y99.91 E.00682
G1 X86.614 Y100.369 E.00975
G1 X86.492 Y100.813 E.00975
G1 X86.427 Y100.959 E.00338
M204 S250
G1 X86.029 Y100.847 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.997 Y100.919 E.00154
G1 X85.859 Y101.149 E.00526
G1 X85.61 Y101.452 E.00773
G1 X85.307 Y101.709 E.0078
G1 X84.967 Y101.905 E.00773
G1 X84.718 Y102.003 E.00527
G1 X84.459 Y102.07 E.00526
G1 X84.068 Y102.111 E.00774
G1 X83.673 Y102.082 E.00779
G1 X83.292 Y101.983 E.00773
G1 X83.046 Y101.878 E.00526
G1 X82.829 Y101.753 E.00493
G1 X82.507 Y101.499 E.00806
G1 X82.246 Y101.2 E.00781
G1 X82.043 Y100.86 E.00779
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00774
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00527
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00774
G1 X82.706 Y98.134 E.00774
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00775
G1 X83.95 Y97.692 E.00806
G1 X84.2 Y97.697 E.00493
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00774
G1 X85.861 Y98.656 E.0078
G1 X86.055 Y99.002 E.00781
G1 X86.185 Y99.39 E.00806
G1 X86.229 Y99.637 E.00493
G1 X86.245 Y99.904 E.00526
G1 X86.21 Y100.296 E.00773
G1 X86.105 Y100.675 E.00773
G1 X86.053 Y100.793 E.00254
; WIPE_START
M204 S6000
G1 X85.997 Y100.919 E-.02632
G1 X85.859 Y101.149 E-.05084
G1 X85.61 Y101.452 E-.0747
G1 X85.307 Y101.709 E-.07533
G1 X84.967 Y101.905 E-.07466
G1 X84.718 Y102.003 E-.05086
G1 X84.579 Y102.039 E-.0273
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.992 E.00386
G1 X87.039 Y98.351 E.00884
G1 X87.266 Y98.909 E.01276
G1 X87.389 Y99.49 E.01256
G1 X87.414 Y99.89 E.00849
G1 X87.364 Y100.487 E.01268
G1 X87.204 Y101.076 E.01292
G1 X86.945 Y101.621 E.01277
G1 X86.599 Y102.103 E.01255
G1 X86.32 Y102.391 E.00849
G1 X86.001 Y102.65 E.00869
G1 X85.678 Y102.855 E.00811
G1 X85.301 Y103.035 E.00884
G1 X85.1 Y103.108 E.00453
G1 X84.733 Y103.208 E.00805
G1 X84.326 Y103.269 E.0087
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.762 Y103.032 E.00869
G1 X82.4 Y102.859 E.0085
G1 X82.061 Y102.644 E.00849
G1 X81.75 Y102.391 E.00849
G1 X81.471 Y102.103 E.00849
G1 X81.125 Y101.621 E.01254
G1 X80.939 Y101.256 E.00869
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.491 E.00846
G1 X80.66 Y100.061 E.00916
G1 X80.679 Y99.499 E.0119
G1 X80.752 Y99.097 E.00865
G1 X80.883 Y98.684 E.00917
G1 X81.038 Y98.337 E.00804
G1 X81.358 Y97.838 E.01255
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.323 Y96.453 E.00527
G1 X77.178 Y96.405 E.00324
G1 X77.016 Y96.311 E.00396
G1 X76.909 Y96.216 E.00302
G1 X76.764 Y96.023 E.00512
G1 X76.683 Y95.812 E.00479
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.628 E.37965
G1 X76.692 Y77.35 E.00593
G1 X76.8 Y77.119 E.00541
G1 X76.963 Y76.933 E.00522
G1 X77.096 Y76.84 E.00343
G1 X77.243 Y76.772 E.00343
G1 X77.493 Y76.723 E.00539
G1 X90.566 Y76.722 E.27672
G1 X90.739 Y76.747 E.00369
G1 X90.883 Y76.794 E.00321
G1 X91.059 Y76.889 E.00424
G1 X91.011 Y77.082 E.0042
G1 X77.982 Y77.082 E.27577
G1 X77.697 Y77.131 E.00611
G1 X77.423 Y77.277 E.00658
G1 X77.205 Y77.495 E.00652
G1 X77.053 Y77.797 E.00717
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.617 Y96.047 E.00952
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.039 Y97.59 E.01823
G1 X87.167 Y97.767 E.0043
G1 X87.4 Y98.158 E.00896
G1 X87.507 Y98.385 E.00494
G1 X87.656 Y98.783 E.00835
G1 X87.715 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.824 Y99.889 E.00885
G1 X87.799 Y100.341 E.00891
G1 X87.714 Y100.808 E.00934
G1 X87.59 Y101.214 E.00834
G1 X87.494 Y101.446 E.00494
G1 X87.301 Y101.824 E.00835
G1 X87.184 Y102.009 E.00431
G1 X86.91 Y102.37 E.00891
G1 X86.597 Y102.693 E.00885
G1 X86.246 Y102.979 E.00891
G1 X86.062 Y103.103 E.00437
G1 X85.871 Y103.216 E.00436
G1 X85.46 Y103.413 E.00896
G1 X85.224 Y103.499 E.00494
G1 X84.817 Y103.609 E.00829
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.821 Y102.977 E.00885
G1 X81.473 Y102.693 E.00885
G1 X81.16 Y102.37 E.00885
G1 X80.885 Y102.009 E.00892
G1 X80.769 Y101.824 E.0043
G1 X80.563 Y101.42 E.00891
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.561 E.00884
G1 X80.25 Y100.082 E.00948
G1 X80.253 Y99.661 E.00828
G1 X80.273 Y99.443 E.00431
G1 X80.354 Y98.998 E.0089
G1 X80.5 Y98.538 E.00948
G1 X80.672 Y98.154 E.00828
G1 X80.778 Y97.962 E.00431
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.234 Y96.854 E.00619
G1 X77.021 Y96.784 E.00442
G1 X76.89 Y96.718 E.00289
G1 X76.767 Y96.637 E.0029
G1 X76.607 Y96.495 E.00419
G1 X76.415 Y96.24 E.00629
G1 X76.352 Y96.114 E.00276
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35362
G1 X76.265 Y77.374 E.00466
G1 X76.299 Y77.232 E.00288
G1 X76.354 Y77.083 E.00312
G1 X76.457 Y76.893 E.00426
G1 X76.599 Y76.714 E.00449
G1 X76.704 Y76.615 E.00283
G1 X76.89 Y76.484 E.00448
G1 X77.097 Y76.388 E.00448
G1 X77.234 Y76.347 E.00283
G1 X77.463 Y76.313 E.00454
G1 X90.595 Y76.313 E.2583
G1 X90.833 Y76.347 E.00472
G1 X91.046 Y76.417 E.00441
G1 X91.24 Y76.522 E.00436
G1 X91.472 Y76.717 E.00595
G1 X91.653 Y76.959 E.00595
G1 X91.746 Y77.16 E.00436
G1 X91.804 Y77.375 E.00437
G1 X91.811 Y77.491 E.00229
G1 X78.017 Y77.491 E.27132
G1 X77.832 Y77.523 E.00369
G1 X77.67 Y77.609 E.00362
G1 X77.541 Y77.738 E.00356
G1 X77.449 Y77.922 E.00406
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00443
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.039 Y97.59 E-.16879
G1 X87.167 Y97.767 E-.04156
G1 X87.4 Y98.158 E-.08655
G1 X87.507 Y98.385 E-.04768
G1 X87.573 Y98.56 E-.03541
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




G1 X86.162 Y97.784
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378846
G1 F1500
M204 S6000
G1 X85.985 Y97.609 E.00438
; LINE_WIDTH: 0.41936
G1 X85.782 Y97.411 E.00557
; LINE_WIDTH: 0.468141
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.162 Y97.784 F18000
; LINE_WIDTH: 0.359951
G1 F1500
M204 S6000
G1 X86.502 Y98.201 E.00897
G1 X86.698 Y98.529 E.00638
G1 X86.899 Y99.025 E.00892
G1 X86.948 Y99.207 E.00314
G1 X87.012 Y99.538 E.00562
G1 X87.034 Y99.928 E.00651
G1 X86.982 Y100.451 E.00875
G1 X86.848 Y100.944 E.00852
G1 X86.689 Y101.289 E.00634
G1 X86.494 Y101.61 E.00626
G1 X86.16 Y102.015 E.00875
G1 X85.774 Y102.346 E.00848
G1 X85.319 Y102.609 E.00876
G1 X84.971 Y102.75 E.00627
G1 X84.588 Y102.848 E.0066
G1 X84.065 Y102.896 E.00875
G1 X83.558 Y102.858 E.00847
G1 X83.253 Y102.792 E.00521
G1 X82.906 Y102.678 E.00609
G1 X82.686 Y102.578 E.00402
G1 X82.398 Y102.412 E.00555
G1 X82.007 Y102.11 E.00823
G1 X81.764 Y101.854 E.00589
G1 X81.457 Y101.427 E.00877
G1 X81.289 Y101.103 E.00609
G1 X81.151 Y100.725 E.0067
G1 X81.072 Y100.357 E.00627
G1 X81.038 Y99.988 E.00619
G1 X81.072 Y99.439 E.00916
G1 X81.198 Y98.935 E.00867
G1 X81.333 Y98.61 E.00586
G1 X81.455 Y98.374 E.00444
G1 X81.662 Y98.073 E.0061
G1 X82.021 Y97.673 E.00895
; LINE_WIDTH: 0.400622
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438411
M73 P91 R1
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.47711
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.421 Y96.245 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.148454
G1 F1500
M204 S6000
G1 X77.061 Y95.967 E.00278
G1 X76.982 Y95.848 E.00087
G1 X76.882 Y95.627 E.00149
; WIPE_START
G1 X76.982 Y95.848 E-.10995
G1 X77.061 Y95.967 E-.06454
G1 X77.421 Y96.245 E-.20551
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.204 Y88.615 Z5.64 F18000
G1 X76.892 Y77.598 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.0974244
G1 F1500
M204 S6000
G1 X76.925 Y77.482 E.00043
; LINE_WIDTH: 0.125812
G1 X76.973 Y77.362 E.00065
; LINE_WIDTH: 0.150119
G1 X77.146 Y77.152 E.00169
G1 X77.255 Y77.064 E.00087
G1 X77.382 Y77.003 E.00088
; LINE_WIDTH: 0.101817
G1 X77.53 Y76.954 E.00059
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M73 P92 R1
G1 X77.382 Y77.003 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/49
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I-1.133 J.444 P1  F18000
G1 X85.254 Y97.115 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.0109
G1 X84.263 Y96.864 E.00802
G1 X83.9 Y96.858 E.0077
G1 X83.359 Y96.929 E.01155
G1 X82.8 Y97.11 E.01243
G1 X82.693 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02985
G1 X84.639 Y96.915 E-.09785
G1 X84.263 Y96.864 E-.07201
G1 X83.9 Y96.858 E-.06909
G1 X83.359 Y96.929 E-.10366
G1 X83.321 Y96.941 E-.00754
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.389 Y101.029 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.281 Y101.251 E.00523
G1 X86.107 Y101.504 E.0065
G1 X85.895 Y101.747 E.00682
G1 X85.544 Y102.045 E.00975
G1 X85.137 Y102.28 E.00995
G1 X84.703 Y102.435 E.00975
G1 X84.386 Y102.498 E.00683
G1 X84.063 Y102.522 E.00686
G1 X83.599 Y102.485 E.00986
G1 X83.299 Y102.416 E.00651
G1 X82.996 Y102.307 E.00682
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00995
G1 X81.677 Y101.046 E.00975
G1 X81.555 Y100.748 E.00683
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.551 Y99.063 E.00975
G1 X81.674 Y98.764 E.00683
G1 X81.831 Y98.482 E.00683
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.453 Y97.344 E.00978
G1 X83.924 Y97.283 E.01006
G1 X84.231 Y97.288 E.00651
G1 X84.55 Y97.331 E.00682
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.895 Y98.055 E.00956
G1 X86.108 Y98.298 E.00683
G1 X86.289 Y98.565 E.00683
G1 X86.489 Y98.98 E.00975
G1 X86.614 Y99.433 E.00995
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.489 Y100.823 E.00998
G1 X86.415 Y100.975 E.00356
M204 S250
G1 X86.021 Y100.849 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.926 Y101.044 E.00426
G1 X85.783 Y101.253 E.00498
G1 X85.607 Y101.455 E.00526
G1 X85.307 Y101.709 E.00774
G1 X84.964 Y101.907 E.00779
G1 X84.594 Y102.04 E.00773
G1 X84.331 Y102.091 E.00526
G1 X84.064 Y102.111 E.00527
G1 X83.661 Y102.079 E.00795
G1 X83.415 Y102.022 E.00498
G1 X83.163 Y101.932 E.00526
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.863 E.00773
G1 X81.943 Y100.615 E.00526
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00526
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00774
G1 X83.947 Y97.692 E.00801
G1 X84.2 Y97.697 E.00498
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.607 Y98.347 E.00768
G1 X85.783 Y98.549 E.00526
G1 X85.934 Y98.77 E.00526
G1 X86.105 Y99.124 E.00774
G1 X86.21 Y99.506 E.0078
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.00779
G1 X86.105 Y100.678 E.00781
G1 X86.047 Y100.795 E.00257
; WIPE_START
M204 S6000
G1 X85.926 Y101.044 E-.05259
G1 X85.783 Y101.253 E-.04808
G1 X85.607 Y101.455 E-.05081
G1 X85.307 Y101.709 E-.07473
G1 X84.964 Y101.907 E-.07529
G1 X84.594 Y102.04 E-.0747
G1 X84.574 Y102.043 E-.00381
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.786 Y96.443 E.00326
G1 X90.515 Y96.482 E.00579
G1 X85.532 Y96.482 E.10548
G1 X86.718 Y97.845 E.03824
G1 X86.825 Y97.993 E.00386
G1 X87.039 Y98.351 E.00884
G1 X87.263 Y98.901 E.01257
G1 X87.389 Y99.48 E.01255
G1 X87.415 Y99.899 E.00888
G1 X87.41 Y100.08 E.00383
G1 X87.358 Y100.514 E.00926
G1 X87.207 Y101.07 E.01219
G1 X86.944 Y101.621 E.01292
G1 X86.6 Y102.101 E.01251
G1 X86.3 Y102.408 E.00907
G1 X86.002 Y102.65 E.00813
G1 X85.678 Y102.855 E.00812
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00869
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.762 Y103.032 E.00869
G1 X82.401 Y102.86 E.00846
G1 X82.041 Y102.629 E.00906
G1 X81.612 Y102.258 E.012
G1 X81.345 Y101.947 E.00869
G1 X81.121 Y101.613 E.0085
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01254
G1 X80.754 Y99.088 E.00884
G1 X80.947 Y98.526 E.01257
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.132 Y96.381 E.00452
G1 X77.009 Y96.305 E.00306
G1 X76.824 Y96.119 E.00556
G1 X76.731 Y95.957 E.00394
G1 X76.683 Y95.812 E.00324
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.963 Y76.933 E.00521
G1 X77.186 Y76.794 E.00556
G1 X77.331 Y76.746 E.00325
G1 X77.493 Y76.723 E.00345
G1 X90.568 Y76.722 E.27675
G1 X90.739 Y76.747 E.00365
G1 X90.875 Y76.792 E.00304
G1 X91.051 Y76.893 E.00429
G1 X91 Y77.082 E.00414
G1 X77.981 Y77.082 E.27557
G1 X77.692 Y77.132 E.0062
G1 X77.422 Y77.278 E.00649
G1 X77.206 Y77.494 E.00649
G1 X77.053 Y77.798 E.00718
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.779 E.00797
G1 X77.617 Y96.047 E.0095
G1 X77.972 Y96.12 E.00767
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.00431
G1 X87.4 Y98.158 E.00896
G1 X87.506 Y98.381 E.00485
G1 X87.655 Y98.78 E.00838
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.11 E.0043
G1 X87.761 Y100.587 E.00945
G1 X87.661 Y101.001 E.00837
G1 X87.508 Y101.417 E.00873
G1 X87.301 Y101.824 E.00897
G1 X87.184 Y102.009 E.00431
G1 X86.91 Y102.369 E.0089
G1 X86.577 Y102.711 E.00939
G1 X86.246 Y102.979 E.00838
G1 X85.871 Y103.216 E.00873
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.00431
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.00431
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00884
G1 X81.8 Y102.961 E.00939
G1 X81.47 Y102.691 E.00838
G1 X81.313 Y102.539 E.00431
G1 X81.018 Y102.195 E.00891
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.355 Y98.995 E.00896
G1 X80.422 Y98.758 E.00485
G1 X80.573 Y98.359 E.00838
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01817
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.953 Y96.751 E.00595
G1 X76.77 Y96.639 E.00423
G1 X76.652 Y96.541 E.00302
G1 X76.499 Y96.368 E.00453
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.599 Y76.714 E.00448
G1 X76.704 Y76.615 E.00283
G1 X76.892 Y76.483 E.00453
G1 X77.03 Y76.415 E.00303
G1 X77.237 Y76.346 E.00429
G1 X77.463 Y76.313 E.00448
G1 X90.597 Y76.313 E.25834
G1 X90.832 Y76.347 E.00468
G1 X91.043 Y76.416 E.00436
G1 X91.299 Y76.563 E.00582
G1 X91.473 Y76.717 E.00455
G1 X91.61 Y76.89 E.00435
G1 X91.747 Y77.163 E.00601
G1 X91.804 Y77.375 E.00431
G1 X91.811 Y77.491 E.00229
G1 X78.016 Y77.491 E.27133
G1 X77.828 Y77.524 E.00376
G1 X77.669 Y77.61 E.00355
G1 X77.542 Y77.737 E.00355
G1 X77.449 Y77.922 E.00407
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00383
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00443
G1 X90.691 Y96.881 E.00429
G1 X90.528 Y96.891 E.00321
G1 X86.49 Y96.891 E.07942
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16878
G1 X87.167 Y97.767 E-.04159
G1 X87.4 Y98.158 E-.08653
G1 X87.506 Y98.381 E-.04681
G1 X87.573 Y98.56 E-.03628
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




G1 X86.153 Y97.775
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380241
G1 F1500
M204 S6000
G1 X85.981 Y97.605 E.00429
; LINE_WIDTH: 0.419801
G1 X85.782 Y97.411 E.00545
; LINE_WIDTH: 0.468129
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.153 Y97.775 F18000
; LINE_WIDTH: 0.35994
G1 F1500
M204 S6000
G1 X86.417 Y98.077 E.00668
G1 X86.698 Y98.53 E.00889
G1 X86.844 Y98.862 E.00605
G1 X86.98 Y99.352 E.00848
G1 X87.007 Y99.525 E.00292
G1 X87.027 Y100.057 E.00889
G1 X86.985 Y100.447 E.00654
G1 X86.836 Y100.971 E.00908
G1 X86.616 Y101.429 E.00847
G1 X86.398 Y101.741 E.00636
G1 X86.151 Y102.023 E.00625
G1 X85.774 Y102.346 E.00827
G1 X85.307 Y102.612 E.00897
G1 X85.005 Y102.735 E.00543
G1 X84.791 Y102.801 E.00373
G1 X84.447 Y102.87 E.00586
G1 X84.05 Y102.895 E.00663
G1 X83.554 Y102.856 E.0083
G1 X83.202 Y102.782 E.00599
G1 X82.831 Y102.647 E.00658
G1 X82.371 Y102.394 E.00875
G1 X81.953 Y102.057 E.00896
G1 X81.648 Y101.716 E.00763
G1 X81.346 Y101.226 E.0096
G1 X81.201 Y100.879 E.00626
G1 X81.097 Y100.498 E.0066
G1 X81.039 Y100.005 E.00826
G1 X81.058 Y99.546 E.00767
G1 X81.129 Y99.175 E.00629
G1 X81.188 Y98.958 E.00376
G1 X81.296 Y98.682 E.00493
G1 X81.46 Y98.365 E.00595
G1 X81.662 Y98.073 E.00593
G1 X82.021 Y97.673 E.00894
; LINE_WIDTH: 0.400606
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438397
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477095
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.139448
G1 F1500
M204 S6000
G1 X77.256 Y96.128 E.00144
; LINE_WIDTH: 0.148736
G1 X77.042 Y95.953 E.00169
G1 X76.882 Y95.627 E.00223
; WIPE_START
G1 X77.042 Y95.953 E-.21611
G1 X77.256 Y96.128 E-.16389
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.105 Y88.497 Z5.76 F18000
G1 X76.889 Y77.604 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.091006
G1 F1500
M204 S6000
G1 X76.93 Y77.486 E.00041
; LINE_WIDTH: 0.121155
G1 X76.97 Y77.367 E.0006
; LINE_WIDTH: 0.156928
G1 X77.034 Y77.273 E.00074
G1 X77.239 Y77.074 E.00188
; LINE_WIDTH: 0.13164
G1 X77.392 Y76.999 E.0009
; LINE_WIDTH: 0.0999845
G1 X77.529 Y76.954 E.00053
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.392 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/49
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I-1.133 J.443 P1  F18000
M73 P93 R1
G1 X85.265 Y97.12 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00307
G1 X84.639 Y96.915 E.0109
G1 X84.263 Y96.864 E.00802
G1 X83.897 Y96.858 E.00775
G1 X83.358 Y96.929 E.01149
G1 X82.8 Y97.11 E.01242
G1 X82.694 Y96.949 E.0041
G1 X83.045 Y96.544 E.01135
G1 X85.033 Y96.544 E.04207
G1 X85.388 Y96.956 E.01152
G1 X85.301 Y97.073 E.00308
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.03197
G1 X84.639 Y96.915 E-.09785
G1 X84.263 Y96.864 E-.07203
G1 X83.897 Y96.858 E-.0696
G1 X83.358 Y96.929 E-.10317
G1 X83.332 Y96.938 E-.00538
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.373 Y101.069 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.201 Y101.378 E.00749
G1 X85.902 Y101.741 E.00995
G1 X85.551 Y102.039 E.00975
G1 X85.276 Y102.208 E.00683
G1 X84.984 Y102.344 E.00683
G1 X84.541 Y102.473 E.00975
G1 X84.074 Y102.522 E.00995
G1 X83.604 Y102.487 E.00997
G1 X83.147 Y102.366 E.01
G1 X82.862 Y102.244 E.00656
G1 X82.583 Y102.083 E.00682
G1 X82.223 Y101.796 E.00975
G1 X81.913 Y101.441 E.00997
G1 X81.672 Y101.034 E.01001
G1 X81.555 Y100.747 E.00656
G1 X81.469 Y100.437 E.00682
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.052 E.00997
G1 X81.748 Y98.621 E.01001
G1 X81.915 Y98.36 E.00656
G1 X82.114 Y98.119 E.00663
G1 X82.34 Y97.902 E.00662
G1 X82.588 Y97.716 E.00656
G1 X83.003 Y97.491 E.01
G1 X83.452 Y97.345 E.01
G1 X83.921 Y97.283 E.01
G1 X84.231 Y97.288 E.00656
G1 X84.55 Y97.331 E.00682
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.903 Y98.062 E.00978
G1 X86.202 Y98.428 E.01
G1 X86.361 Y98.694 E.00656
G1 X86.492 Y98.989 E.00682
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.892 E.00975
G1 X86.636 Y100.214 E.00683
G1 X86.579 Y100.531 E.00683
G1 X86.43 Y100.967 E.00975
G1 X86.402 Y101.017 E.00119
M204 S250
G1 X86.016 Y100.87 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.861 Y101.146 E.00623
G1 X85.61 Y101.452 E.0078
G1 X85.31 Y101.707 E.00774
G1 X85.082 Y101.847 E.00526
G1 X84.839 Y101.96 E.00526
G1 X84.462 Y102.07 E.00774
G1 X84.068 Y102.111 E.0078
G1 X83.672 Y102.082 E.0078
G1 X83.281 Y101.979 E.00796
G1 X83.046 Y101.878 E.00503
G1 X82.814 Y101.744 E.00526
G1 X82.507 Y101.499 E.00773
G1 X82.246 Y101.2 E.00781
G1 X82.04 Y100.852 E.00796
G1 X81.943 Y100.615 E.00503
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.0078
G1 X82.109 Y98.817 E.00796
G1 X82.247 Y98.602 E.00503
G1 X82.414 Y98.397 E.0052
G1 X82.605 Y98.215 E.0052
G1 X82.81 Y98.061 E.00503
G1 X83.165 Y97.868 E.00796
G1 X83.543 Y97.745 E.00781
G1 X83.945 Y97.693 E.00796
G1 X84.2 Y97.697 E.00503
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.35 E.00774
G1 X85.866 Y98.663 E.00796
G1 X85.997 Y98.883 E.00503
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00773
G1 X86.245 Y99.898 E.00774
G1 X86.229 Y100.165 E.00526
G1 X86.182 Y100.428 E.00526
G1 X86.054 Y100.8 E.00773
G1 X86.045 Y100.817 E.00038
; WIPE_START
M204 S6000
G1 X85.861 Y101.146 E-.0716
G1 X85.61 Y101.452 E-.07531
G1 X85.31 Y101.707 E-.07473
G1 X85.082 Y101.847 E-.0508
G1 X84.839 Y101.96 E-.05084
G1 X84.553 Y102.044 E-.05673
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.284 Y96.12 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12114
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.786 Y96.443 E.00326
G1 X90.515 Y96.482 E.00579
G1 X85.539 Y96.482 E.10533
G1 X86.724 Y97.855 E.03839
G1 X87.036 Y98.345 E.01229
G1 X87.266 Y98.91 E.01292
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.08 E.01251
G1 X87.359 Y100.51 E.00916
G1 X87.207 Y101.069 E.01225
G1 X86.949 Y101.612 E.01272
G1 X86.712 Y101.963 E.00898
G1 X86.458 Y102.258 E.00823
G1 X86.002 Y102.65 E.01274
G1 X85.483 Y102.955 E.01274
G1 X85.128 Y103.099 E.0081
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00869
G1 X83.725 Y103.267 E.01273
G1 X83.142 Y103.161 E.01254
G1 X82.762 Y103.032 E.0085
G1 X82.235 Y102.762 E.01253
G1 X81.902 Y102.522 E.00869
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.0085
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.8 Y100.879 E.00849
G1 X80.707 Y100.489 E.0085
G1 X80.66 Y100.091 E.00849
G1 X80.662 Y99.68 E.00869
G1 X80.752 Y99.096 E.01251
G1 X80.879 Y98.692 E.00897
G1 X81.038 Y98.337 E.00823
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.133 Y96.381 E.0045
G1 X77.003 Y96.301 E.00324
G1 X76.828 Y96.124 E.00526
G1 X76.772 Y96.04 E.00214
G1 X76.683 Y95.812 E.00517
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.693 Y77.349 E.00577
G1 X76.795 Y77.125 E.0052
G1 X76.968 Y76.929 E.00553
G1 X77.095 Y76.84 E.00329
G1 X77.243 Y76.772 E.00344
G1 X77.493 Y76.723 E.00539
G1 X90.57 Y76.722 E.27678
G1 X90.729 Y76.745 E.00342
G1 X90.929 Y76.818 E.00449
G1 X91.054 Y76.9 E.00317
G1 X91 Y77.082 E.00401
G1 X77.981 Y77.082 E.27555
G1 X77.696 Y77.131 E.00614
G1 X77.415 Y77.282 E.00674
G1 X77.182 Y77.529 E.00719
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.00639
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.224 Y96.12 E.15369
; WIPE_START
M204 S6000
G1 X87.224 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.433 Y96.891 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.05 Y97.606 E.01857
G1 X87.291 Y97.962 E.00847
G1 X87.495 Y98.356 E.00873
G1 X87.656 Y98.783 E.00897
G1 X87.715 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.00891
G1 X87.819 Y100.11 E.0043
G1 X87.762 Y100.582 E.00936
G1 X87.661 Y101.001 E.00847
G1 X87.498 Y101.438 E.00917
G1 X87.302 Y101.821 E.00846
G1 X87.037 Y102.212 E.0093
G1 X86.756 Y102.538 E.00847
G1 X86.599 Y102.691 E.00431
G1 X86.246 Y102.979 E.00897
G1 X86.064 Y103.102 E.00431
G1 X85.665 Y103.322 E.00897
G1 X85.254 Y103.489 E.00872
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.0043
G1 X83.694 Y103.675 E.00897
G1 X83.477 Y103.649 E.00431
G1 X83.034 Y103.556 E.00891
G1 X82.608 Y103.412 E.00885
G1 X82.199 Y103.216 E.00891
G1 X82.01 Y103.105 E.00431
G1 X81.643 Y102.84 E.00891
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.407 Y100.998 E.00885
G1 X80.303 Y100.56 E.00885
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.0043
G1 X80.354 Y98.998 E.0089
G1 X80.496 Y98.547 E.0093
G1 X80.672 Y98.154 E.00847
G1 X80.778 Y97.962 E.00431
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.954 Y96.751 E.00594
G1 X76.762 Y96.633 E.00442
G1 X76.652 Y96.541 E.00283
G1 X76.503 Y96.375 E.00438
G1 X76.418 Y96.245 E.00305
G1 X76.352 Y96.114 E.00288
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.231 E.00448
G1 X76.384 Y77.019 E.00448
G1 X76.456 Y76.895 E.00283
G1 X76.599 Y76.714 E.00453
G1 X76.71 Y76.61 E.00299
G1 X76.89 Y76.484 E.00433
G1 X77.097 Y76.388 E.00448
G1 X77.234 Y76.347 E.00283
G1 X77.463 Y76.313 E.00454
G1 X90.599 Y76.313 E.25837
G1 X90.829 Y76.346 E.00459
G1 X91.113 Y76.449 E.00594
G1 X91.359 Y76.611 E.00579
G1 X91.52 Y76.77 E.00446
G1 X91.688 Y77.025 E.006
G1 X91.77 Y77.231 E.00436
G1 X91.817 Y77.491 E.00519
G1 X78.017 Y77.491 E.27144
G1 X77.831 Y77.523 E.00371
G1 X77.667 Y77.611 E.00366
G1 X77.525 Y77.762 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.31 E.00382
G1 X77.567 Y95.498 E.00426
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00366
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00443
G1 X90.689 Y96.881 E.00432
G1 X90.528 Y96.891 E.00317
G1 X86.493 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.05 Y97.606 E-.17214
G1 X87.291 Y97.962 E-.0818
G1 X87.495 Y98.356 E-.08434
G1 X87.573 Y98.562 E-.04171
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




G1 X86.163 Y97.785
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378992
G1 F1500
M204 S6000
G1 X85.986 Y97.61 E.0044
; LINE_WIDTH: 0.420675
G1 X85.783 Y97.411 E.00559
; LINE_WIDTH: 0.468427
G1 X85.495 Y97.168 E.00833
M204 S10000
G1 X86.163 Y97.785 F18000
; LINE_WIDTH: 0.359523
G1 F1500
M204 S6000
G1 X86.418 Y98.087 E.00657
G1 X86.698 Y98.52 E.00859
G1 X86.9 Y99.026 E.00908
G1 X86.985 Y99.38 E.00606
G1 X87.03 Y99.874 E.00826
G1 X87.009 Y100.268 E.00658
G1 X86.938 Y100.637 E.00625
G1 X86.777 Y101.106 E.00825
G1 X86.617 Y101.418 E.00584
G1 X86.407 Y101.73 E.00626
G1 X86.183 Y101.996 E.00579
G1 X85.778 Y102.343 E.00888
G1 X85.313 Y102.612 E.00894
G1 X85.008 Y102.735 E.00547
G1 X84.629 Y102.841 E.00656
G1 X84.065 Y102.899 E.00944
G1 X83.6 Y102.868 E.00775
G1 X83.244 Y102.789 E.00608
G1 X82.908 Y102.679 E.00589
G1 X82.361 Y102.388 E.01032
G1 X81.952 Y102.058 E.00874
G1 X81.648 Y101.716 E.00762
G1 X81.34 Y101.213 E.00982
G1 X81.201 Y100.878 E.00604
G1 X81.097 Y100.498 E.00657
G1 X81.039 Y100.005 E.00826
G1 X81.058 Y99.546 E.00766
G1 X81.126 Y99.189 E.00605
G1 X81.236 Y98.83 E.00625
G1 X81.454 Y98.373 E.00842
G1 X81.66 Y98.071 E.00609
G1 X82.078 Y97.61 E.01036
; LINE_WIDTH: 0.406615
G1 X82.217 Y97.479 E.00364
; LINE_WIDTH: 0.444437
G1 X82.342 Y97.363 E.00355
; LINE_WIDTH: 0.478387
G1 X82.583 Y97.167 E.00702
; WIPE_START
G1 X82.342 Y97.363 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.463 Y96.245 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.134236
G1 F1500
M204 S6000
G1 X77.256 Y96.129 E.00128
; LINE_WIDTH: 0.149175
G1 X77.047 Y95.957 E.00167
G1 X76.882 Y95.626 E.00228
; WIPE_START
G1 X77.047 Y95.957 E-.21914
G1 X77.256 Y96.129 E-.16086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.105 Y88.499 Z5.88 F18000
G1 X76.889 Y77.601 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.0994921
G1 F1500
M204 S6000
G1 X76.944 Y77.423 E.00069
; LINE_WIDTH: 0.146987
G1 X76.999 Y77.322 E.00069
G1 X77.151 Y77.147 E.0014
G1 X77.242 Y77.071 E.00072
G1 X77.382 Y77.003 E.00095
; LINE_WIDTH: 0.101789
G1 X77.53 Y76.954 E.00059
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.382 Y77.003 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/49
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I-1.133 J.443 P1  F18000
G1 X85.247 Y97.113 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.15 Y97.064 E.0023
M73 P94 R1
G1 X84.639 Y96.915 E.01126
G1 X84.263 Y96.864 E.00803
G1 X83.894 Y96.858 E.00781
G1 X83.358 Y96.929 E.01144
G1 X82.8 Y97.11 E.01241
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.375 Y96.948 E.01132
G1 X85.283 Y97.066 E.00316
; WIPE_START
M204 S6000
G1 X85.15 Y97.064 E-.0254
G1 X84.639 Y96.915 E-.10107
G1 X84.263 Y96.864 E-.07212
G1 X83.894 Y96.858 E-.07012
G1 X83.358 Y96.929 E-.1027
G1 X83.315 Y96.943 E-.00858
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.376 Y101.063 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.201 Y101.377 E.0076
G1 X85.902 Y101.741 E.00997
G1 X85.544 Y102.045 E.00995
G1 X85.145 Y102.275 E.00975
G1 X84.845 Y102.393 E.00682
G1 X84.542 Y102.472 E.00662
G1 X84.084 Y102.521 E.00975
G1 X83.761 Y102.507 E.00685
G1 X83.442 Y102.454 E.00683
G1 X83.004 Y102.312 E.00975
G1 X82.591 Y102.089 E.00995
G1 X82.223 Y101.796 E.00995
G1 X81.914 Y101.442 E.00994
G1 X81.673 Y101.039 E.00995
G1 X81.511 Y100.607 E.00975
G1 X81.444 Y100.291 E.00683
G1 X81.415 Y99.97 E.00683
G1 X81.442 Y99.509 E.00977
G1 X81.555 Y99.053 E.00995
G1 X81.674 Y98.764 E.00662
G1 X81.831 Y98.482 E.00682
G1 X82.113 Y98.118 E.00975
G1 X82.455 Y97.809 E.00975
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.452 Y97.345 E.00977
G1 X83.918 Y97.283 E.00995
G1 X84.231 Y97.288 E.00662
G1 X84.551 Y97.331 E.00683
G1 X84.993 Y97.461 E.00977
G1 X85.413 Y97.672 E.00995
G1 X85.669 Y97.852 E.00662
G1 X85.908 Y98.068 E.00683
G1 X86.201 Y98.424 E.00975
G1 X86.425 Y98.826 E.00976
G1 X86.539 Y99.129 E.00683
G1 X86.615 Y99.442 E.00683
G1 X86.656 Y99.901 E.00975
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00682
G1 X86.429 Y100.966 E.00662
G1 X86.405 Y101.01 E.00108
M204 S250
G1 X86.017 Y100.865 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.862 Y101.146 E.00633
G1 X85.61 Y101.452 E.0078
G1 X85.307 Y101.709 E.0078
G1 X84.967 Y101.905 E.00773
G1 X84.718 Y102.003 E.00526
G1 X84.468 Y102.068 E.00508
G1 X84.071 Y102.111 E.00785
G1 X83.804 Y102.099 E.00527
G1 X83.54 Y102.055 E.00526
G1 X83.166 Y101.934 E.00773
G1 X82.817 Y101.746 E.00779
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.00779
G1 X82.043 Y100.86 E.00779
G1 X81.905 Y100.492 E.00774
G1 X81.849 Y100.23 E.00526
G1 X81.825 Y99.964 E.00526
G1 X81.849 Y99.571 E.00774
G1 X81.945 Y99.18 E.00791
G1 X82.043 Y98.942 E.00508
G1 X82.174 Y98.708 E.00526
G1 X82.414 Y98.397 E.00773
G1 X82.706 Y98.134 E.00773
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00774
G1 X83.942 Y97.693 E.00792
G1 X84.2 Y97.697 E.00508
G1 X84.465 Y97.733 E.00526
G1 X84.843 Y97.843 E.00774
G1 X85.202 Y98.024 E.00792
G1 X85.413 Y98.173 E.00507
G1 X85.612 Y98.352 E.00526
G1 X85.861 Y98.655 E.00773
G1 X86.053 Y98.999 E.00774
G1 X86.147 Y99.249 E.00526
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00773
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.057 Y100.794 E.00508
G1 X86.047 Y100.812 E.00041
; WIPE_START
M204 S6000
G1 X85.862 Y101.146 E-.07255
G1 X85.61 Y101.452 E-.07536
G1 X85.307 Y101.709 E-.07533
G1 X84.967 Y101.905 E-.0747
G1 X84.718 Y102.003 E-.0508
G1 X84.559 Y102.045 E-.03127
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.717 Y97.844 E.03822
G1 X86.834 Y98.006 E.00423
G1 X87.039 Y98.351 E.0085
G1 X87.263 Y98.901 E.01257
G1 X87.389 Y99.48 E.01254
G1 X87.415 Y99.899 E.00888
G1 X87.359 Y100.506 E.01289
G1 X87.207 Y101.07 E.01238
G1 X86.948 Y101.613 E.01273
G1 X86.605 Y102.096 E.01254
G1 X86.32 Y102.391 E.00869
G1 X86.001 Y102.65 E.00869
G1 X85.678 Y102.855 E.0081
G1 X85.3 Y103.035 E.00886
G1 X85.112 Y103.104 E.00424
G1 X84.733 Y103.208 E.00833
G1 X84.326 Y103.269 E.0087
G1 X83.734 Y103.267 E.01254
G1 X83.152 Y103.164 E.01251
G1 X82.747 Y103.025 E.00907
G1 X82.392 Y102.855 E.00832
G1 X81.901 Y102.522 E.01255
G1 X81.606 Y102.251 E.00849
G1 X81.345 Y101.947 E.00849
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.257 E.00847
G1 X80.795 Y100.863 E.00887
G1 X80.678 Y100.3 E.01218
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.752 Y99.096 E.00847
G1 X80.878 Y98.696 E.00887
G1 X81.038 Y98.337 E.00832
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.132 Y96.381 E.00451
G1 X77.007 Y96.304 E.00312
G1 X76.867 Y96.173 E.00405
G1 X76.769 Y96.033 E.00363
G1 X76.683 Y95.812 E.00501
G1 X76.654 Y95.565 E.00527
G1 X76.654 Y77.619 E.37984
G1 X76.695 Y77.34 E.00597
G1 X76.801 Y77.118 E.0052
G1 X76.967 Y76.93 E.00531
G1 X77.095 Y76.84 E.00331
G1 X77.234 Y76.775 E.00325
G1 X77.484 Y76.723 E.00539
G1 X90.571 Y76.722 E.27701
G1 X90.729 Y76.745 E.00338
G1 X90.929 Y76.818 E.00449
G1 X91.054 Y76.9 E.00317
G1 X91 Y77.082 E.00401
G1 X77.981 Y77.082 E.27556
G1 X77.693 Y77.132 E.00619
G1 X77.422 Y77.278 E.0065
G1 X77.206 Y77.495 E.00649
G1 X77.053 Y77.798 E.00718
G1 X77.016 Y78.056 E.00553
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.00641
G1 X77.256 Y95.779 E.00796
G1 X77.617 Y96.047 E.00951
G1 X77.972 Y96.12 E.00766
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.176 Y97.782 E.00466
G1 X87.4 Y98.158 E.00862
G1 X87.502 Y98.372 E.00466
G1 X87.655 Y98.78 E.00856
G1 X87.763 Y99.22 E.00891
G1 X87.796 Y99.437 E.00431
G1 X87.825 Y99.892 E.00897
G1 X87.819 Y100.11 E.0043
G1 X87.763 Y100.578 E.00926
G1 X87.661 Y101.001 E.00856
G1 X87.508 Y101.418 E.00873
G1 X87.302 Y101.821 E.00891
G1 X87.049 Y102.197 E.00892
G1 X86.912 Y102.367 E.0043
G1 X86.597 Y102.693 E.00891
G1 X86.246 Y102.979 E.00891
G1 X85.871 Y103.216 E.00872
G1 X85.459 Y103.413 E.00896
G1 X85.237 Y103.494 E.00466
G1 X84.817 Y103.609 E.00856
G1 X84.369 Y103.676 E.00892
G1 X84.15 Y103.689 E.0043
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.591 Y103.404 E.00927
G1 X82.199 Y103.216 E.00856
G1 X82.011 Y103.105 E.00431
G1 X81.643 Y102.84 E.00891
G1 X81.311 Y102.536 E.00885
G1 X81.018 Y102.195 E.00885
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.421 E.00884
G1 X80.403 Y100.981 E.0092
G1 X80.302 Y100.558 E.00856
G1 X80.271 Y100.341 E.0043
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00884
G1 X80.494 Y98.551 E.00921
G1 X80.672 Y98.153 E.00856
G1 X80.778 Y97.962 E.0043
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01817
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.953 Y96.751 E.00595
G1 X76.767 Y96.637 E.0043
G1 X76.65 Y96.539 E.00302
G1 X76.549 Y96.432 E.00288
G1 X76.417 Y96.243 E.00454
G1 X76.352 Y96.114 E.00283
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.454 E.00301
G1 X76.3 Y77.228 E.00454
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.893 E.00448
G1 X76.599 Y76.714 E.00447
G1 X76.708 Y76.611 E.00296
G1 X76.89 Y76.484 E.00436
G1 X77.094 Y76.389 E.00442
G1 X77.314 Y76.33 E.00448
G1 X77.46 Y76.313 E.00289
G1 X90.6 Y76.313 E.25846
G1 X90.829 Y76.346 E.00455
G1 X91.113 Y76.449 E.00594
G1 X91.361 Y76.612 E.00582
G1 X91.52 Y76.77 E.00443
G1 X91.688 Y77.025 E.006
G1 X91.77 Y77.231 E.00436
G1 X91.817 Y77.491 E.00519
G1 X78.017 Y77.491 E.27144
G1 X77.829 Y77.524 E.00375
G1 X77.669 Y77.61 E.00356
G1 X77.542 Y77.737 E.00355
G1 X77.449 Y77.922 E.00407
G1 X77.425 Y78.086 E.00325
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00383
G1 X77.568 Y95.501 E.00432
G1 X77.789 Y95.665 E.0054
G1 X78.013 Y95.711 E.00451
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00366
G1 X91.718 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.525 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16872
G1 X87.176 Y97.782 E-.04499
G1 X87.4 Y98.158 E-.08322
G1 X87.502 Y98.372 E-.04503
G1 X87.572 Y98.56 E-.03804
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




G1 X86.174 Y97.797
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382465
G1 F1500
M204 S6000
G1 X85.911 Y97.531 E.00666
; LINE_WIDTH: 0.426823
G1 X85.785 Y97.417 E.00339
; LINE_WIDTH: 0.467983
G1 X85.653 Y97.305 E.00383
; LINE_WIDTH: 0.464964
G1 X85.486 Y97.336 E.00374
; LINE_WIDTH: 0.437112
G1 X85.318 Y97.367 E.0035
M204 S10000
G1 X86.174 Y97.797 F18000
; LINE_WIDTH: 0.359724
G1 F1500
M204 S6000
G1 X86.502 Y98.201 E.00867
G1 X86.699 Y98.53 E.00639
G1 X86.9 Y99.013 E.00872
G1 X86.987 Y99.393 E.00648
G1 X87.031 Y99.915 E.00874
G1 X86.99 Y100.409 E.00826
G1 X86.903 Y100.781 E.00636
G1 X86.779 Y101.113 E.00591
G1 X86.504 Y101.601 E.00932
G1 X86.179 Y101.993 E.00849
G1 X85.777 Y102.344 E.00889
G1 X85.497 Y102.515 E.00548
G1 X84.992 Y102.743 E.00924
G1 X84.654 Y102.835 E.00582
G1 X84.292 Y102.885 E.0061
G1 X83.768 Y102.888 E.00873
G1 X83.341 Y102.816 E.0072
G1 X82.869 Y102.665 E.00826
G1 X82.397 Y102.408 E.00896
G1 X82.142 Y102.222 E.00525
G1 X81.881 Y101.985 E.00589
G1 X81.6 Y101.652 E.00726
G1 X81.327 Y101.189 E.00896
G1 X81.161 Y100.756 E.00772
G1 X81.07 Y100.338 E.00713
G1 X81.037 Y99.963 E.00626
G1 X81.059 Y99.536 E.00713
G1 X81.126 Y99.188 E.0059
G1 X81.234 Y98.833 E.00619
G1 X81.455 Y98.373 E.0085
G1 X81.662 Y98.073 E.00609
G1 X82.021 Y97.673 E.00894
; LINE_WIDTH: 0.400592
G1 X82.195 Y97.496 E.00464
; LINE_WIDTH: 0.438386
G1 X82.402 Y97.319 E.00561
; LINE_WIDTH: 0.477097
G1 X82.582 Y97.165 E.00533
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.48 Y96.249 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.1444
G1 F1500
M204 S6000
G1 X77.257 Y96.128 E.0015
G1 X77.061 Y95.968 E.0015
G1 X76.982 Y95.848 E.00085
G1 X76.882 Y95.627 E.00144
; WIPE_START
G1 X76.982 Y95.848 E-.10342
G1 X77.061 Y95.968 E-.061
G1 X77.257 Y96.128 E-.10748
G1 X77.48 Y96.249 E-.10811
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.238 Y88.62 Z6 F18000
G1 X76.889 Y77.604 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0910001
G1 F1500
M204 S6000
G1 X76.93 Y77.486 E.00041
; LINE_WIDTH: 0.121136
M73 P95 R1
G1 X76.97 Y77.367 E.0006
; LINE_WIDTH: 0.154314
G1 X77.147 Y77.151 E.00179
G1 X77.256 Y77.068 E.00088
; LINE_WIDTH: 0.125244
G1 X77.429 Y76.991 E.00094
; LINE_WIDTH: 0.0895994
G1 X77.531 Y76.955 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.429 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/49
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I-1.134 J.441 P1  F18000
G1 X85.247 Y97.113 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.148 Y97.064 E.00235
G1 X84.639 Y96.915 E.01123
G1 X84.263 Y96.864 E.00803
G1 X83.891 Y96.858 E.00787
G1 X83.358 Y96.929 E.01139
G1 X82.8 Y97.11 E.0124
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04188
G1 X85.375 Y96.948 E.01133
G1 X85.284 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X85.148 Y97.064 E-.02584
G1 X84.639 Y96.915 E-.10083
G1 X84.263 Y96.864 E-.07211
G1 X83.891 Y96.858 E-.07067
G1 X83.358 Y96.929 E-.1022
G1 X83.316 Y96.943 E-.00835
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.371 Y101.072 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.201 Y101.377 E.00739
G1 X85.902 Y101.741 E.00996
G1 X85.544 Y102.045 E.00995
G1 X85.145 Y102.275 E.00975
G1 X84.845 Y102.393 E.00683
G1 X84.532 Y102.474 E.00683
G1 X84.074 Y102.522 E.00975
G1 X83.615 Y102.488 E.00975
G1 X83.3 Y102.416 E.00683
G1 X82.996 Y102.307 E.00683
G1 X82.591 Y102.089 E.00975
G1 X82.223 Y101.796 E.00995
G1 X81.913 Y101.441 E.00996
G1 X81.674 Y101.039 E.0099
G1 X81.555 Y100.748 E.00667
G1 X81.471 Y100.444 E.00667
G1 X81.414 Y99.98 E.0099
G1 X81.442 Y99.509 E.00998
G1 X81.554 Y99.055 E.0099
G1 X81.674 Y98.764 E.00667
G1 X81.831 Y98.482 E.00682
G1 X82.107 Y98.125 E.00956
G1 X82.341 Y97.902 E.00683
G1 X82.599 Y97.708 E.00683
G1 X83.004 Y97.49 E.00975
G1 X83.452 Y97.345 E.00996
G1 X83.916 Y97.283 E.0099
G1 X84.231 Y97.288 E.00667
G1 X84.55 Y97.331 E.00682
G1 X84.993 Y97.46 E.00975
G1 X85.405 Y97.666 E.00975
G1 X85.669 Y97.852 E.00683
G1 X85.908 Y98.068 E.00683
G1 X86.195 Y98.417 E.00955
G1 X86.361 Y98.694 E.00683
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.615 Y100.36 E.00975
G1 X86.539 Y100.673 E.00682
G1 X86.428 Y100.968 E.00668
G1 X86.4 Y101.02 E.00124
M204 S250
G1 X86.013 Y100.874 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.862 Y101.146 E.00613
G1 X85.61 Y101.452 E.0078
G1 X85.307 Y101.709 E.0078
G1 X84.967 Y101.905 E.00773
G1 X84.718 Y102.003 E.00526
G1 X84.459 Y102.07 E.00526
G1 X84.068 Y102.111 E.00774
G1 X83.676 Y102.082 E.00773
G1 X83.415 Y102.023 E.00526
G1 X83.163 Y101.932 E.00526
G1 X82.817 Y101.746 E.00773
G1 X82.507 Y101.499 E.0078
G1 X82.246 Y101.2 E.0078
G1 X82.042 Y100.856 E.00787
G1 X81.943 Y100.615 E.00512
G1 X81.874 Y100.364 E.00512
G1 X81.825 Y99.967 E.00787
G1 X81.849 Y99.571 E.00781
G1 X81.944 Y99.183 E.00787
G1 X82.043 Y98.942 E.00512
G1 X82.173 Y98.708 E.00526
G1 X82.412 Y98.4 E.00768
G1 X82.606 Y98.215 E.00526
G1 X82.82 Y98.054 E.00526
G1 X83.166 Y97.868 E.00774
G1 X83.543 Y97.745 E.0078
G1 X83.94 Y97.693 E.00787
G1 X84.2 Y97.697 E.00512
G1 X84.465 Y97.733 E.00526
G1 X84.842 Y97.843 E.00774
G1 X85.194 Y98.019 E.00773
G1 X85.413 Y98.173 E.00526
G1 X85.612 Y98.352 E.00526
G1 X85.859 Y98.653 E.00767
G1 X85.997 Y98.883 E.00526
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00774
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.292 E.00773
G1 X86.147 Y100.552 E.00526
G1 X86.056 Y100.796 E.00513
G1 X86.042 Y100.821 E.00056
; WIPE_START
M204 S6000
G1 X85.862 Y101.146 E-.0706
G1 X85.61 Y101.452 E-.07536
G1 X85.307 Y101.709 E-.07533
G1 X84.967 Y101.905 E-.07468
G1 X84.718 Y102.003 E-.05083
G1 X84.549 Y102.047 E-.03319
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.778 Y96.446 E.00343
G1 X90.508 Y96.482 E.00578
G1 X85.532 Y96.482 E.10532
G1 X86.718 Y97.845 E.03824
G1 X87.04 Y98.356 E.0128
G1 X87.202 Y98.72 E.00842
G1 X87.361 Y99.3 E.01274
G1 X87.414 Y99.902 E.0128
G1 X87.364 Y100.488 E.01245
G1 X87.206 Y101.07 E.01275
G1 X87.041 Y101.446 E.00869
G1 X86.725 Y101.947 E.01254
G1 X86.32 Y102.392 E.01273
G1 X86.175 Y102.517 E.00405
G1 X85.678 Y102.855 E.01274
G1 X85.308 Y103.032 E.00868
G1 X84.919 Y103.164 E.00869
G1 X84.326 Y103.269 E.01273
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01254
G1 X82.762 Y103.032 E.00869
G1 X82.4 Y102.859 E.00849
G1 X82.061 Y102.644 E.0085
G1 X81.75 Y102.391 E.00849
G1 X81.471 Y102.103 E.00849
G1 X81.228 Y101.784 E.00848
G1 X81.019 Y101.426 E.00877
G1 X80.86 Y101.062 E.00842
G1 X80.707 Y100.489 E.01255
G1 X80.66 Y100.091 E.00849
G1 X80.679 Y99.499 E.01254
G1 X80.754 Y99.087 E.00886
G1 X80.947 Y98.526 E.01256
G1 X81.132 Y98.17 E.0085
G1 X81.358 Y97.838 E.00849
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.333 Y96.454 E.00508
G1 X77.133 Y96.381 E.0045
G1 X77.003 Y96.301 E.00324
G1 X76.824 Y96.119 E.0054
G1 X76.684 Y95.821 E.00696
G1 X76.654 Y95.565 E.00546
G1 X76.654 Y77.62 E.37982
G1 X76.695 Y77.34 E.00598
G1 X76.801 Y77.118 E.00521
G1 X76.963 Y76.933 E.00521
G1 X77.182 Y76.796 E.00547
G1 X77.332 Y76.746 E.00334
G1 X77.493 Y76.723 E.00344
G1 X90.573 Y76.723 E.27685
G1 X90.729 Y76.745 E.00335
G1 X90.937 Y76.821 E.00468
G1 X91.06 Y76.897 E.00306
G1 X91.007 Y77.082 E.00407
G1 X77.981 Y77.082 E.27572
G1 X77.692 Y77.133 E.00621
G1 X77.414 Y77.283 E.00668
G1 X77.182 Y77.529 E.00717
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.256 Y95.778 E.00796
G1 X77.616 Y96.047 E.00951
G1 X77.971 Y96.12 E.00768
G1 X85.214 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.167 Y97.767 E.0043
G1 X87.405 Y98.168 E.00917
G1 X87.583 Y98.57 E.00865
G1 X87.654 Y98.777 E.00431
G1 X87.763 Y99.22 E.00897
G1 X87.796 Y99.436 E.0043
G1 X87.824 Y99.902 E.00917
G1 X87.799 Y100.341 E.00865
G1 X87.767 Y100.56 E.00436
G1 X87.718 Y100.79 E.00463
G1 X87.591 Y101.211 E.00865
G1 X87.409 Y101.627 E.00891
G1 X87.304 Y101.818 E.0043
G1 X87.051 Y102.195 E.00892
G1 X86.756 Y102.538 E.00891
G1 X86.597 Y102.693 E.00437
G1 X86.429 Y102.838 E.00437
G1 X86.059 Y103.105 E.00897
G1 X85.871 Y103.216 E.00431
G1 X85.462 Y103.412 E.00891
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.0043
G1 X84.369 Y103.676 E.00898
G1 X84.15 Y103.689 E.0043
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.821 Y102.977 E.00885
G1 X81.473 Y102.693 E.00885
G1 X81.16 Y102.37 E.00885
G1 X80.887 Y102.012 E.00885
G1 X80.654 Y101.612 E.00911
G1 X80.478 Y101.209 E.00865
G1 X80.408 Y101.001 E.0043
G1 X80.303 Y100.56 E.00891
G1 X80.251 Y100.114 E.00885
G1 X80.253 Y99.661 E.00891
G1 X80.273 Y99.443 E.00431
G1 X80.355 Y98.994 E.00897
G1 X80.418 Y98.771 E.00457
G1 X80.573 Y98.359 E.00865
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.238 Y96.855 E.00613
G1 X76.954 Y96.751 E.00594
G1 X76.762 Y96.633 E.00442
G1 X76.652 Y96.541 E.00283
G1 X76.499 Y96.368 E.00454
G1 X76.42 Y96.248 E.00283
G1 X76.322 Y96.039 E.00454
G1 X76.282 Y95.904 E.00277
G1 X76.245 Y95.589 E.00625
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.45 E.00311
G1 X76.3 Y77.228 E.00445
G1 X76.35 Y77.093 E.00283
G1 X76.458 Y76.892 E.00448
G1 X76.599 Y76.714 E.00448
G1 X76.704 Y76.615 E.00283
G1 X76.892 Y76.483 E.00453
G1 X77.025 Y76.416 E.00292
G1 X77.237 Y76.346 E.00439
G1 X77.463 Y76.313 E.00448
G1 X90.602 Y76.313 E.25843
G1 X90.829 Y76.346 E.00452
G1 X91.116 Y76.45 E.006
G1 X91.302 Y76.565 E.0043
G1 X91.522 Y76.773 E.00595
G1 X91.688 Y77.025 E.00595
G1 X91.77 Y77.231 E.00436
G1 X91.817 Y77.491 E.00519
G1 X78.016 Y77.491 E.27144
G1 X77.828 Y77.524 E.00377
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00406
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33503
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00431
G1 X77.788 Y95.664 E.00539
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.2715
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.112 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.902 Y96.837 E.00448
G1 X90.762 Y96.87 E.00283
G1 X90.526 Y96.891 E.00466
G1 X86.49 Y96.891 E.07937
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16877
G1 X87.167 Y97.767 E-.04155
G1 X87.405 Y98.168 E-.0886
G1 X87.578 Y98.558 E-.08108
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




G1 X86.174 Y97.797
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.35973
G1 F1500
M204 S6000
G1 X86.494 Y98.191 E.00846
G1 X86.703 Y98.531 E.00664
G1 X86.893 Y99.004 E.0085
G1 X86.985 Y99.38 E.00646
G1 X87.035 Y99.903 E.00875
G1 X87.01 Y100.258 E.00593
G1 X86.902 Y100.774 E.00879
G1 X86.765 Y101.137 E.00646
G1 X86.502 Y101.6 E.00887
G1 X86.179 Y101.993 E.00848
G1 X85.939 Y102.214 E.00543
G1 X85.492 Y102.518 E.00901
G1 X85.297 Y102.62 E.00366
G1 X84.97 Y102.748 E.00585
G1 X84.611 Y102.84 E.00618
G1 X84.29 Y102.886 E.0054
G1 X83.768 Y102.884 E.00869
G1 X83.252 Y102.796 E.00873
G1 X82.854 Y102.657 E.00702
G1 X82.396 Y102.411 E.00867
G1 X82.007 Y102.11 E.00818
G1 X81.762 Y101.852 E.00593
G1 X81.546 Y101.571 E.00591
G1 X81.342 Y101.219 E.00679
G1 X81.168 Y100.778 E.00789
G1 X81.083 Y100.422 E.00609
G1 X81.039 Y100.007 E.00697
G1 X81.058 Y99.546 E.00769
G1 X81.128 Y99.179 E.00622
G1 X81.297 Y98.679 E.00878
G1 X81.46 Y98.365 E.0059
G1 X81.663 Y98.072 E.00593
G1 X82.078 Y97.609 E.01037
; LINE_WIDTH: 0.407519
G1 X82.223 Y97.473 E.00378
; LINE_WIDTH: 0.447007
G1 X82.352 Y97.353 E.00371
; LINE_WIDTH: 0.47979
G1 X82.583 Y97.167 E.00673
; WIPE_START
G1 X82.352 Y97.353 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.319 Y97.368 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.416233
G1 F1500
M204 S6000
G1 X85.478 Y97.338 E.00316
; LINE_WIDTH: 0.442966
G1 X85.638 Y97.308 E.00337
; LINE_WIDTH: 0.468073
G1 X85.66 Y97.304 E.0005
G1 X85.785 Y97.417 E.00372
; LINE_WIDTH: 0.426898
G1 X85.911 Y97.53 E.00338
; LINE_WIDTH: 0.382479
G1 X86.174 Y97.797 E.00667
; WIPE_START
G1 X85.911 Y97.53 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.365 Y96.383 Z6.12 F18000
G1 X77.48 Y96.249 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.139317
G1 F1500
M204 S6000
G1 X77.257 Y96.128 E.00144
; LINE_WIDTH: 0.153567
G1 X77.043 Y95.955 E.00176
G1 X76.958 Y95.8 E.00113
; LINE_WIDTH: 0.123379
G1 X76.927 Y95.711 E.00046
; LINE_WIDTH: 0.0936118
G1 X76.896 Y95.622 E.00032
; WIPE_START
G1 X76.927 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.911 Y88.078 Z6.12 F18000
G1 X76.889 Y77.601 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.0995721
M73 P96 R0
G1 F1500
M204 S6000
G1 X76.96 Y77.388 E.00083
; LINE_WIDTH: 0.157066
G1 X77.036 Y77.274 E.00089
G1 X77.239 Y77.071 E.00188
; LINE_WIDTH: 0.131266
G1 X77.393 Y76.999 E.00089
; LINE_WIDTH: 0.0999022
G1 X77.529 Y76.954 E.00053
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.393 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/49
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-1.133 J.443 P1  F18000
G1 X85.254 Y97.115 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X85.133 Y97.059 E.00282
G1 X84.639 Y96.915 E.0109
G1 X84.263 Y96.864 E.00804
G1 X83.888 Y96.858 E.00793
G1 X83.357 Y96.929 E.01133
G1 X82.8 Y97.11 E.0124
G1 X82.694 Y96.949 E.0041
G1 X83.046 Y96.544 E.01135
G1 X85.024 Y96.544 E.04187
G1 X85.378 Y96.951 E.0114
G1 X85.29 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X85.133 Y97.059 E-.02984
G1 X84.639 Y96.915 E-.0978
G1 X84.263 Y96.864 E-.07219
G1 X83.888 Y96.858 E-.07119
G1 X83.357 Y96.929 E-.10168
G1 X83.321 Y96.941 E-.00729
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.381 Y101.047 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.287 Y101.241 E.00456
G1 X86.108 Y101.504 E.00673
G1 X85.895 Y101.747 E.00683
G1 X85.543 Y102.045 E.00976
G1 X85.14 Y102.277 E.00984
G1 X84.844 Y102.393 E.00673
G1 X84.532 Y102.474 E.00682
G1 X84.074 Y102.522 E.00975
G1 X83.605 Y102.487 E.00996
G1 X83.155 Y102.369 E.00984
G1 X82.863 Y102.245 E.00672
G1 X82.587 Y102.086 E.00673
G1 X82.223 Y101.796 E.00985
G1 X81.913 Y101.442 E.00997
G1 X81.675 Y101.042 E.00985
G1 X81.555 Y100.748 E.00673
G1 X81.469 Y100.437 E.00683
G1 X81.414 Y99.979 E.00975
G1 X81.442 Y99.51 E.00995
G1 X81.554 Y99.054 E.00995
G1 X81.741 Y98.633 E.00975
G1 X81.915 Y98.361 E.00683
G1 X82.12 Y98.111 E.00683
G1 X82.455 Y97.809 E.00955
G1 X82.725 Y97.632 E.00683
G1 X83.013 Y97.487 E.00683
G1 X83.452 Y97.345 E.00976
G1 X83.913 Y97.283 E.00984
G1 X84.231 Y97.288 E.00673
G1 X84.551 Y97.331 E.00683
G1 X84.984 Y97.458 E.00955
G1 X85.276 Y97.593 E.00683
G1 X85.551 Y97.763 E.00683
G1 X85.903 Y98.061 E.00977
G1 X86.198 Y98.421 E.00984
G1 X86.361 Y98.694 E.00673
G1 X86.492 Y98.989 E.00683
G1 X86.614 Y99.433 E.00975
G1 X86.656 Y99.901 E.00995
G1 X86.614 Y100.369 E.00995
G1 X86.489 Y100.822 E.00996
G1 X86.407 Y100.993 E.00402
M204 S250
G1 X86.012 Y100.869 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.932 Y101.036 E.00364
G1 X85.783 Y101.253 E.00517
G1 X85.607 Y101.454 E.00526
G1 X85.307 Y101.709 E.00774
G1 X84.963 Y101.907 E.00782
G1 X84.718 Y102.003 E.00517
G1 X84.459 Y102.07 E.00526
G1 X84.068 Y102.111 E.00774
G1 X83.672 Y102.082 E.0078
G1 X83.288 Y101.981 E.00782
G1 X83.046 Y101.878 E.00517
G1 X82.818 Y101.746 E.00517
G1 X82.507 Y101.499 E.00782
G1 X82.246 Y101.2 E.0078
G1 X82.043 Y100.859 E.00782
G1 X81.943 Y100.615 E.00517
G1 X81.872 Y100.357 E.00526
G1 X81.825 Y99.967 E.00773
G1 X81.849 Y99.571 E.0078
G1 X81.943 Y99.186 E.0078
G1 X82.102 Y98.827 E.00773
G1 X82.247 Y98.602 E.00526
G1 X82.416 Y98.395 E.00526
G1 X82.706 Y98.134 E.00767
G1 X82.93 Y97.987 E.00526
G1 X83.169 Y97.867 E.00526
G1 X83.543 Y97.745 E.00774
G1 X83.937 Y97.693 E.00782
G1 X84.2 Y97.697 E.00517
G1 X84.465 Y97.733 E.00526
G1 X84.839 Y97.842 E.00767
G1 X85.082 Y97.954 E.00526
G1 X85.31 Y98.095 E.00526
G1 X85.61 Y98.349 E.00774
G1 X85.862 Y98.657 E.00782
G1 X85.997 Y98.883 E.00517
G1 X86.105 Y99.127 E.00526
G1 X86.21 Y99.506 E.00773
G1 X86.246 Y99.901 E.00779
G1 X86.21 Y100.296 E.0078
G1 X86.105 Y100.678 E.0078
G1 X86.038 Y100.815 E.003
; WIPE_START
M204 S6000
G1 X85.932 Y101.036 E-.04653
G1 X85.783 Y101.253 E-.04998
G1 X85.607 Y101.454 E-.05082
G1 X85.307 Y101.709 E-.07476
G1 X84.963 Y101.907 E-.07552
G1 X84.718 Y102.003 E-.04999
G1 X84.553 Y102.046 E-.0324
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.274 Y96.12 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.007 Y96.12 E.12135
G1 X91.06 Y96.305 E.00407
G1 X90.929 Y96.386 E.00325
G1 X90.786 Y96.442 E.00325
G1 X90.516 Y96.482 E.00578
G1 X85.532 Y96.482 E.1055
G1 X86.718 Y97.845 E.03824
G1 X86.83 Y98 E.00406
G1 X87.122 Y98.526 E.01273
G1 X87.266 Y98.91 E.00868
G1 X87.389 Y99.49 E.01254
G1 X87.41 Y100.081 E.01252
G1 X87.361 Y100.497 E.00887
G1 X87.207 Y101.069 E.01255
G1 X86.948 Y101.613 E.01274
G1 X86.605 Y102.096 E.01254
G1 X86.169 Y102.522 E.01289
G1 X85.678 Y102.855 E.01257
G1 X85.128 Y103.099 E.01273
G1 X84.732 Y103.208 E.00869
G1 X84.326 Y103.269 E.00869
G1 X83.734 Y103.267 E.01254
G1 X83.151 Y103.164 E.01253
G1 X82.762 Y103.032 E.00869
G1 X82.4 Y102.859 E.00848
G1 X82.055 Y102.639 E.00867
G1 X81.612 Y102.258 E.01236
G1 X81.345 Y101.947 E.00869
G1 X81.121 Y101.613 E.00849
G1 X80.939 Y101.256 E.00849
G1 X80.798 Y100.872 E.00867
G1 X80.678 Y100.3 E.01237
G1 X80.655 Y99.89 E.00869
G1 X80.68 Y99.49 E.00849
G1 X80.753 Y99.095 E.00849
G1 X80.874 Y98.704 E.00867
G1 X81.038 Y98.337 E.00851
G1 X81.358 Y97.838 E.01254
G1 X82.538 Y96.482 E.03805
G1 X77.571 Y96.482 E.10513
G1 X77.24 Y96.429 E.00709
G1 X77.104 Y96.366 E.00318
G1 X76.919 Y96.228 E.00489
G1 X76.774 Y96.04 E.00502
G1 X76.684 Y95.821 E.00502
G1 X76.654 Y95.565 E.00545
G1 X76.654 Y77.619 E.37983
G1 X76.695 Y77.341 E.00596
G1 X76.801 Y77.118 E.00521
G1 X76.965 Y76.932 E.00526
G1 X77.095 Y76.84 E.00338
G1 X77.243 Y76.772 E.00344
G1 X77.493 Y76.723 E.00539
G1 X90.574 Y76.723 E.27688
G1 X90.729 Y76.745 E.00331
G1 X90.928 Y76.818 E.0045
G1 X91.054 Y76.9 E.00318
G1 X91 Y77.082 E.00401
G1 X77.99 Y77.082 E.27537
G1 X77.731 Y77.12 E.00553
G1 X77.42 Y77.276 E.00736
G1 X77.182 Y77.529 E.00736
G1 X77.052 Y77.807 E.00649
G1 X77.016 Y78.056 E.00533
G1 X77.016 Y95.155 E.36192
G1 X77.068 Y95.453 E.0064
G1 X77.251 Y95.77 E.00776
G1 X77.579 Y96.029 E.00884
G1 X77.962 Y96.12 E.00834
G1 X85.214 Y96.12 E.15348
; WIPE_START
M204 S6000
G1 X87.214 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.43 Y96.891 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X87.038 Y97.59 E.01822
G1 X87.288 Y97.957 E.00873
G1 X87.497 Y98.359 E.00891
G1 X87.656 Y98.783 E.00891
G1 X87.714 Y98.994 E.00431
G1 X87.796 Y99.44 E.00891
G1 X87.825 Y99.892 E.0089
G1 X87.819 Y100.11 E.0043
G1 X87.765 Y100.569 E.00908
G1 X87.661 Y101.001 E.00874
G1 X87.504 Y101.425 E.00889
G1 X87.302 Y101.821 E.00875
G1 X87.05 Y102.197 E.00891
G1 X86.912 Y102.368 E.00431
G1 X86.595 Y102.695 E.00897
G1 X86.422 Y102.844 E.00448
G1 X86.059 Y103.105 E.0088
G1 X85.871 Y103.216 E.00431
G1 X85.459 Y103.413 E.00897
G1 X85.254 Y103.489 E.0043
G1 X84.817 Y103.609 E.00891
G1 X84.369 Y103.676 E.00891
G1 X84.15 Y103.689 E.0043
G1 X83.698 Y103.676 E.00891
G1 X83.249 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.815 Y102.972 E.00902
G1 X81.47 Y102.691 E.00874
G1 X81.313 Y102.539 E.0043
G1 X81.018 Y102.195 E.00891
G1 X80.768 Y101.821 E.00885
G1 X80.563 Y101.42 E.00885
G1 X80.405 Y100.99 E.00902
G1 X80.302 Y100.558 E.00874
G1 X80.271 Y100.341 E.00431
G1 X80.245 Y99.889 E.00891
G1 X80.273 Y99.44 E.00885
G1 X80.354 Y98.997 E.00885
G1 X80.491 Y98.559 E.00902
G1 X80.672 Y98.154 E.00874
G1 X80.778 Y97.962 E.00431
G1 X81.033 Y97.588 E.00891
G1 X81.639 Y96.891 E.01816
G1 X77.547 Y96.891 E.08049
G1 X77.232 Y96.854 E.00625
G1 X77.094 Y96.813 E.00283
G1 X76.893 Y96.719 E.00436
G1 X76.646 Y96.535 E.00607
G1 X76.549 Y96.432 E.00277
G1 X76.418 Y96.246 E.00448
G1 X76.323 Y96.042 E.00442
G1 X76.282 Y95.904 E.00283
G1 X76.245 Y95.589 E.00625
G1 X76.245 Y77.607 E.35368
G1 X76.254 Y77.451 E.00307
G1 X76.3 Y77.228 E.00448
G1 X76.351 Y77.09 E.00289
G1 X76.458 Y76.893 E.00442
G1 X76.599 Y76.714 E.00448
G1 X76.706 Y76.613 E.00289
G1 X76.89 Y76.484 E.00442
G1 X77.097 Y76.388 E.00448
G1 X77.234 Y76.347 E.00283
G1 X77.463 Y76.313 E.00454
G1 X90.604 Y76.313 E.25847
G1 X90.829 Y76.346 E.00448
G1 X91.113 Y76.449 E.00594
G1 X91.363 Y76.614 E.00589
G1 X91.52 Y76.77 E.00436
G1 X91.688 Y77.025 E.00601
G1 X91.77 Y77.231 E.00436
G1 X91.817 Y77.491 E.00519
G1 X78.019 Y77.491 E.27138
G1 X77.856 Y77.515 E.00325
G1 X77.669 Y77.609 E.00412
G1 X77.525 Y77.762 E.00413
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.459 Y95.311 E.00382
G1 X77.567 Y95.498 E.00425
G1 X77.762 Y95.652 E.00489
G1 X78.01 Y95.711 E.00503
G1 X91.817 Y95.711 E.27156
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.473 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.684 Y96.882 E.00442
G1 X90.528 Y96.891 E.00307
G1 X86.49 Y96.891 E.07943
; WIPE_START
M204 S6000
G1 X87.038 Y97.59 E-.16876
G1 X87.288 Y97.957 E-.08433
G1 X87.497 Y98.359 E-.08609
G1 X87.572 Y98.56 E-.04081
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




G1 X86.163 Y97.785
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378736
G1 F1500
M204 S6000
G1 X85.986 Y97.61 E.00439
; LINE_WIDTH: 0.419281
G1 X85.782 Y97.411 E.00557
; LINE_WIDTH: 0.468125
G1 X85.484 Y97.162 E.00857
M204 S10000
G1 X86.163 Y97.785 F18000
; LINE_WIDTH: 0.359774
G1 F1500
M204 S6000
G1 X86.499 Y98.194 E.00883
G1 X86.691 Y98.512 E.00618
G1 X86.85 Y98.873 E.00658
G1 X86.979 Y99.352 E.00826
G1 X87.008 Y99.536 E.00311
G1 X87.027 Y100.059 E.00871
G1 X86.988 Y100.431 E.00623
G1 X86.837 Y100.969 E.00932
G1 X86.622 Y101.419 E.0083
G1 X86.398 Y101.741 E.00654
G1 X86.149 Y102.021 E.00625
G1 X85.77 Y102.342 E.00827
G1 X85.494 Y102.517 E.00544
G1 X84.971 Y102.75 E.00955
G1 X84.587 Y102.848 E.00659
G1 X84.065 Y102.896 E.00874
G1 X83.558 Y102.858 E.00848
G1 X83.253 Y102.792 E.00519
G1 X82.906 Y102.678 E.00609
G1 X82.586 Y102.525 E.00592
G1 X82.386 Y102.404 E.00389
G1 X81.953 Y102.058 E.00923
G1 X81.648 Y101.716 E.00764
G1 X81.453 Y101.418 E.00593
G1 X81.289 Y101.104 E.00592
G1 X81.164 Y100.764 E.00603
G1 X81.105 Y100.521 E.00416
G1 X81.038 Y100.005 E.00866
G1 X81.059 Y99.536 E.00783
G1 X81.126 Y99.187 E.00592
G1 X81.231 Y98.841 E.00603
G1 X81.455 Y98.373 E.00864
G1 X81.66 Y98.071 E.00609
G1 X82.025 Y97.669 E.00905
; LINE_WIDTH: 0.40096
G1 X82.195 Y97.496 E.00453
; LINE_WIDTH: 0.438379
G1 X82.402 Y97.319 E.00562
; LINE_WIDTH: 0.477102
G1 X82.582 Y97.165 E.00534
; WIPE_START
G1 X82.402 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X77.461 Y96.25 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.14699
G1 F1500
M204 S6000
G1 X77.248 Y96.124 E.0015
G1 X77.084 Y95.994 E.00127
G1 X76.959 Y95.8 E.00139
; LINE_WIDTH: 0.123236
G1 X76.927 Y95.711 E.00046
; LINE_WIDTH: 0.0935188
G1 X76.896 Y95.622 E.00032
; WIPE_START
G1 X76.927 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.911 Y88.079 Z6.24 F18000
G1 X76.889 Y77.601 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.0993533
G1 F1500
M204 S6000
G1 X76.96 Y77.387 E.00083
; LINE_WIDTH: 0.149688
G1 X77.147 Y77.151 E.00187
G1 X77.251 Y77.065 E.00083
G1 X77.382 Y77.003 E.00089
; LINE_WIDTH: 0.100027
G1 X77.539 Y76.955 E.00061
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X77.382 Y77.003 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/49
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
M73 P97 R0
G3 Z6.24 I-1.145 J.414 P1  F18000
G1 X86.009 Y100.881 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X85.862 Y101.146 E.00597
G1 X85.61 Y101.453 E.0078
G1 X85.307 Y101.709 E.00779
G1 X84.964 Y101.907 E.00779
G1 X84.594 Y102.04 E.00774
G1 X84.332 Y102.091 E.00526
G1 X84.065 Y102.111 E.00527
G1 X83.672 Y102.082 E.00775
G1 X83.29 Y101.982 E.00776
G1 X83.046 Y101.878 E.00522
G1 X82.814 Y101.744 E.00526
G1 X82.507 Y101.499 E.00773
G1 X82.246 Y101.2 E.0078
G1 X82.044 Y100.861 E.00777
G1 X81.943 Y100.616 E.00522
G1 X81.872 Y100.359 E.00523
G1 X81.825 Y99.967 E.00777
G1 X81.849 Y99.571 E.0078
G1 X81.942 Y99.189 E.00773
G1 X82.043 Y98.942 E.00527
G1 X82.174 Y98.708 E.00526
G1 X82.412 Y98.399 E.00768
G1 X82.606 Y98.215 E.00525
G1 X82.818 Y98.055 E.00522
G1 X83.166 Y97.868 E.00777
G1 X83.543 Y97.745 E.0078
G1 X83.934 Y97.693 E.00777
G1 X84.2 Y97.697 E.00522
G1 X84.465 Y97.733 E.00525
G1 X84.842 Y97.843 E.00774
G1 X85.194 Y98.019 E.00774
G1 X85.413 Y98.173 E.00525
G1 X85.61 Y98.35 E.00522
G1 X85.861 Y98.655 E.00777
G1 X86.053 Y98.999 E.00774
G1 X86.147 Y99.25 E.00527
G1 X86.21 Y99.509 E.00526
G1 X86.246 Y99.901 E.00774
G1 X86.21 Y100.292 E.00772
G1 X86.147 Y100.553 E.00527
G1 X86.053 Y100.803 E.00526
G1 X86.039 Y100.829 E.00058
; WIPE_START
M204 S6000
G1 X85.862 Y101.146 E-.06906
G1 X85.61 Y101.453 E-.07539
G1 X85.307 Y101.709 E-.07529
G1 X84.964 Y101.907 E-.07524
G1 X84.594 Y102.04 E-.07475
G1 X84.541 Y102.05 E-.01028
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.412 Y96.891 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.892 Y97.411 E.01393
G1 X87.168 Y97.77 E.00891
G1 X87.4 Y98.159 E.00891
G1 X87.497 Y98.359 E.00437
G1 X87.582 Y98.568 E.00444
G1 X87.715 Y98.997 E.00884
G1 X87.796 Y99.44 E.00885
G1 X87.824 Y99.893 E.00892
G1 X87.799 Y100.341 E.00884
G1 X87.721 Y100.782 E.0088
G1 X87.59 Y101.214 E.00889
G1 X87.506 Y101.421 E.00438
G1 X87.302 Y101.821 E.00883
G1 X87.049 Y102.198 E.00893
G1 X86.756 Y102.538 E.00883
G1 X86.426 Y102.841 E.0088
G1 X86.059 Y103.105 E.00889
G1 X85.867 Y103.218 E.00438
G1 X85.462 Y103.412 E.00883
G1 X85.033 Y103.557 E.00891
G1 X84.82 Y103.608 E.00431
G1 X84.369 Y103.676 E.00897
G1 X84.15 Y103.689 E.0043
G1 X83.698 Y103.676 E.00891
G1 X83.25 Y103.608 E.00891
G1 X83.037 Y103.557 E.0043
G1 X82.608 Y103.412 E.00891
G1 X82.202 Y103.218 E.00885
G1 X81.818 Y102.975 E.00892
G1 X81.47 Y102.691 E.00883
G1 X81.313 Y102.538 E.00431
G1 X81.018 Y102.195 E.00891
G1 X80.766 Y101.818 E.00893
G1 X80.562 Y101.417 E.00884
G1 X80.48 Y101.215 E.0043
G1 X80.349 Y100.781 E.00891
G1 X80.27 Y100.338 E.00885
G1 X80.245 Y99.889 E.00885
G1 X80.273 Y99.437 E.0089
G1 X80.307 Y99.217 E.00438
G1 X80.414 Y98.784 E.00876
G1 X80.573 Y98.359 E.00893
G1 X80.78 Y97.96 E.00885
G1 X81.033 Y97.588 E.00885
G1 X81.639 Y96.891 E.01817
G1 X77.547 Y96.891 E.08049
G1 X77.232 Y96.854 E.00625
G1 X77.095 Y96.813 E.0028
G1 X76.893 Y96.719 E.00439
G1 X76.648 Y96.536 E.00601
G1 X76.499 Y96.369 E.00442
G1 X76.418 Y96.246 E.00289
G1 X76.352 Y96.114 E.00289
G1 X76.281 Y95.901 E.00442
G1 X76.245 Y95.589 E.00619
G1 X76.245 Y77.61 E.35362
G1 X76.265 Y77.374 E.00466
G1 X76.299 Y77.234 E.00283
G1 X76.384 Y77.019 E.00454
G1 X76.456 Y76.895 E.00283
G1 X76.599 Y76.714 E.00454
G1 X76.705 Y76.614 E.00286
G1 X76.89 Y76.484 E.00445
G1 X77.097 Y76.388 E.00448
G1 X77.234 Y76.347 E.00283
G1 X77.463 Y76.313 E.00454
G1 X90.605 Y76.313 E.2585
G1 X90.829 Y76.346 E.00445
G1 X91.116 Y76.45 E.00601
G1 X91.302 Y76.565 E.0043
G1 X91.523 Y76.774 E.00598
G1 X91.65 Y76.954 E.00433
G1 X91.77 Y77.234 E.006
G1 X91.817 Y77.491 E.00513
G1 X78.016 Y77.491 E.27144
G1 X77.828 Y77.524 E.00376
G1 X77.666 Y77.611 E.00361
G1 X77.525 Y77.762 E.00407
G1 X77.448 Y77.925 E.00355
G1 X77.425 Y78.086 E.00319
G1 X77.425 Y95.119 E.33504
G1 X77.458 Y95.311 E.00382
G1 X77.568 Y95.501 E.00432
G1 X77.788 Y95.664 E.0054
G1 X78.013 Y95.711 E.00452
G1 X91.817 Y95.711 E.27151
G1 X91.79 Y95.895 E.00367
G1 X91.719 Y96.111 E.00448
G1 X91.612 Y96.309 E.00442
G1 X91.472 Y96.486 E.00442
G1 X91.305 Y96.635 E.00442
G1 X91.113 Y96.753 E.00442
G1 X90.904 Y96.836 E.00442
G1 X90.683 Y96.882 E.00445
G1 X90.529 Y96.891 E.00304
G1 X86.472 Y96.891 E.0798
; WIPE_START
M204 S6000
G1 X86.892 Y97.411 E-.12708
G1 X87.168 Y97.77 E-.08608
G1 X87.4 Y98.159 E-.08605
G1 X87.497 Y98.359 E-.04218
G1 X87.574 Y98.547 E-.03862
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




G1 X90.934 Y77.274
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X90.19 Y76.53 E.02069
G1 X89.632 Y76.53
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
G1 X80.154 Y76.53 E.02069
G1 X79.597 Y76.53
G1 X80.34 Y77.274 E.02069
G1 X79.783 Y77.274
G1 X79.039 Y76.53 E.02069
G1 X78.482 Y76.53
G1 X79.225 Y77.274 E.02069
G1 X78.668 Y77.274
G1 X77.924 Y76.53 E.02069
G1 X77.381 Y76.545
G1 X78.11 Y77.274 E.02029
G1 X77.652 Y77.373
G1 X76.971 Y76.692 E.01893
G1 X76.681 Y76.96
G1 X77.351 Y77.63 E.01864
G1 X77.211 Y78.048
G1 X76.498 Y77.334 E.01985
G1 X76.462 Y77.855
G1 X77.208 Y78.602 E.02076
G1 X77.208 Y79.159
G1 X76.462 Y78.413 E.02076
G1 X76.462 Y78.971
G1 X77.208 Y79.717 E.02076
G1 X77.208 Y80.274
G1 X76.462 Y79.528 E.02076
G1 X76.462 Y80.086
G1 X77.208 Y80.832 E.02076
G1 X77.208 Y81.39
G1 X76.462 Y80.643 E.02076
G1 X76.462 Y81.201
G1 X77.208 Y81.947 E.02076
G1 X77.208 Y82.505
G1 X76.462 Y81.758 E.02076
G1 X76.462 Y82.316
G1 X77.208 Y83.062 E.02076
G1 X77.208 Y83.62
G1 X76.462 Y82.873 E.02076
G1 X76.462 Y83.431
G1 X77.208 Y84.177 E.02076
G1 X77.208 Y84.735
G1 X76.462 Y83.988 E.02076
G1 X76.462 Y84.546
G1 X77.208 Y85.292 E.02076
G1 X77.208 Y85.85
G1 X76.462 Y85.104 E.02076
G1 X76.462 Y85.661
G1 X77.208 Y86.407 E.02076
G1 X77.208 Y86.965
G1 X76.462 Y86.219 E.02076
G1 X76.462 Y86.776
G1 X77.208 Y87.522 E.02076
G1 X77.208 Y88.08
G1 X76.462 Y87.334 E.02076
G1 X76.462 Y87.891
G1 X77.208 Y88.638 E.02076
G1 X77.208 Y89.195
G1 X76.462 Y88.449 E.02076
G1 X76.462 Y89.006
G1 X77.208 Y89.753 E.02076
G1 X77.208 Y90.31
G1 X76.462 Y89.564 E.02076
G1 X76.462 Y90.121
G1 X77.208 Y90.868 E.02076
G1 X77.208 Y91.425
G1 X76.462 Y90.679 E.02076
G1 X76.462 Y91.236
G1 X77.208 Y91.983 E.02076
G1 X77.208 Y92.54
G1 X76.462 Y91.794 E.02076
G1 X76.462 Y92.352
G1 X77.208 Y93.098 E.02076
G1 X77.208 Y93.655
G1 X76.462 Y92.909 E.02076
G1 X76.462 Y93.467
G1 X77.208 Y94.213 E.02076
G1 X77.208 Y94.77
G1 X76.462 Y94.024 E.02076
G1 X76.462 Y94.582
G1 X77.249 Y95.369 E.02189
; WIPE_START
M204 S6000
G1 X76.462 Y94.582 E-.21146
G1 X76.462 Y94.024 E-.10593
G1 X76.695 Y94.257 E-.06261
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.273 Y95.166 Z6.36 F18000
G1 X90.631 Y95.928 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X91.168 Y96.465 E.01493
G1 X90.785 Y96.639
G1 X90.073 Y95.928 E.01979
G1 X89.516 Y95.928
G1 X90.262 Y96.674 E.02076
G1 X89.705 Y96.674
G1 X88.958 Y95.928 E.02076
G1 X88.401 Y95.928
M73 P98 R0
G1 X89.147 Y96.674 E.02076
G1 X88.59 Y96.674
G1 X87.843 Y95.928 E.02076
G1 X87.286 Y95.928
G1 X88.032 Y96.674 E.02076
G1 X87.475 Y96.674
G1 X86.728 Y95.928 E.02076
G1 X86.171 Y95.928
G1 X86.917 Y96.674 E.02076
G1 X86.36 Y96.674
G1 X85.613 Y95.928 E.02076
G1 X85.056 Y95.928
G1 X86.884 Y97.756 E.05087
; WIPE_START
M204 S6000
G1 X85.47 Y96.342 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.453 Y98.882 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X84.498 Y95.928 E.08218
G1 X83.941 Y95.928
G1 X87.587 Y99.574 E.10144
G1 X87.593 Y100.138
G1 X86.108 Y98.653 E.0413
G1 X86.43 Y99.532
G1 X87.527 Y100.63 E.03052
G1 X87.408 Y101.067
G1 X86.445 Y100.105 E.02678
G1 X86.363 Y100.581
G1 X87.243 Y101.46 E.02446
G1 X87.043 Y101.818
G1 X86.203 Y100.978 E.02335
G1 X85.994 Y101.326
G1 X86.81 Y102.143 E.02271
G1 X86.547 Y102.436
G1 X85.738 Y101.628 E.02249
G1 X85.436 Y101.884
G1 X86.252 Y102.699 E.02268
G1 X85.926 Y102.931
G1 X85.083 Y102.088 E.02345
G1 X84.677 Y102.24
G1 X85.561 Y103.124 E.02459
G1 X85.164 Y103.284
G1 X84.199 Y102.319 E.02684
G1 X83.613 Y102.29
G1 X84.726 Y103.403 E.03096
G1 X84.232 Y103.467
G1 X82.675 Y101.911 E.04329
; WIPE_START
M204 S6000
G1 X84.09 Y103.325 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.269 Y97.814 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X83.383 Y95.928 E.05246
G1 X82.825 Y95.928
G1 X84.403 Y97.505 E.04389
G1 X83.828 Y97.488
G1 X82.268 Y95.928 E.04341
G1 X81.71 Y95.928
G1 X83.36 Y97.577 E.04588
G1 X82.959 Y97.733
G1 X82.015 Y96.79 E.02625
G1 X81.755 Y97.088
G1 X82.609 Y97.941 E.02374
G1 X82.309 Y98.199
G1 X81.496 Y97.386 E.02261
G1 X81.237 Y97.684
G1 X82.057 Y98.504 E.02282
G1 X81.846 Y98.851
G1 X81.007 Y98.012 E.02335
G1 X80.81 Y98.373
G1 X81.701 Y99.263 E.02477
G1 X81.621 Y99.741
G1 X80.65 Y98.77 E.02701
G1 X80.532 Y99.21
G1 X81.65 Y100.328 E.03109
G1 X82.036 Y101.271
G1 X80.474 Y99.709 E.04345
G1 X80.484 Y100.277
G1 X83.658 Y103.45 E.08827
G1 X82.947 Y103.298
G1 X80.638 Y100.988 E.06424
; WIPE_START
M204 S6000
G1 X82.052 Y102.402 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.899 Y96.674 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X81.153 Y95.928 E.02076
G1 X80.595 Y95.928
G1 X81.342 Y96.674 E.02076
G1 X80.784 Y96.674
G1 X80.038 Y95.928 E.02076
G1 X79.48 Y95.928
G1 X80.227 Y96.674 E.02076
G1 X79.669 Y96.674
G1 X78.923 Y95.928 E.02076
G1 X78.365 Y95.928
G1 X79.111 Y96.674 E.02076
G1 X78.554 Y96.674
G1 X77.76 Y95.88 E.02209
G1 X77.996 Y96.674
G1 X76.462 Y95.139 E.04269
G1 X76.478 Y95.713
G1 X77.423 Y96.658 E.0263
; WIPE_START
M204 S6000
G1 X76.478 Y95.713 E-.25401
G1 X76.462 Y95.139 E-.10901
G1 X76.525 Y95.202 E-.01698
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.328 Y89.271 Z6.36 F18000
G1 X91.025 Y77.294 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233131
G1 F1500
M204 S6000
G1 X91.073 Y77.254 E.00065
; LINE_WIDTH: 0.274905
G1 X91.122 Y77.215 E.00078
; LINE_WIDTH: 0.316678
G1 X91.17 Y77.175 E.00091
; LINE_WIDTH: 0.358452
G1 X91.219 Y77.136 E.00104
; LINE_WIDTH: 0.40149
G1 X91.267 Y77.096 E.00117
G1 X91.23 Y77.028 E.00146
G1 X91.069 Y76.869 E.00423
; LINE_WIDTH: 0.377742
G1 X90.62 Y76.515 E.01004
; WIPE_START
G1 X91.069 Y76.869 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.671 Y83.108 Z6.36 F18000
G1 X77.643 Y95.915 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.172231
G1 F1500
M204 S6000
G1 X77.361 Y95.667 E.00274
; LINE_WIDTH: 0.169879
G1 X77.272 Y95.551 E.00105
; LINE_WIDTH: 0.19608
G1 X77.183 Y95.435 E.00125
; WIPE_START
G1 X77.272 Y95.551 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X78.248 Y96.647 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0887151
G1 F1500
M204 S6000
G1 X78.069 Y96.674 E.00057
; WIPE_START
G1 X78.248 Y96.647 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X76.922 Y96.467 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0837299
G1 F1500
M204 S6000
G1 X76.636 Y96.181 E.00117
; WIPE_START
G1 X76.922 Y96.467 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.407 Y101.775 Z6.36 F18000
G1 X82.612 Y101.973 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.211682
G1 F1500
M204 S6000
G1 X82.306 Y101.698 E.00382
G1 X81.969 Y101.338 E.00458
; WIPE_START
G1 X82.306 Y101.698 E-.20709
G1 X82.612 Y101.973 E-.17291
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.429 Y103.086 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0920831
G1 F1500
M204 S6000
G1 X82.318 Y103.007 E.00045
; LINE_WIDTH: 0.134469
G1 X82.152 Y102.875 E.00115
; LINE_WIDTH: 0.181207
G1 X81.986 Y102.742 E.00165
; LINE_WIDTH: 0.233367
G1 X81.539 Y102.327 E.00632
G1 X81.252 Y102.017 E.00437
; LINE_WIDTH: 0.19718
G1 X81.118 Y101.853 E.00181
; LINE_WIDTH: 0.15586
G1 X80.983 Y101.69 E.00137
; LINE_WIDTH: 0.119668
G1 X80.918 Y101.6 E.00052
; LINE_WIDTH: 0.0885945
G1 X80.852 Y101.51 E.00035
; WIPE_START
G1 X80.918 Y101.6 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.919 Y103.318 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0756408
G1 F1500
M204 S6000
G1 X84.749 Y103.403 E.00047
; WIPE_START
G1 X84.919 Y103.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.399 Y101.101 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0781503
G1 F1500
M204 S6000
G1 X87.311 Y101.249 E.00045
; WIPE_START
G1 X87.399 Y101.101 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.526 Y100.024 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0892188
G1 F1500
M204 S6000
G1 X86.444 Y99.825 E.00068
; WIPE_START
G1 X86.526 Y100.024 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.172 Y98.589 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.18335
G1 F1500
M204 S6000
G1 X85.806 Y98.17 E.00438
G1 X85.58 Y97.955 E.00245
; LINE_WIDTH: 0.199075
G1 X85.334 Y97.748 E.00278
; WIPE_START
G1 X85.58 Y97.955 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.275 Y98.398 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0945576
G1 F1500
M204 S6000
G1 X87.187 Y98.274 E.00052
; LINE_WIDTH: 0.133663
G1 X87.099 Y98.161 E.00077
; LINE_WIDTH: 0.168889
G1 X87.012 Y98.049 E.00102
; LINE_WIDTH: 0.215105
G1 X86.821 Y97.819 E.00282
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X87.012 Y98.049 E-.38
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

