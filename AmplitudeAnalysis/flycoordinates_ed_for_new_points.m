% the xyz points file (raw data file) should be named data when loaded.
% point 1 = origin as well as the point used to define the xy plane
% point 2 = left wing base
% point 3 = right wing base
S =size(data);
% t is the translated points matrix
%to translate the all points(x y z) to point1(x y z) in data file
for i=1:3:S(1,2);
    for j=1:S(1,1);
    t(j,i)= data(j,i)-data(j,1);
    end
end

for i=2:3:S(1,2);
    for j=1:S(1,1);
    t(j,i)= data(j,i)-data(j,2);
    end
end

for i=3:3:S(1,2);
    for j=1:S(1,1);
    t(j,i)= data(j,i)-data(j,3);
    end
end

%to rotate the axis around the x y axis
%find the unit vector in x dir
%point 2 and 3 define the x direction vector
for j=1:S(1,1);
    xdir(j,:)=[t(j,7)-t(j,4), t(j,8)-t(j,5), t(j,9)-t(j,6)];
    %x=[data(1,4), data(1,5), data(1,6)];
    u(j)= norm(xdir(j,:));
    unitx(j,:)=xdir(j,:)/u(j);
end
%find the unit vector in y dir

for j=1:S(1,1);
    %normal to the plane xy is obtained by cross product of line joining
    %points 2&3 and 2&1
    %line23(j,:)=[t(j,7)-t(j,4), t(j,8)-t(j,5), t(j,9)-t(j,6)];
    line21(j,:)=[t(j,4)-t(j,1), t(j,5)-t(j,2), t(j,6)-t(j,3)];
    n(j,:)=cross(xdir(j,:),line21(j,:));
    %y is then obtained by cross product of normal and xdir vector
    ydir(j,:)=cross(n(j,:),xdir(j,:));
    v(j)= norm(ydir(j,:));
    unity(j,:)=ydir(j,:)/v(j);
end

%find the unit vector in z dir
for i=1:S(1,1)
    k(i) = norm(n(i,:));
    unitz(i,:)=n(i,:)/k(i);
end

% r is the final matrix with points in flycoordinate axis
for i = 1:3:S(1,2)
    for j=1:S(1,1)
    R = [unitx(j,1), unity(j,1), unitz(j,1); unitx(j,2), unity(j,2),
    unitz(j,2); unitx(j,3), unity(j,3), unitz(j,3)];
    q = inv(R)*[t(j,i);t(j,i+1);t(j,i+2)];
    r(j,i)= q(1,1);
    r(j,i+1)= q(2,1);
    r(j,i+2)= q(3,1);
    end
end

S=size(r);

for i=1:S(1,1);
    lw(i,1)= r(i,10)-r(i,4);
    lw(i,2)= r(i,11)-r(i,5);
    lw(i,3)= r(i,12)-r(i,6);
    rw(i,1)= r(i,13)-r(i,7);
    rw(i,2)= r(i,14)-r(i,8);
    rw(i,3)= r(i,15)-r(i,9);
    lh(i,1)= r(i,22)-r(i,16);
    lh(i,2)= r(i,23)-r(i,17);
    lh(i,3)= r(i,24)-r(i,18);
    rh(i,1)= r(i,25)-r(i,19);
    rh(i,2)= r(i,26)-r(i,20);
    rh(i,3)= r(i,27)-r(i,21);
    [r_lw(i) theta_lw(i) phi_lw(i)]= cartspher(lw(i,1),lw(i,2),lw(i,3));
    [r_rw(i) theta_rw(i) phi_rw(i)]= cartspher(rw(i,1),rw(i,2),rw(i,3));
    [r_lh(i) theta_lh(i) phi_lh(i)]= cartspher(lh(i,1),lh(i,2),lh(i,3));
    [r_rh(i) theta_rh(i) phi_rh(i)]= cartspher(rh(i,1),rh(i,2),rh(i,3));
end