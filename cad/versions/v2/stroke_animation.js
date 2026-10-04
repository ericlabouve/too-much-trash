// Timing only: actual rocker angle and twine geometry still come from pose().
export const CYCLE_MS=8600;
export function cycleStroke(elapsed,stopFraction){
 const t=((elapsed%CYCLE_MS)+CYCLE_MS)%CYCLE_MS;
 const stop=Math.max(0,Math.min(1,stopFraction));
 const keys=[[0,0],[400,0],[2000,stop],[3600,1],[4500,1],[6200,stop],[8000,0],[CYCLE_MS,0]];
 for(let i=1;i<keys.length;i++){
  const [end,b]=keys[i], [start,a]=keys[i-1];
  if(t<=end){const u=(t-start)/(end-start),smooth=u*u*(3-2*u);return a+(b-a)*smooth;}
 }
 return 0;
}
