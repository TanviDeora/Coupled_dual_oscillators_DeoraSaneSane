function [theta_atan, mean_amplitude_p3, amplitude_p1,amplitude_p2,amplitude_p4, amplitude_p5]=wba_fragmenteddata(rotated_r, f1,f2,f3,f4)
% calculates the wing beat amplitude by projecting the wing vector onto the
% body plane and calculates the angle of projected vector wrt to the x axis.
% the inputs are 1) the wing_vector in the fly coordinate system (right hand
% thumb rule) and the frame numbers - 
% 2) f1 = radial stop starts moving over pwp.
% 3) f2 = radial stop moves ahead of pwp edge
% 4) f3 = radial stop starts moving over pwp again
% 5) f4 = radial stop moves away from pwp
% 6) n = wing beat frequency
% output is (added wba_engaged to check the entire vector) 
% 1) max_amplitude of five phases  - 
% p1 - before getting enagged
% p2 - during engagement
% p4 - during disengagement
% p5 - after disengagement
% 2) mean_amplitude_enagaded = mean amplitude when wing is engaged(phase 3)
% written by Tanvi Deora
% edted June, 2013

% calculate number of frames to be ommitted near f2
% f=(3000/n)/2;
% f=round(f);
% incase you dont want the frames to be removed
f=0;
% check if data is fragmented or not
wing_vector=[rotated_r(:,1),rotated_r(:,2),rotated_r(:,3)];
A=find(isnan(wing_vector(:,1)));
B=find(A);

% if not fragmented, analyize the entire thing 
if isempty(B)
    [theta_atan, t_max, t_min] = wing_position(wing_vector);
    
    %finding wba only for the frames where wing is engaged
    [wba_engaged]=amplitude(t_max,t_min,theta_atan,f2+f,f3);
    
    % calculate the amplitites in five diff phase
    % p1 - before getting enagged
    % p2 - during engagement
    % p3 - after engagement
    % p4 - during disengagement
    % p5 - after disengagement

    mean_amplitude_p3= mean(wba_engaged);
    max_amplitude_p3= max(wba_engaged);

    m1=max(theta_atan(1:f1)); 
    m2=min(theta_atan(1:f1));
    amplitude_p1 = (m1-m2)*(180/pi);

    m1=max(theta_atan(f1:f2-f));
    m2=min(theta_atan(f1:f2-f));
    amplitude_p2=(m1-m2)*(180/pi);
    
    m1=max(theta_atan(f3:f4)); 
    m2= min(theta_atan(f3:f4));
    amplitude_p4=(m1-m2)*(180/pi);

    m1 = max(theta_atan(f4:end)); 
    m2 = min(theta_atan(f4:end));
    amplitude_p5=(m1-m2)*(180/pi);
    
%  if fragmented then cut it into two parts
else S1=A(1,1)-1;
    S2=A(end,1)+1;

    [theta_atan1, t_max1, t_min1]= wing_position(wing_vector(1:S1,:));
    [theta_atan2, t_max2, t_min2] = wing_position(wing_vector(S2:end,:));
    
    %calculate amplitudes for theta_atan1 & 2 bit
     [wba_engaged1]=amplitude(t_max1, t_min1,theta_atan1, f2+f, S1);
     [wba_engaged2]=amplitude(t_max2, t_min2,theta_atan2, 1, f3-S2);
    

    % calculate the amplitites in five diff phase
    % p1 - before getting enagged
    % p2 - during engagement
    % p3 - after engagement
    % p4 - during disengagement
    % p5 - after disengagement

    m1=max(theta_atan1(1:f1)); 
    m2=min(theta_atan1(1:f1));
    amplitude_p1 = (m1-m2)*(180/pi);

    m1=max(theta_atan1(f1:f2-f));
    m2=min(theta_atan1(f1:f2-f));
    amplitude_p2=(m1-m2)*(180/pi);

    mean_amplitude_p3= mean([wba_engaged1 wba_engaged2]);
    max_amplitude_p3= max([wba_engaged1 wba_engaged2]);

    m1=max(theta_atan2(f3-S2:f4-S2)); 
    m2= min(theta_atan2(f3-S2:f4-S2));
    amplitude_p4=(m1-m2)*(180/pi);

    m1 = max(theta_atan2(f4-S2:end)); 
    m2 = min(theta_atan2(f4-S2:end));
    amplitude_p5=(m1-m2)*(180/pi);
    
    X=NaN*ones(length(B),1);
    theta_atan=[theta_atan1 X' theta_atan2];
    
end