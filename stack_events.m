%% Stack rolling events 
function [events,starttime]=stack_events(data,timeframe,timeres)
eventnumber=data(end).event;
events=zeros(eventnumber,timeframe);
starttime=zeros(eventnumber,timeframe);
row=numel(data);
mark=behavior_pattern(data);
switch mark
    case 'R'
        ampl='rampl';
        beg='rbeg';
        dur='rdur';
    case 'T'
        ampl='tampl';
        beg='tbeg';
        dur='tdur';
    case 'H'
        ampl='hampl';
        beg='hbeg';
        dur='hdur';
end
for i=1:row
    if isnan(data(i).(ampl))==0
        sta = floor(data(i).(beg)/timeres)+1;
        ending = floor((data(i).(beg)+data(i).(dur))/timeres)+1;
        if ~isnan(sta)&~isnan(ending)
        events(data(i).event,sta:ending)=ones(1,ending-sta+1);
        starttime(data(i).event,sta) = 1; 
        end
    end
end
 events=events(1:eventnumber,1:timeframe);
 starttime=starttime(1:eventnumber,1:timeframe); 
end