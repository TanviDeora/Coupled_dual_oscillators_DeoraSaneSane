function [new_bodyparts] = TrimEdgesofNaN(bodyparts)
fields = fieldnames(bodyparts);

for i=1:length(fields)
    start.(fields{i}) = find(~any(isnan(bodyparts.(fields{i})),2),1,'first');
    stop.(fields{i}) = find(~any(isnan(bodyparts.(fields{i})),2),1,'last');
    
    
%     % get the positions of NaNs
%     r = find(isnan(bodyparts.(fields{i})(:,1)));
%     
%     if isempty(r) 
%         [edge.(fields{i})] = 1;
%     elseif length(r) == 1
%         if r == 1
%            [edge.(fields{i})] = 2;
%         else
%            [edge.(fields{i})] = 1;
%         end
%     else
%     % find the gaps between the NaNs and trim to the first largest gap
%         gaps = r(2:end) - r(1:end-1);
%         % first gap
%         b = find( gaps > 1, 1 );
%         if isempty(b)
%             e = r(end) + 1; %just remove the NaNs and start with next index
%         else
%             e = b - 1; %get the index just before the NaN
%         end
%         [edge.(fields{i})] = e;
%     end
end

start_index = max(cell2mat(struct2cell(start)));
stop_index = min(cell2mat(struct2cell(stop)));

for i=1:length(fields)
    new_bodyparts.(fields{i}) = bodyparts.(fields{i})(start_index:stop_index,:);
end
