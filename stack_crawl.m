%% Stack crawling events 
function [events,fast_events,base_events,starttime,fstarttime,bstarttime,base_crawl_ampl]=stack_crawl(crawldata,timeframe,timeres,waiting)
    eventnumber=crawldata(end).event;
    row=numel(crawldata);
    events=zeros(eventnumber,timeframe); 
    base_events=zeros(eventnumber,timeframe);
    fast_events=zeros(eventnumber,timeframe);
    starttime=zeros(eventnumber,timeframe);
    fstarttime=zeros(eventnumber,timeframe);
    bstarttime=zeros(eventnumber,timeframe);
    %% set up a baseline for crawling speed
    baseline=[];
    for i=1:row
        if isnan(crawldata(i).ampl)==0 && crawldata(i).time1<=waiting-5 && crawldata(i).beg + crawldata(i).dur>=waiting-5 % adapt
            baseline=[baseline;crawldata(i).ampl];
        end
    end
    base_crawl_ampl=mean(baseline);
    %%
    for i=1:row
        if isnan(crawldata(i).ampl)==0 &&isnan(crawldata(i).beg)==0 && isnan(crawldata(i).dur)==0
            sta = floor(crawldata(i).beg/timeres)+1;
            ending = floor((crawldata(i).beg+crawldata(i).dur)/timeres)+1;
            if crawldata(i).ampl>=1.5*base_crawl_ampl
                fast_events(crawldata(i).event,sta:ending)=ones(1,ending-sta+1);
                fstarttime(crawldata(i).event,sta) = 1;
            else
                base_events(crawldata(i).event,sta:ending)=ones(1,ending-sta+1);
                bstarttime(crawldata(i).event,sta) = 1;
            end
        end
    end
    %%
    fast_events=fast_events(1:eventnumber,1:timeframe);
    base_events=base_events(1:eventnumber,1:timeframe);
    fstarttime=fstarttime(1:eventnumber,1:timeframe);
    bstarttime=bstarttime(1:eventnumber,1:timeframe);
    events=fast_events+base_events;
    starttime=fstarttime+bstarttime;
end