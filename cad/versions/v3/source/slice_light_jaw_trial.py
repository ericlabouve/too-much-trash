"""Matched standalone lightening trial, preserving approved bed face."""
import json,sys,shutil
from pathlib import Path
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
source=plate.ROOT/'review/light-sliding-jaw-wide'
shutil.copy2(source/'geometry.json',source/'fit-attachment-check.json')
plate.SOURCE=source
plate.PARTS={'sliding_jaw':((90,90),'Z',90,'Approved beam face down; XY rotation only.')}
plate.main()
review.OUT=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
review.main(project_stem='cuff-fit',title='Sliding jaw · wider window trial',detail_parts=['sliding_jaw'])
