figure;
plot3(-rotated.LW(:,1), rotated.LW(:,2), rotated.LW(:,3), 'r')
hold on
plot3(rotated.RW(:,1), rotated.RW(:,2), rotated.RW(:,3), 'k')
plot3(rotated.RH(:,1), rotated.RH(:,2), rotated.RH(:,3), 'b')
plot3(-rotated.LH(:,1), rotated.LH(:,2), rotated.LH(:,3), 'm')
plot3([0, 1], [0, 0], [0,0], '-g')
plot3([0, 0], [0, 1], [0,0], '-c')
plot3([0, 0], [0,0], [0, 1], '-k')