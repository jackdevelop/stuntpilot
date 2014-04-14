
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 1
DEBUG_FPS = true
DEBUG_MEM = true

-- design resolution
CONFIG_SCREEN_WIDTH  = 960
CONFIG_SCREEN_HEIGHT = 640 

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT" 
--[[
当设置了 FIXED_HEIGHT 后，任何分辨率下 display.height 都应该是 640，只有 display.width 会按比例变化
UI 应该按 960 做，这样在更大的屏幕上只是稍微散开一点，不会出现摆不下的情况
]]

--CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT_ON_SMALL_SCREEN"
--CONFIG_SCREEN_AUTOSCALE = "FIXED_HEIGHT_PRIOR" --按坐标1024 * 768

--设置横屏 竖屏
--DEVICE_ORIENTATION      = "landscape"