figure;
plot3(bodyparts.LW(:,1), bodyparts.LW(:,2), bodyparts.LW(:,3));
hold on
plot3(bodyparts.RW(:,1), bodyparts.RW(:,2), bodyparts.RW(:,3));
plot3(bodyparts.LH(:,1), bodyparts.LH(:,2), bodyparts.LH(:,3));
plot3(bodyparts.RH(:,1), bodyparts.RH(:,2), bodyparts.RH(:,3));
plot3(0,0,0, 'o')
legend('left wing', 'right wing', 'left haltere', 'right haltere')
