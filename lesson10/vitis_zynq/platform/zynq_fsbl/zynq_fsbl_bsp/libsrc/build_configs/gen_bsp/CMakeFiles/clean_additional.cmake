# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/diskio.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/ff.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/ffconf.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/sleep.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/xilffs.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/xilffs_config.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/xilrsa.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/xiltimer.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/include/xtimer_config.h"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/lib/libxilffs.a"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/lib/libxilrsa.a"
  "/home/sdongles/work/robotdreams/fpga_course_rd/lesson10/vitis_zynq/platform/zynq_fsbl/zynq_fsbl_bsp/lib/libxiltimer.a"
  )
endif()
