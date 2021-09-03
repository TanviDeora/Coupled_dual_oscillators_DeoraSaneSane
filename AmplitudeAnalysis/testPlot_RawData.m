figure
hold on
% plot all the variables 
% right in red
% left in black
% and head-thorax joint in blue
plot3([0, 1], [0, 0], [0,0], '-g')
plot3([0, 0], [0, 1], [0,0], '-c')
plot3([0, 0], [0,0], [0, 1], '-k')
plot3(pointsInFlyCoordinates.headJoint(:,1), pointsInFlyCoordinates.headJoint(:,2), pointsInFlyCoordinates.headJoint(:,3), 'o-b')
plot3(pointsInFlyCoordinates.rightwingBase(:,1), pointsInFlyCoordinates.rightwingBase(:,2), pointsInFlyCoordinates.rightwingBase(:,3), 'o-k')
plot3(pointsInFlyCoordinates.rightwingTip(:,1), pointsInFlyCoordinates.rightwingTip(:,2), pointsInFlyCoordinates.rightwingTip(:,3), 'o-k')
plot3(pointsInFlyCoordinates.leftwingBase(:,1), pointsInFlyCoordinates.leftwingBase(:,2), pointsInFlyCoordinates.leftwingBase(:,3), 'o-r')
plot3(pointsInFlyCoordinates.leftwingTip(:,1), pointsInFlyCoordinates.leftwingTip(:,2), pointsInFlyCoordinates.leftwingTip(:,3), 'o-r')

plot3(pointsInFlyCoordinates.lefthaltereTip(:,1), pointsInFlyCoordinates.lefthaltereTip(:,2), pointsInFlyCoordinates.lefthaltereTip(:,3), 'o-b')
plot3(pointsInFlyCoordinates.righthaltereTip(:,1), pointsInFlyCoordinates.righthaltereTip(:,2), pointsInFlyCoordinates.righthaltereTip(:,3), 'o-m')