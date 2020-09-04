% for iRow = 1:height(t)
%     disp(t{iRow, 1})
%     disp(t{iRow, 2})
%     
%     % ... do work on r(iRow,:) ...
% end

tcell = table2array(t(:,1));
% tmat = [];
% ind = 1;
% for i=1:height(t)
%     tmat(ind) = tcell{i};
%     ind = ind + 1;
% end
    
fields = tcell;
c = cell(length(fields),1);
s = cell2struct(c,fields);

for irow = 1:length(tcell)
    ind = newTable{tcell{irow}, 'Var1'};
    s.tcell{irow} = [data(:,ind*3-2),data(:, ind*3 - 1), data(:, ind*3)];
end