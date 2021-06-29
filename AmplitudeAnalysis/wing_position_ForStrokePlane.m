function [t_max, t_min]=wing_position_ForStrokePlane(wing_vector)

% calculate the wing position(in angles wrt to x axis) on the body plane
% elev is the elevation angle wing makes with the unit z axis (yaw 
% axis).  

[~, elev, ~] = cart2sph(wing_vector(:,1), wing_vector(:,2), wing_vector(:,3));
l=length(wing_vector);
% mark every wing stroke and calculate the maxima point within each storke 
% pass a highpass filter to the data to remove any offset 
time = 1:length(elev);
[b,a]=butter(10,0.03,'high');
data_filt=filtfilt(b,a,elev);
% z is the cubicspline fit to elev
z=fit(time', data_filt, 'cubicspline');

clear C
clear c
clear x
%find the interval in which to find zero
%finds the point right before zero and right 
%after zero i.e interval in the rising pahse
b=1;
for i=1:0.5:l-1
 if z(i-0.5)<0 && z(i+0.5)>0
        c(b)=i;
        b=b+1;
  end
end

%find zeros in the ineterval
b=1;
for i=1:length(c)-1
    if c(i+1)-c(i)<1
        C(b,1)=c(i+1);
        C(b,2)=c(i);
        b=b+1;
    end
end

new_C = floor(C);
% find the index of the minima and maxima in each cycle
% t_max and t_min are the index where you find the maxima and minima for each storke

clear i
b=1;
t_max=[];
t_min=[];
for i=1:length(new_C)-1
s=find(elev(new_C(i,2):new_C(i+1,2))== max(elev(new_C(i,2):new_C(i+1,2))));
t=find(elev(new_C(i,2):new_C(i+1,2))== min(elev(new_C(i,2):new_C(i+1,2))));
t_max(b)= new_C(i,2)+s-1;
t_min(b)= new_C(i,2)+t-1;
b=b+1; 
end