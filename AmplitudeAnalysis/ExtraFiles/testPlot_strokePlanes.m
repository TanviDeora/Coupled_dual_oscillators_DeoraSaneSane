figure;
plot3(bodyparts.RW(:,1), bodyparts.RW(:,2), bodyparts.RW(:,3), 'k')
hold on
plot3(-bodyparts.LW(:,1), bodyparts.LW(:,2), bodyparts.LW(:,3), 'r')
% plot3(bodyparts.RH(:,1), bodyparts.RH(:,2), bodyparts.RH(:,3), 'k')
% plot3(bodyparts.LH(:,1), bodyparts.LH(:,2), bodyparts.LH(:,3), 'r')


[r_rw, angle_rw, angle_all_rw, v1_rw, v2_rw] = strokeplane_averageEachStroke_FlipAxis(bodyparts.RW);
n_all_rw = cross(v2_rw, v1_rw);
[r_lw, angle_lw, angle_all_lw, v1_lw, v2_lw] = strokeplane_averageEachStroke_FlipAxis(bodyparts.LW);
n_all_lw = cross(v2_lw, v1_lw);
% [r_rh, angle_rh, angle_all_rh, v1_rh, v2_rh] = strokeplane_averageEachStroke_FlipAxis(bodyparts.RH);
% n_all_rh = cross(v2_rh, v1_rh);
% [r_lh, angle_lh, angle_all_lh, v1_lh, v2_lh] = strokeplane_averageEachStroke_FlipAxis(bodyparts.LH);
% n_all_lh = cross(v2_lh, v1_lh);

plot3(v2_rw(:,1), v2_rw(:,2), v2_rw(:,3), 'oy')
plot3(v1_rw(:,1), v1_rw(:,2), v1_rw(:,3), 'ob')
plot3(n_all_rw(:,1)/10, n_all_rw(:,2)/10, n_all_rw(:,3)/10, 'ok')

plot3(v2_lw(:,1), v2_lw(:,2), v2_lw(:,3), 'oy')
plot3(v1_lw(:,1), v1_lw(:,2), v1_lw(:,3), 'ob')
plot3(n_all_lw(:,1)/10, n_all_lw(:,2)/10, n_all_lw(:,3)/10, 'or')



% plot3(v2_rh(:,1), v2_rh(:,2), v2_rh(:,3), 'oy')
% plot3(v1_rh(:,1), v1_rh(:,2), v1_rh(:,3), 'ob')
% 
% plot3(v2_lh(:,1), v2_lh(:,2), v2_lh(:,3), 'oy')
% plot3(v1_lh(:,1), v1_lh(:,2), v1_lh(:,3), 'ob')

plot3([0, 1], [0, 0], [0,0], '-g')
plot3([0, 0], [0, 1], [0,0], '-c')
plot3([0, 0], [0,0], [0, 1], '-k')
