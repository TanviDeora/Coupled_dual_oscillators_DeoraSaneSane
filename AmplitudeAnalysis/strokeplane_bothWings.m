function [rotated_left, rotated_right, mean_sPlane]=strokeplane_bothWings(left, right)
%tranformation to the mean stroke plane to calcuate the wing ampltiude
%written by Tanvi Deora on 22 September, 2020
%left and right wing/haltere are the input, the points in fly coordinate system
%rotated_left and rotated_right, the output, is the points all rotated along the pitch axis such
%that the approximate stroke plane is the xy plane. 

%Finds the stroke plane: defined as the plane that contains the both the left and 
% right wings. We calculate the stroke plane as the average of all stroke
% planes. This can be used to project the wings/haltere onto, to calculate amplitude


%find the normal to the plane containing the left and right vectors,
%cross right to left to get a normal
%poitning in the positive z direction

n=cross(right,left);

%find the angle that this vector, n makes with unitz (the normal to the
%body plane) given by the cos inverse of the dot product of n and unitz

stroke_plane = zeros(length(n),1)*nan;
for i=1:length(n)
    stroke_plane(i)=acos(n(i,3)/sqrt(sum(n(i,:).^2)));
end

mean_sPlane = mean(stroke_plane);

% coordinates are transformed (rotated) from the body plane to this plane
% through this "angle"
s=size(left);
M=[1 0 0; 0 cos(mean_sPlane) sin(mean_sPlane); 0 -sin(mean_sPlane) cos(mean_sPlane)];
for j=1:s(1,1)
    for i=1:3:s(1,2)
        A=M*[left(j,i),left(j,i+1),left(j,i+2)]';
        rotated_left(j,i)=A(1);
        rotated_left(j,i+1)=A(2);
        rotated_left(j,i+2)=A(3);
        
        B=M*[right(j,i),right(j,i+1),right(j,i+2)]';
        rotated_right(j,i)=B(1);
        rotated_right(j,i+1)=B(2);
        rotated_right(j,i+2)=B(3);
    end
end