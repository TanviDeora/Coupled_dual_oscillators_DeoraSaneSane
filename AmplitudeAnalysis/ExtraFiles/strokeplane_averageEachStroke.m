function [rotated_r, angle, angle_all, v1, v2]=strokeplane_averageEachStroke(r)
%tranformation to the mean stroke plane to calcuate the wing ampltiude
%written by Tanvi Deora on 7 June, 2013
%edited by Tanvi on 9 Sept, 2020
%r, the input, the points in fly coordinate system
%rotated_r, the output, is the points all rotated along the pitch axis such
%that the approximate stroke plane is the xy plane. 

%Find the (sort of) stroke plane that can be used as the refernce plane for calculating amplitudes
%find 2 vectors, v1 and v2 which will lie in this reference plane 

[t_max, t_min] = wing_position_ForStrokePlane(r);

%[~, elev, ~]= cart2sph(r(:,1), r(:,2), r(:,3));

%[~,max_variable] = max(elev);
%[~, min_variable] = min(elev);

v1=[r(t_max,1),r(t_max,2),r(t_max,3)];
v2=[r(t_min,1),r(t_min,2),r(t_min,3)];

%find the normal to this plane
n_all=cross(v2,v1);

%find the angle that this vector, n makes with unitz (the normal to the
%body plane) given by the cos inverse of the dot product of n and unitz
angle_all = zeros(1,length(n_all))*nan;
for aa=1:size(n_all)
    n = n_all(aa,:);
    angle_all(aa)=acos(n(3)/sqrt(sum(n.^2)));
end
angle= mean(angle_all);

% coordinates are transformed (rotated) from the body plane to this plane
% through this angle
s=size(r);
M=[1 0 0; 0 cos(angle) sin(angle); 0 -sin(angle) cos(angle)];
for j=1:s(1,1)
    for i=1:3:s(1,2)
        A=M*[r(j,i),r(j,i+1),r(j,i+2)]';
        rotated_r(j,i)=A(1);
        rotated_r(j,i+1)=A(2);
        rotated_r(j,i+2)=A(3);
    end
end
