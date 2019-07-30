function [crawldata,stamp_index,date]=process_crawl_shua(crawldata)
row=numel(crawldata);   
% row = 625
% 625 x 1 struct with 11 fields
%% delete time1=nan rows
for i=row:-1:1
    if isnan(crawldata(i).time1)
        crawldata(i)=[];
        disp("NA in time1");
    end
end
row=numel(crawldata);
%% divide time stamp into 2 parts
% crawl data used to have 11 fields, now it has 13 fields (date, time added)
for i=1:row
    crawldata(i).date=str2double(crawldata(i).time_stamp(1:8));
    crawldata(i).time=str2double(crawldata(i).time_stamp(10:15));
end
%% add eventnumber
row=numel(crawldata);
crawldata(1).event=1;   
% initialized first row's event = 1, others have []
% now, has 14 fields
for i=2:row
    if strcmp(crawldata(i-1).time_stamp,crawldata(i).time_stamp)==1&&crawldata(i-1).animal==crawldata(i).animal
        crawldata(i).event=crawldata(i-1).event;
    else
        crawldata(i).event=crawldata(i-1).event+1;
    end
end

%% delete too-shortly-recorded (< one bin cycle) animals
time1=[crawldata(1).time1];
shortevent=[];
for i=2:row
    if crawldata(i).event==crawldata(i-1).event
        time1=[time1;crawldata(i).time1];
    else
        % ASK JIAYI WHAT THIS MEANS!%
        if min(time1)==max(time1) && crawldata(i-1).tsize<15
            shortevent=[shortevent,crawldata(i-1).event]; 
            %store the shortly recorded events in the array
        end
        time1=[crawldata(i).time1];
    end
end
%store the last event
if min(time1)==max(time1)
	shortevent=[shortevent,crawldata(row).event];
end
sind=length(shortevent);
shortevent(2,:)=1:sind;

%% If shortevent is not empty,
if isempty(shortevent)==0
    for i=row:-1:1
        if crawldata(i).event==shortevent(1,sind)
            if i==1
                crawldata(i)=[];
                break
            elseif crawldata(i-1).event<crawldata(i).event
                crawldata(i)=[];
                sind=sind-1;
            if sind==0
                break
            end
        else
            crawldata(i)=[];
            end
        elseif crawldata(i).event>shortevent(1,sind)
            crawldata(i).event=crawldata(i).event-shortevent(2,sind);    
        end
    end
end
row=numel(crawldata);
eventnumber=crawldata(row).event;

%% record date and divide time stamp
date_ori=arrayfun(@(x) crawldata(x).date,1:row);
date=unique(date_ori);
time_ori=arrayfun(@(x) crawldata(x).time,1:row);
[time,ia,~]=unique(time_ori);
stamp_index=arrayfun(@(x) crawldata(x).event,unique(ia));
stamp_index=[stamp_index;eventnumber+1];


end