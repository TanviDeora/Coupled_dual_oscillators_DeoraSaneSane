function pointsInFlyCoordinates = TransformToFlyCoordinates(data)

%tdata = importdata(file,',',1);
%data = tdata.data;

% the xyz points file (raw data file) should be named data when loaded.
% point 1 = left wing tip
% point 2 = left wing base
% point 3 = point on thorax
% point 4 = point on abdomen
% point 5 = point on scutellum
wingTipOld = [data(:,1),data(:,2),data(:,3)];
wingBaseOld = [data(:,4),data(:,5),data(:,6)];
thoraxOld = [data(:,7),data(:,8),data(:,9)];
abdomenOld = [data(:,10),data(:,11),data(:,12)];
scutellumOld = [data(:,13),data(:,14),data(:,15)];

%Make wing base 0,0,0
wingTipOld2 = wingTipOld-wingBaseOld;
wingBaseOld2 = wingBaseOld-wingBaseOld;
thoraxOld2 = thoraxOld-wingBaseOld;
abdomenOld2 = abdomenOld-wingBaseOld;
scutellumOld2 = scutellumOld-wingBaseOld;

%Calculate unit y vector
tUnitY = thoraxOld2-scutellumOld2;

%Calculate unit z vector
tUnitZ = cross((wingBaseOld2-thoraxOld2),(tUnitY));

for i = 1:length(wingTipOld2)
    unitY = tUnitY(i,:)/norm(tUnitY(i,:));
    unitZ = tUnitZ(i,:)/norm(tUnitZ(i,:));
    unitX = cross(unitY,unitZ);
    rotationMatrix = [unitX' unitY' unitZ'];
    %if det(rotationMatrix) ~= 1
    %    det(rotationMatrix
    %    i
    %    break
    %end
    wingTipNew(i,:) = (rotationMatrix \ wingTipOld2(i,:)')';
    wingBaseNew(i,:) = (rotationMatrix \ wingBaseOld2(i,:)')';
    thoraxNew(i,:) = (rotationMatrix \ thoraxOld2(i,:)')';
    abdomenNew(i,:) = (rotationMatrix \ abdomenOld2(i,:)')';
    scutellumNew(i,:) = (rotationMatrix \ scutellumOld2(i,:)')';
end

pointsInFlyCoordinates.wingTip = wingTipNew;
pointsInFlyCoordinates.wingBase = wingBaseNew;
pointsInFlyCoordinates.thorax = thoraxNew;
pointsInFlyCoordinates.abdomen = abdomenNew;
pointsInFlyCoordinates.scutellum = scutellumNew;
