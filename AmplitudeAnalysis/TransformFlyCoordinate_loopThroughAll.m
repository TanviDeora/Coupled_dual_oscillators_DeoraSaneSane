clear all;
%treatment = 'haltere_loading';
%treatment = 'epi_ridge_cut';
%treatment = 'asymmetric_wings';
treatment = 'Slit_sc';

path_for_data_org_file = fullfile('../dataFolder/Digitization_Final_Data/', treatment);
list = dir(fullfile(path_for_data_org_file,'fly*/**/*xyzpts.csv'));

outpath = fullfile('C:\Users\Tanvi\Documents\GitHub\Coupled_Dual-oscillator_DeoraSane\dataFolder\AmplitudeAnalysis\v1',...
    treatment, 'TransformedData');
figpath = fullfile('C:\Users\Tanvi\Documents\GitHub\Coupled_Dual-oscillator_DeoraSane\dataFolder\AmplitudeAnalysis\v1',...
    treatment, 'TransformedData\Figure');

% full_path_for_data_org = fullfile(path_for_data_org_file, 'data_organization_epi.txt');
% full_path_for_data_org = fullfile(path_for_data_org_file, 'data_organization_asym.txt');
full_path_for_data_org = fullfile(path_for_data_org_file, 'data_organization_sc.txt');
% full_path_for_data_org = fullfile(path_for_data_org_file, 'data_organization_halt.txt');

for i =1:length(list)
    data = importfile(fullfile(list(i).folder, list(i).name));
    [pointsInFlyCoordinates, bodyparts, experiment] = Transform_FlyCoordinates(data, full_path_for_data_org); 
    
    
    parts = fieldnames(bodyparts);
    f = figure;
    for k=1:numel(parts)
    %     hold off
        p = bodyparts.(parts{k});
        [azi, elev, r] = cart2sph(p(:,1), p(:,2), p(:,3));
        figure(f)
        plot(elev*180/pi);
        hold on
    end
    
    legend(parts)
    nn = split(list(i).name, '_');
    figname = strcat(nn{1}, '_' ,nn(2), '_' ,nn{3}, '.fig');
    
    fullfigpath = fullfile(figpath,figname);
    saveas(f, fullfigpath{1});
%     saveas(f, 'test');
    clf(f)
    close(f)
    
    flyname = strcat(nn{1}, '_' ,nn(2), '_' ,nn{3}, '.mat');
    fullfilepath = fullfile(outpath, flyname);
    save(fullfilepath{1}, 'pointsInFlyCoordinates', 'bodyparts')
end



