camera_get_view_width(view_camera[0])

x1 = camera_get_view_width(view_camera[0]) / 2;
y1 = camera_get_view_height(view_camera[0]) - 100;
x2 = camera_get_view_width(view_camera[0]) / 2;
y2 = camera_get_view_height(view_camera[0]);

x1Target = 0;
x2Target = camera_get_view_width(view_camera[0]);

lerpProgress = 0;
textProgress = 0;

responseSelected = 0;
