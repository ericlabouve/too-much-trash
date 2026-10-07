// Each frame is an assembly state, not a validated continuous insertion path.
export function assemblySteps(){
 const steps=[],jaw=[],actuator=[],installed=[];
 const add=(title,text,names,{bench=false,group=installed}={})=>{group.push(...names);steps.push({title,text,visible:[...group],added:names,bench});};
 add('Fixed jaw — off the grabber','Start with the fixed jaw/carrier on your work surface.',['carrier'],{bench:true,group:jaw});
 add('Slide the moving jaw into its track','Insert the sliding tongue from the open end of the fixed-jaw track.',['sliding_jaw'],{bench:true,group:jaw});
 for(let i=1;i<=2;i++)add(`Fit jaw band ${i}`,'Loop the band around the two broad angular cleats, stacking bands beneath their retaining lips. Adjust band count or wrapping after checking free jaw travel; grip force needs physical testing.',['band_jaw_'+i],{bench:true,group:jaw});
 add('Actuator bracket — off the grabber','Build the actuator separately before attaching it to the shaft-cap rail.',['actuator_bracket'],{bench:true,group:actuator});
 add('Place the rocker in the fork','Align the rocker keyway with the bracket bearing holes.',['rocker'],{bench:true,group:actuator});
 add('Insert and retain the pivot','Align the cross-tab with the keyways, insert with 3.4 mm overtravel, turn a quarter-turn, then pull back until the head seats at its indexing ledge.',['pivot_key'],{bench:true,group:actuator});
 add('Inspect the integral button shoe','The broad shoe is part of the rocker; no contact screw is needed. Check alignment and released clearance before applying tension.',['rocker'],{bench:true,group:actuator});
 add('Fit the rocker return band','Loop between the moving rocker anchor and fixed bracket hook. Check free return between both stops.',['band_return'],{bench:true,group:actuator});
 add('Tie the twine to the rocker','Pass through the rocker eye, loop around its front ligament, and tie back to the standing line. Leave the long free end for routing.',['twine_attachment'],{bench:true,group:actuator});
 add('Place the assembled jaws against the neck','Bring the preassembled jaw unit onto the neck from the side; do not thread the grabber through it.',['stock_neck_context',...jaw]);
 add('Close with the shaft cap','Bring the cap and integral actuator rail onto the opposite side. Align all four fastener holes.',['shaft_cap']);
 for(let i=1;i<=4;i++){
  add(`Insert collar screw ${i}`,'Insert the printed screw through the matching carrier and cap holes.',['clamp_screw_'+i]);
  add(`Fit collar nut ${i}`,'Start by hand. Tighten opposing pairs gradually and evenly; preserve a parallel split without forcing the plastic.',['clamp_nut_'+i]);
 }
 for(let i=1;i<=2;i++)add(`Insert rail screw ${i}`,'Insert from the clear rail region at Y ±50, then slide to the mounting position. Keep the screw heads behind the rail.',['rail_screw_'+i]);
 add('Attach the assembled actuator','Place the completed actuator over the two rail screws from the outside. Choose the rail end for the phone’s button position.',actuator);
 for(let i=1;i<=2;i++)add(`Fit actuator rail nut ${i}`,'Fit the nut loosely, align the bracket, then secure both nuts evenly.',['rail_nut_'+i]);
 add('Fit the phone','Open the T-shaped moving jaw and seat the phone against both outer pads and the fixed central pad. For the opposite button side, turn the phone end-for-end in its screen plane. Verify the integral shoe leaves the button released at rest; confirm safe button travel before tensioning.',['phone_envelope','phone_volume_up']);
 for(let i=1;i<=3;i++){
  add(i===1?'Fit the Duel captive guide':`Fit centered captive guide ${i-1}`,'Place the open guide sideways around the neck at the shown station.',['guide_'+i]);
  add(`Retain guide ${i} with its band`,'Loop the retaining band around the guide hooks.',['band_guide_'+i]);
 }
 add('Route the continuous twine','Feed through the actuator guide, the selected left/right eye of the Duel guide, then both centered guides. Check the line runs freely.',['twine','stock_neck','stock_blue_brace']);
 add('Attach at the trigger','Tie the free line to the overtravel band on the moving trigger. Adjust slack and preload with the actual bands.',['stock_blue_handle','stock_blue_grip','stock_black_trigger','stock_trigger_pivot','band_overtravel']);
 add('Check the complete assembly','Check jaw grip, parallel collar closure, button release, stop contact, twine travel and camera framing before loaded use. Assembly states are illustrative; fit and forces need physical testing.',['stock_claws','stock_black_foot_-1','stock_black_foot_1']);
 return steps;
}
