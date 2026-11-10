"""Rigid first-contact phone/cuff seating for the V4 display, without TPU deformation."""
import math
from functools import lru_cache
from cuff_design import CUFF_Z
from build_preview import FIXED_CUFF_DROP


def _tilted(shape,p):
    pivot=(p.phone_right,0,18-p.phone_thickness/2)
    return shape.rotate(pivot,(pivot[0],1,pivot[2]),math.degrees(math.asin(FIXED_CUFF_DROP/p.phone_width))).translate((0,0,CUFF_Z-FIXED_CUFF_DROP-pivot[2]))


def _first_contact(moving,fixed,max_shift=10):
    """Approach from the open side, stopping at undeformed-surface tangency."""
    lo,hi=0.,max_shift
    assert moving.val().distance(fixed.val())>1e-5
    assert moving.translate((hi,0,0)).val().distance(fixed.val())<1e-5
    for _ in range(24):
        mid=(lo+hi)/2
        if moving.translate((mid,0,0)).val().distance(fixed.val())>1e-5:lo=mid
        else:hi=mid
    return lo


@lru_cache(None)
def seating(p):
    from model import stock,locate_cuff,cuff,SLIDING_CUFF_X
    angle=math.degrees(math.asin(FIXED_CUFF_DROP/p.phone_width))
    info=dict(tilt_about_y_deg=angle,fixed_edge_center_z_mm=CUFF_Z-FIXED_CUFF_DROP,
              sliding_edge_center_z_mm=CUFF_Z,sliding_edge_x_gap_mm=p.phone_width*(1-math.cos(math.radians(angle))),
              original_center_z_mm=18-p.phone_thickness/2,phone_x_shift_mm=0.,sliding_jaw_closure_mm=0.,
              contact_solved=p.phone_thickness<=13.44,
              note='Thin-phone rigid first contact at all three cuff surfaces; no TPU deformation/preload simulated. 18/20 mm examples remain incompatible.')
    if info['contact_solved']:
        phone=_tilted(stock(p)['phone_envelope'],p)
        fixed=locate_cuff(cuff(),p.phone_right,0,True).translate((0,0,-FIXED_CUFF_DROP))
        info['phone_x_shift_mm']=_first_contact(phone,fixed)
        phone=phone.translate((info['phone_x_shift_mm'],0,0))
        sliding=locate_cuff(cuff(),p.phone_left+SLIDING_CUFF_X,-50,False)
        info['sliding_jaw_closure_mm']=_first_contact(sliding,phone)
    return info


def seat_phone(shape,p):
    return _tilted(shape,p).translate((seating(p)['phone_x_shift_mm'],0,0))
