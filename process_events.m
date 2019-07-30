function rolldata=process_events(rolldata,crawldata)
    rrow = numel(rolldata);
    %% delete time1=nan rows
for i=rrow:-1:1
    if isnan(rolldata(i).time1)
        rolldata(i)=[];
    end
end

%%
    rrow = numel(rolldata);
    row = numel(crawldata);
    crawlind=row;
    rolldata(rrow).event=[];
    for i=rrow:-1:1
        for j=crawlind:-1:1
            if strcmp(rolldata(i).time_stamp,crawldata(j).time_stamp)==1&&rolldata(i).animal==crawldata(j).animal
                rolldata(i).event=crawldata(j).event;
                rolldata(i).date=crawldata(j).date;
                rolldata(i).time=crawldata(j).time;
                crawlind=j;
                break
            end
        end
        if isempty(rolldata(i).event)
            rolldata(i)=[];
        end
    end
    rrow=numel(rolldata);
    for i=rrow-1:-1:1
        if rolldata(i).event~=rolldata(i+1).event&&rolldata(i).event~=rolldata(i+1).event-1
            rolldata(i)=[];
        end
    end
end