"""Prototype dimensions in millimetres. Every tool/phone fit value is provisional.

Coordinates: local X points from the square shaft toward the phone, local Y
points toward the phone's charging edge, and local Z points toward its cameras.
The actual grabber shaft is parallel to this model's Z; the rendered assembly
maps local Z to the project convention's positive Y.
"""

from dataclasses import dataclass


@dataclass(frozen=True)
class Parameters:
    # MEASURE: bare phone or chosen case, including button and camera bump.
    phone_width: float = 72.0
    phone_length: float = 147.0
    phone_thickness: float = 9.0
    phone_fit_clearance: float = 0.7
    phone_end_clearance: float = 0.8
    button_y: float = -81.0       # From charging edge; select volume-up.
    button_z: float = 5.0         # From underside of supported phone.
    button_travel: float = 0.45   # MEASURE; limit mechanically before use.

    # MEASURE: four flats and any ribs on the stock silver square neck.
    neck_width: float = 16.0
    neck_clearance: float = 0.5   # Add thin non-adhesive TPU/rubber shims.
    neck_clamp_length: float = 44.0
    neck_center_y: float = -10.0
    claw_clearance: float = 25.0  # Minimum verified gap at full claw sweep.
    handle_station_z: float = -380.0  # MEASURE axial distance from phone mount.
    trigger_tab_z: float = -435.0     # MEASURE on moving black paddle.
    shaft_visible_low_z: float = -405.0   # Display envelope only.
    shaft_visible_high_z: float = 75.0
    handle_anchor_reach: float = 72.0  # MEASURE to fixed stop beyond trigger.
    trigger_tab_x: float = -42.0       # MEASURE moving trigger attachment.

    rail_width: float = 7.0
    rail_x: float = 20.0
    rail_adjustment: float = 3.0  # Right rail screw slots, +/- from nominal.
    pad_height: float = 1.5
    lip_overlap: float = 2.0
    cable_housing_od: float = 5.0   # MEASURE ferrule; nominal brake housing.
    cable_wire_od: float = 1.6
    pivot_clearance: float = 3.2
    m3_clearance: float = 3.4
    m4_clearance: float = 4.4

    @property
    def phone_left(self) -> float:
        return self.rail_x + self.rail_width + self.phone_fit_clearance / 2

    @property
    def right_rail_x(self) -> float:
        return self.phone_left + self.phone_width + self.phone_fit_clearance / 2
