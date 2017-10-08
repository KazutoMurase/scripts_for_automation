#!/usr/bin/env python
import cv2
import numpy as np
import pyscreenshot

_TEMPLATE_FILE_PATH='/path/to/template_app_image.png'

img = cv2.cvtColor(np.array(pyscreenshot.grab()),
                   cv2.COLOR_RGB2GRAY)
template = cv2.imread(_TEMPLATE_FILE_PATH, 0)
res = cv2.matchTemplate(img,template,cv2.TM_CCOEFF)
_, _, _, max_loc = cv2.minMaxLoc(res)
exit(max_loc)
