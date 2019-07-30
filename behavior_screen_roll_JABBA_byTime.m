% Rolling and crawling combination
function behavior_screen_roll_JABBA_byTime
timestamp='20190307_150925'; % adapt
genotype='GMR_SS43207@UAS_Chrimson_attp18_72F11@t93@r_LED05_45s2x30s30s#n#n#n@100';
value=2;
% genotype: should be in a format like 'Basin4@UAS_Chrimson@t94@r_LED10_45s2x30s30s#n#n#n@100'
% timestamp: should be in a format like 20180410_131723
% value: 2 = fast crawling and rolling, 4 = fast crawling, rolling, turning and hunching

%% read name for the genotype
[driver,effector,tracker,protocol,times]=read_name(genotype);
waiting=times.waiting;
circles=times.circles;
stimdur=times.stimdur;
stimint=times.stimint;

stimspec=stimdur+stimint;
%%
process_behavior_file_byTime(driver,effector,tracker,protocol,value,timestamp);
crawldata=[];
rolldata=[];
turndata=[];
hunchdata=[];
load(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\matlab_file\original_behavior\',genotype,'.mat')); %adapt
%%
name=strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\matlab_file\figure\',genotype);%adapt
name(name=='.')=[];
%% Create the time axis
    eventnumber=crawldata(end).event;
    timespec=waiting+circles*stimspec;
    timeres=0.2;
    timeframe =floor(timespec/timeres)+1;
    time=timeres*[0:timeframe-1];

%% count the tracked animal number and select roller and non-roller
[RollerEvent,NRollerEvent,TrkedEvent]=count_tracked_animals(rolldata,eventnumber,timeframe,timeres);
trkedevent=sum(TrkedEvent);
%% Stack crawl events
[events,fevents,~,~,~,~,base_crawl_ampl]=stack_crawl(crawldata,timeframe,timeres,waiting);
%% Stack roll events
[revents,~]=stack_events(rolldata,timeframe,timeres);
%%
roll_prob=nan(1,timeframe);
roll_u=nan(1,timeframe);
for i=1:timeframe
    [roll_prob(i),roll_u(i)]=bernuli(TrkedEvent(:,i),revents(:,i));
end
roll_CI=2*roll_u;
%% behavior patterns in stamp
fig=figure;
hold on
%%
for i=1:circles
    f=fill([waiting+(i-1)*(stimdur+stimint),waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)],[0,0,100,100],'k');
    f.FaceAlpha=0.1;
    f.EdgeColor='none';
end
%plot_with_errorbar_JAABA(time,100*roll_prob,100*roll_CI,[1 0 0])
L(1)=plot(time,100*roll_prob);
% JAABA
[JAABAx,JAABAy,comeback]=load_JAABA(driver,effector,tracker,protocol,timestamp);
L(2)=plot(JAABAx,100*JAABAy);
%
xlim([waiting-15 timespec]);
ylim([0,100]);
head=strrep(strcat(driver,'@',effector,'@',protocol),'_','-');
timestamp=strrep(timestamp,'_','-');
title({head,timestamp})
ylabel('Rolling (%)');
xlabel('time (s)')
box on
legend(L,{'Feature Extraction','JAABA'})

cd (comeback)
print(fig,strcat(name,'@rolls_FE_JAABA_',strrep(timestamp,'-','_')),'-painters','-dpdf');

%close
%%
end
