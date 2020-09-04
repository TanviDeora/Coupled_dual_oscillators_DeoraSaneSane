function [pointsInFlyCoordinates, bodyparts, experiment] = Transform_FlyCoordinates(data, path_for_data_org_file)
% edited by Tanvi Deora on 09/03/2020 for coupled oscillator data for
% amplitude analysis
% the xyz points file (raw data file) should be named data when loaded.
% point 1 = 'fixed' : base of head, 
% used as origin as well as the point used to define the xy plane
% point 2 = 'lwbase' : left wing base
% point 3 = 'rwbase' : right wing base
% 


%  read in the data digitizing struture to asign columns to different body parts 
t = readtable(path_for_data_org_file);
bla = t.Properties.VariableNames(2);
experiment = bla{1,1};
newTable = table(t.epi, 'RowNames', t.mode);

ind_fixed = newTable{'fixed', 'Var1'};
FixedOld = cell2mat(table2cell([data(:,ind_fixed*3-2),data(:, ind_fixed*3 - 1), data(:, ind_fixed*3)]));

ind_lwbase = newTable{'lwbase', 'Var1'};
LWingBaseOld = cell2mat(table2cell([data(:,ind_lwbase*3-2),data(:, ind_lwbase*3 - 1), data(:, ind_lwbase*3)]));

ind_rwbase = newTable{'rwbase', 'Var1'};
RWingBaseOld = cell2mat(table2cell([data(:,ind_rwbase*3-2),data(:, ind_rwbase*3 - 1), data(:, ind_rwbase*3)]));

ind_lwapex = newTable{'lwapex', 'Var1'};
LWingTipOld = cell2mat(table2cell([data(:,ind_lwapex*3-2),data(:, ind_lwapex*3 - 1), data(:, ind_lwapex*3)]));

ind_rwapex = newTable{'rwapex', 'Var1'};
RWingTipOld = cell2mat(table2cell([data(:,ind_rwapex*3-2),data(:, ind_rwapex*3 - 1), data(:, ind_rwapex*3)]));

ind_rhbase = newTable{'rhbase', 'Var1'};
RHaltereBaseOld = cell2mat(table2cell([data(:,ind_rhbase*3-2),data(:, ind_rhbase*3 - 1), data(:, ind_rhbase*3)]));

ind_rhapex = newTable{'rhapex', 'Var1'};
RHaltereTipOld = cell2mat(table2cell([data(:,ind_rhapex*3-2),data(:, ind_rhapex*3 - 1), data(:, ind_rhapex*3)]));

ind_lhapex = newTable{'lhapex', 'Var1'};
LHaltereTipOld = cell2mat(table2cell([data(:,ind_lhapex*3-2),data(:, ind_lhapex*3 - 1), data(:, ind_lhapex*3)]));

ind_lhbase = newTable{'lhbase', 'Var1'};
LHaltereBaseOld = cell2mat(table2cell([data(:,ind_lhbase*3-2),data(:, ind_lhbase*3 - 1), data(:, ind_lhbase*3)]));

% S =size(data);

% t is the translated points matrix
% %to translate the all points to fixed point - head base
FixedTrans = FixedOld - FixedOld;
LWingBaseTrans = LWingBaseOld - FixedOld;
LWingTipTrans = LWingTipOld - FixedOld;
RWingBaseTrans = RWingBaseOld - FixedOld;
RWingTipTrans = RWingTipOld - FixedOld;
LHaltereBaseTrans = LHaltereBaseOld - FixedOld;
LHaltereTipTrans = LHaltereTipOld - FixedOld;
RHaltereBaseTrans = RHaltereBaseOld - FixedOld;
RHaltereTipTrans = RHaltereTipOld - FixedOld;

%to rotate the axis around the x y axis
%find the unit vector in x dir
%point left and right wing base define the x direction vector
xdir = RWingBaseTrans - LWingBaseTrans;
u= vecnorm(xdir, 2, 2);
unitx = xdir./u;

%find the unit vector in y dir
%normal to the plane xy is obtained by cross product of line joining
%xdir and line joining left wing base and fixed point
vecPlane = FixedTrans - LWingBaseTrans;
vecNormal = cross(xdir, vecPlane);
%y is then obtained by cross product of normal and xdir vector
ydir=cross(vecNormal,xdir);
u= vecnorm(ydir, 2, 2);
unity=ydir./u;

%find the unit vector in z dir
k = norm(vecNormal);
unitz = vecNormal./k;

FixedNew = zeros(size(FixedTrans))*nan;
LWingBaseNew = zeros(size(FixedTrans))*nan;
RWingBaseNew = zeros(size(FixedTrans))*nan;
LWingTipNew = zeros(size(FixedTrans))*nan;
RWingTipNew = zeros(size(FixedTrans))*nan;
LHaltereBaseNew = zeros(size(FixedTrans))*nan;
RHaltereBaseNew = zeros(size(FixedTrans))*nan;
LHaltereTipNew = zeros(size(FixedTrans))*nan;
RHaltereTipNew = zeros(size(FixedTrans))*nan;

for i = 1:length(FixedTrans)
    rotationMatrix = [unitx(i, :)' unity(i, :)' unitz(i, :)'];
    
    FixedNew(i,:) = rotationMatrix\FixedTrans(i,:)';
    LWingBaseNew(i,:) = rotationMatrix\LWingBaseTrans(i,:)';
    RWingBaseNew(i,:) = rotationMatrix\RWingBaseTrans(i,:)';
    LWingTipNew(i,:) = rotationMatrix\LWingTipTrans(i,:)';
    RWingTipNew(i,:) = rotationMatrix\RWingTipTrans(i,:)';
    LHaltereBaseNew(i,:) = rotationMatrix\LHaltereBaseTrans(i,:)';
    RHaltereBaseNew(i,:) = rotationMatrix\RHaltereBaseTrans(i,:)';
    LHaltereTipNew(i,:) = rotationMatrix\LHaltereTipTrans(i,:)';
    RHaltereTipNew(i,:) = rotationMatrix\RHaltereTipTrans(i,:)';    
end

pointsInFlyCoordinates.headJoint = FixedNew;
pointsInFlyCoordinates.leftwingTip = LWingTipNew;
pointsInFlyCoordinates.rightwingTip = RWingTipNew;
pointsInFlyCoordinates.leftwingBase = LWingBaseNew;
pointsInFlyCoordinates.rightwingBase = RWingBaseNew;
pointsInFlyCoordinates.lefthaltereBase = LHaltereBaseNew;
pointsInFlyCoordinates.righthaltereBase = RHaltereBaseNew;
pointsInFlyCoordinates.lefthaltereTip = LHaltereTipNew;
pointsInFlyCoordinates.righthaltereTip = RHaltereTipNew;

bodyparts.LW = LWingTipNew - LWingBaseNew;
bodyparts.RW = RWingTipNew - RWingBaseNew;
bodyparts.LH = LHaltereTipNew - LHaltereBaseNew;
bodyparts.RH = RHaltereTipNew - RHaltereBaseNew;

%     [r_lw(i) theta_lw(i) phi_lw(i)]= cartspher(lw(i,1),lw(i,2),lw(i,3));
%     [r_rw(i) theta_rw(i) phi_rw(i)]= cartspher(rw(i,1),rw(i,2),rw(i,3));
%     [r_lh(i) theta_lh(i) phi_lh(i)]= cartspher(lh(i,1),lh(i,2),lh(i,3));
%     [r_rh(i) theta_rh(i) phi_rh(i)]= cartspher(rh(i,1),rh(i,2),rh(i,3));
% end