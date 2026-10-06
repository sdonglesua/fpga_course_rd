# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/include/sleep.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/include/xiltimer.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/include/xtimer_config.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/ps7_cortexa9_0/standalone_ps7_cortexa9_0/bsp/lib/libxiltimer.a"
  )
endif()
