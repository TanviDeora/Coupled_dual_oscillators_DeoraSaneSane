function [r]=flycoordinates_ed_for_amits_data(data)
% this is a function which converts points from a global
% coordinate system to an insect coordinate system
% written by Tanvi Deora, edited June 2013
% this has been edited from what was written for my own tethered flight
% digitizations for Amit's data.

% the xyz points file (raw data file) should be named data when loaded.
% point 1 = left wing tip
% point 2 = left wing base
% point 3 = point on thorax
% point 4 = point on abdomen
% point 5 = point on scutellum

S =size(data);

% t is the translated points matrix
% to translate the all points(x y z) to point2(x y z) in data file
for i=1:3:S(1,2);
    for j=1:S(1,1);
    t(j,i)= data(j,i)-data(j,4);
    end
end

for i=2:3:S(1,2);
    for j=1:S(1,1);
    t(j,i)= data(j,i)-data(j,5);
    end
end

for i=3:3:S(1,2);
for j=1:S(1,1);
    t(j,i)= data(j,i)-data(j,6);
end
end

% to rotate the axis around the x y axis

% find the unit vector in y dir
% point 3 and 5 define the y direction vector
for j=1:S(1,1); 
ydir(j,:)=[t(j,7)-t(j,13), t(j,8)-t(j,14), t(j,9)-t(j,15)];
v(j)= norm(ydir(j,:));
unity(j,:)=ydir(j,:)/v(j);
end

% find the unit vector in x dir
for j=1:S(1,1);
    %normal to the plane xy is obtained by cross product of line joining
    %points 3&5 and 3&2
    line32(j,:)=[t(j,4)-t(j,7), t(j,5)-t(j,8), t(j,6)-t(j,9)];
    n(j,:)=cross(line32(j,:),ydir(j,:));
    %x is then obtained by cross product of normal and ydir vector
    xdir(j,:)=cross(ydir(j,:),n(j,:));
    u(j)= norm(xdir(j,:));
    unitx(j,:)=xdir(j,:)/u(j);
end 

%find the unit vector in z dir
for j=1:S(1,1)
    k(j) = norm(n(j,:));
    unitz(j,:)=n(j,:)/k(j);
end

% r is the final matrix with points in flycoordinate axis
for i = 1:3:S(1,2)
    for j=1:S(1,1)
R = [unitx(j,1), unity(j,1), unitz(j,1); unitx(j,2), unity(j,2), unitz(j,2); unitx(j,3), unity(j,3), unitz(j,3)];
q = inv(R)*[t(j,i);t(j,i+1);t(j,i+2)];
    r(j,i)= q(1,1);
    r(j,i+1)= q(2,1);
    r(j,i+2)= q(3,1);
    end
end
    
wing_vector = [r(:,1), r(:,2), r(:,3)]; 