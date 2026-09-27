"""R4 dimensions in mm. Local XYZ maps to project (X, Z, -Y).

Local Z runs toward claws; local Y runs away from charging edge.
Measured inputs are separated from provisional engineering settings.
"""
from dataclasses import dataclass

@dataclass(frozen=True)
class Parameters:
    # Confirmed physical samples; see reference/measurements.md.
    neck_x: float = 14
    neck_y: float = 19  # project Z
    available_shaft: float = 200
    phone_w: float = 76
    phone_l: float = 152
    phone_t: float = 18
    button_from_end: float = 105
    button_from_screen: float = 6
    actuator_side: str = "far"  # near or far relative to shaft; same printed module
    # PROVISIONAL same-print adjustment envelope, not model compatibility.
    width_min: float = 66
    width_max: float = 86
    thickness_min: float = 7.5
    thickness_max: float = 20
    button_min: float = 80
    button_max: float = 125
    # Geometry shared by every phone setting.
    groove_x: float = 24
    phone_mid_z: float = 14
    pad_normal: float = 0.8
    pad_x_allowance: float = 0.8  # flat side-pad thickness; verify compressed fit
    rear_face_z: float = 25.2  # shared rear datum on .8 mm pads
    module_x_offset: float = 2
    neck_cx: float = -23
    neck_cy: float = 40
    neck_clearance: float = 0.6  # total per axis, includes thin compliant shim
    m3: float = 3.4
    m4: float = 4.5
    ferrule: float = 5.6  # MEASURE selected housing ferrule
    wire: float = 2.2
    # Actuation assumptions to calibrate on a dummy before fitting phone.
    rest_gap: float = 0.35
    safe_button_stroke: float = 0.30  # NOT an Apple specification
    return_torque_nmm: float = 5
    return_rate_nmm_rad: float = 30  # provisional torsion rate
    spring_initial_n: float = 1.5
    spring_rate_n_mm: float = 0.055
    spring_od: float = 8  # provisional spring envelope
    spring_free_eye_mm: float = 35
    spring_rated_extension_mm: float = 45
    handle_z: float = -370  # provisional station relative to phone band

    @property
    def phone_left(self):
        return self.groove_x + self.pad_x_allowance

    @property
    def jaw_x(self):
        return self.groove_x + self.phone_w + 2*self.pad_x_allowance

    @property
    def phone_bottom(self):
        return self.rear_face_z-self.phone_t

    @property
    def button_z(self):
        return self.phone_bottom+self.button_from_screen

    @property
    def actuator_shift(self):
        return 2*self.phone_mid_z-self.button_z-7

    @property
    def phone_y0(self):
        return self.neck_cy-self.phone_l/2

    @property
    def button_y(self):
        return self.phone_y0+self.button_from_end

    @property
    def phone_x_sum(self):
        return 2*self.phone_left+self.phone_w

    @property
    def cable_face_x(self):
        return self.neck_cx-self.neck_x/2-8

    def validate(self):
        for v, lo, hi, label in ((self.phone_w,self.width_min,self.width_max,'width'),
                (self.phone_t,self.thickness_min,self.thickness_max,'thickness'),
                (self.button_from_end,self.button_min,self.button_max,'button location')):
            if not lo <= v <= hi:
                raise ValueError(f'{label} {v} outside same-print range {lo}..{hi}')
        if not 0 < self.button_from_screen < self.phone_t:
            raise ValueError('Button must lie within phone thickness')
        if not 9 <= self.button_z <= 26:
            raise ValueError('Button center exceeds actuator height adjustment')
        if self.phone_l < self.button_from_end+12:
            raise ValueError('Button/module too close to far end')
        if self.actuator_side not in ('near','far'):
            raise ValueError('Actuator side must be near or far')
        if not 65 <= self.button_y <= 105:
            raise ValueError('Centered grip needs button center 25–65 mm toward camera end from midpoint')
        if self.neck_x <= 0 or self.neck_y <= 0:
            raise ValueError('Invalid measured shaft')

SAMPLES = {
    'wallet': Parameters(),
    'bare': Parameters(phone_w=70.6,phone_l=146.6,phone_t=8.25,
                       button_from_end=102,button_from_screen=4.25),
}
