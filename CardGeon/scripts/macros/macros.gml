// Script assets have changed for v2.3.0 see
#macro EFFECTS -9999
#macro CAM view_camera
#macro ASPECT 640/360;

#macro _CAM_LEFT camera_get_view_x(view_camera[0])
#macro _CAM_TOP camera_get_view_y(view_camera[0])
#macro _CAM_RIGHT camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])
#macro _CAM_BOT camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])
#macro _CAM_WIDTH camera_get_view_width(view_camera[0])
#macro _CAM_HEIGHT camera_get_view_height(view_camera[0])

#macro I "Instances"
#macro MX mouse_x
#macro MY mouse_y

#macro SEC game_get_speed(gamespeed_fps)


#macro C_ARMOR make_color_rgb(168, 168, 168)
#macro C_GRAY make_color_rgb(208, 208, 208)
#macro C_GUM make_color_rgb(248, 16, 88)
#macro C_WINE make_color_rgb(153, 18, 87)
#macro C_RED make_color_rgb(248, 0, 0)
#macro C_CAPE make_color_rgb(168, 8, 51)
#macro C_PINK make_color_rgb(255,50,197)
#macro C_BROWN make_color_rgb(93,44,40)
#macro C_LIME  make_color_rgb(45 ,255,63)
#macro C_YELLOW make_color_rgb(248, 248, 0)
#macro C_PURPLE make_color_rgb(167, 69,  233)
#macro C_AQUA make_color_rgb(10, 246, 250)
#macro C_FUCHISIA make_color_rgb(255,53,253) 
#macro C_BLUE make_color_rgb(27, 183, 214 )
#macro C_LAVENDER make_color_rgb(157, 168, 224)
#macro C_RAINBOW make_color_hsv(current_time*0.1 mod 255,120,250)
#macro C_NAVY make_color_rgb(29, 54, 153)
#macro C_ORANGE make_color_rgb(214, 124, 35)
#macro C_DARK make_color_rgb(26,25,50)

#macro C_BLACK make_color_rgb(0,0,0)