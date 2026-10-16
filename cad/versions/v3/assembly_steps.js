// Each frame is an assembly state, not a validated continuous insertion path.
export function assemblySteps(){
 const steps=[],jaw=[],actuator=[],installed=[];
 const add=(title,text,names,{bench=false,group=installed}={})=>{group.push(...names);steps.push({title,text,visible:[...group],added:names,bench});};
 add('Fixed jaw — off the grabber','Start with the fixed jaw/carrier on your work surface.',['carrier'],{bench:true,group:jaw});
 add('Slide the moving jaw into its track','Insert the sliding tongue from the open end of the fixed-jaw track.',['sliding_jaw'],{bench:true,group:jaw});
 for(let i=1;i<=2;i++)add(`Fit jaw band ${i}`,'Loop the band around the two broad angular cleats, stacking bands beneath their retaining lips. Adjust band count or wrapping after checking free jaw travel; grip force needs physical testing.',['band_jaw_'+i],{bench:true,group:jaw});
 add('Flat-back actuator bracket — off the grabber','Build the actuator separately. The mounting plate and spine share a flat back; the mounting bore sits 4.4 mm off the plunger centerline. Keep the blended support, nut recess and plunger channel clean.',['actuator_bracket'],{bench:true,group:actuator});
 add('Insert the plunger','Feed the cleat end from the button end through the open guides; leave the rounded shoe outside.',['plunger'],{bench:true,group:actuator});
 add('Fit pulley and smooth axle','Place the wheel on the raised single bearing boss, then insert the headed axle from the open side. The head retains the wheel; the outer fork is removed. Check the nominal 1 mm axial clearance and free rotation.',['pulley','pulley_axle'],{bench:true,group:actuator});
 add('Retain the axle outside the flat back','Use the 20.6 mm axle. Slide the cross-key through its outboard slot from the pulley-support end (local +Z insertion), then loop the small keeper band around the key and axle. No rear pocket remains; retention sits 2.2 mm farther outboard. The key takes axial retention; the band resists key drift. Check both physically.',['pulley_key','band_keeper'],{bench:true,group:actuator});
 add('Inspect the integral button shoe','The broad shoe is part of the plunger; no contact screw is needed. Check alignment and released clearance before applying tension.',['plunger'],{bench:true,group:actuator});
 add('Fit the plunger return band','Loop the band beneath the fixed retaining lip and around the shared moving cleat. Verify free return.',['band_return'],{bench:true,group:actuator});
 add('Tie the twine to the plunger','Wrap under the shared cleat cap, in front of the return band, and tie back to the standing line. Leave the long free end for routing.',['twine_attachment'],{bench:true,group:actuator});
 add('Place the assembled jaws against the neck','Bring the preassembled jaw unit onto the neck from the side; do not thread the grabber through it.',['stock_neck_context',...jaw]);
 add('Close with the shaft cap','Bring the cap and its flush-T rail wings onto the opposite side. The solid middle is not a screw slot. Align all four collar fastener holes.',['shaft_cap']);
 for(let i=1;i<=4;i++){
  add(`Insert collar screw ${i}`,'Insert the printed screw through the matching carrier and cap holes.',['clamp_screw_'+i]);
  add(`Fit collar nut ${i}`,'Start by hand. Tighten opposing pairs gradually and evenly; preserve a parallel split without forcing the plastic.',['clamp_nut_'+i]);
 }
 add('Position the actuator','With the fastener removed, align the mounting bore with the selected rail wing slot and seat the flat bracket face against the rail. Reverse the conservative removal path: approach 2 mm below, raise, then seat. No rail locating lugs. Staged states, not insertion animations.',actuator);
 add('Insert the single rail screw','Insert the screw through the selected rail slot and central closed bracket bore. The solid rail center cannot be crossed.',['rail_screw_1']);
 add('Fit the single actuator nut','Fit the nut by hand and clamp the bracket against the rail. Screw preload and surface friction alone resist sliding and rotation; verify loaded retention physically before use.',['rail_nut_1']);
 add('Fit the phone','Open the T-shaped moving jaw and seat the phone against both outer pads and the fixed central pad. For the opposite button side, turn the phone end-for-end in its screen plane. Verify the integral shoe leaves the button released at rest; confirm safe button travel before tensioning.',['phone_envelope','phone_volume_up']);
 for(let i=1;i<=3;i++){
  add(i===1?'Fit the Duel captive guide':`Fit centered captive guide ${i-1}`,'Place the open guide sideways around the neck at the shown station.',['guide_'+i]);
  add(`Retain guide ${i} with its band`,'Loop the retaining band around the guide hooks.',['band_guide_'+i]);
 }
 add('Route the twine','Wrap around the pulley and run directly to the selected left/right eye of the nearest shaft guide, then through both centered guides. No holes or intermediate bends on the actuator bracket.',['twine','stock_neck','stock_blue_brace']);
 add('Attach at the trigger','Join the upper and lower twine sections with an inline band along the neck; tie the lower section to the moving trigger. Adjust slack and preload with the actual bands.',['stock_blue_handle','stock_blue_grip','stock_black_trigger','stock_trigger_pivot','band_overtravel','twine_trigger']);
 add('Check the complete assembly','Check jaw grip, parallel collar closure, button release, safe force, twine travel and camera framing before loaded use. Assembly states are illustrative; fit and forces need physical testing.',['stock_claws','stock_black_foot_-1','stock_black_foot_1']);
 return steps;
}
