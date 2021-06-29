% load the body coordinate data

clear all;
% treatment = 'haltere_loading';
% treatment = 'epi_ridge_cut';
% treatment = 'asymmetric_wings';
treatment = 'Slit_sc';

path_for_data_org_file = fullfile('../dataFolder/AmplitudeAnalysis/v1', treatment, 'TransformedData/');
list = dir(fullfile(path_for_data_org_file,'*.mat'));

outpath = fullfile('../dataFolder/AmplitudeAnalysis/v1', treatment, 'Kinematics/');

for f = 1:length(list)
    clear 'fields' 'new_bodyparts' 'strokePlane' 'rotated' 'theta' 'azimuth' 'wba'
    load(fullfile(list(f).folder, list(f).name));
    
    flyID = list(f).name(1:end-4);
    disp(flyID)

    fields = fieldnames(bodyparts);
    
    % check if any of the bodyparts start with a NaN and trim it off if
    % needed
    new_bodyparts = TrimEdgesofNaN(bodyparts);
   
    % % use both left and right to define stroke plane
    % [rotated.LW, rotated.RW, strokePlane.wings] = strokeplane_bothWings(bodyparts.LW, bodyparts.RW);
    % [rotated.LH, rotated.RH, strokePlane.halteres] = strokeplane_bothWings(bodyparts.LH, bodyparts.RH);
    
    % use suppination and pronation vectors to define stroke plane
    for i=1:length(fields)
        disp(fields(i))
        [rotated.(fields{i}), strokePlane.(fields{i})] = strokeplane_averageEachStroke(new_bodyparts.(fields{i}));
    end

    % get the wing projection on stroke plane and amplitude 
    fields = fieldnames(rotated);
    for k = 1:length(fields)
        disp(fields{k})
        [~, theta.(fields{k}), ~] = cart2sph(bodyparts.(fields{k})(:,1), bodyparts.(fields{k})(:,2), bodyparts.(fields{k})(:,3));
        [azimuth.(fields{k}), t_max, t_min]= wing_position(rotated.(fields{k}));
        l = length(rotated.(fields{k}));
        [wba.(fields{k})] = amplitude(t_max, t_min, azimuth.(fields{k}), 1, l);
    end
    
    flyname = strcat(flyID, '_Kinematics.mat');
    fullfilepath = fullfile(outpath, flyname);
    save(fullfilepath, 'strokePlane', 'rotated', 'theta', 'azimuth', 'wba')
    % figure;
    % plot(azimuth.LW*180/pi, 'b-o')
    % hold on
    % plot(azimuth.RW*180/pi, 'r-o')
    % plot(azimuth.RH*180/pi, 'r-*')
    % plot(azimuth.LH*180/pi, 'b-*')
    % 
    % figure;
    % plot(theta.LW*180/pi, 'b-o')
    % hold on
    % plot(theta.RW*180/pi, 'r-o')
    % plot(theta.RH*180/pi, 'r-*')
    % plot(theta.LH*180/pi, 'b-*')
end

