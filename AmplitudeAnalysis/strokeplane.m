function [rotated_r, angle]=strokeplane(r)
%tranformation to the mean stroke plane to calcuate the wing ampltiude
%written by Tanvi Deora on 7 June, 2013
%r, the input, the points in fly coordinate system
%rotated_r, the output, is the points all rotated along the pitch axis such
%that the approximate stroke plane is the xy plane. 

%Find the the (sort of) stroke plane that can be used as the refernce plane for calculating amplitudes
%find 2 vectors, v1 and v2 which will lie in this reference plane 
% [q, theta,phi]= cartspher(r(:,1), r(:,2), r(:,3));
% max_variable= theta == max(theta);
% min_variable= theta == min(theta);
% v1=[r(max_variable,1),r(max_variable,2),r(max_variable,3)];
% v2=[r(min_variable,1),r(min_variable,2),r(min_variable,3)];
%find the normal to this plane
% n=cross(v2,v1);
%find the angle that this vector, n makes with unitz (the normal to the
%body plane) given by the cos inverse of the dot product of n and unitz
% angle=acos(n(3)/sqrt(sum(n.^2)));
angle=79.3847*(pi/180);

% coordinates are transformed (rotated) from the body plane to this plane
% through this "angle"
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
