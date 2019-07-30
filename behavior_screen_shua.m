% Rolling and crawling combination
function behavior_screen_shua(genotype,value)
%% read name for the genotype
[driver,effector,tracker,protocol,times]=read_name(genotype);
waiting=times.waiting;
circles=times.circles;
stimdur=times.stimdur;
stimint=times.stimint;
stimspec=stimdur+stimint;
%%
process_behavior_file_shua(driver,effector,tracker,protocol,value);   
crawldata=[];
rolldata=[];
turndata=[];
hunchdata=[];
load(strcat('E:\back_up\mfile\original_behavior\',genotype,'.mat')); %adapt
%%
name=strcat('E:\back_up\hit\',genotype);%adapt
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
%% behavior patterns in stamp
figure3=figure;
subplot(4,1,1)
hold on
%%
fastc_prob=nan(1,timeframe);
fastc_u=nan(1,timeframe);
for i=1:timeframe
    [fastc_prob(i),fastc_u(i)]=bernuli(TrkedEvent(:,i),fevents(:,i));
end
fastc_CI=2*fastc_u;
%%
for i=1:circles
f=fill([waiting+(i-1)*(stimdur+stimint),waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)],[0,0,100,100],'k');
f.FaceAlpha=0.1;
f.EdgeColor='none';
end
plot_with_errorbar(time,100*fastc_prob,100*fastc_CI,[0 0 1]);
xlim([waiting-15 timespec]);
ylim([0,100]);
ylabel('Fast crawling (%)');
xlabel('time (s)')
box off
hold off
%%
subplot(4,1,2)
hold on
%%
roll_prob=nan(1,timeframe);
roll_u=nan(1,timeframe);
for i=1:timeframe
    [roll_prob(i),roll_u(i)]=bernuli(TrkedEvent(:,i),revents(:,i));
end
roll_CI=2*roll_u;

%%
for i=1:circles
f=fill([waiting+(i-1)*(stimdur+stimint),waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)],[0,0,100,100],'k');
f.FaceAlpha=0.1;
f.EdgeColor='none';
end
plot_with_errorbar(time,100*roll_prob,100*roll_CI,[1 0 0])
xlim([waiting-15 timespec]);
ylim([0,100]);
ylabel('Rolling (%)');
xlabel('time (s)')
box off
hold off
%%
subplot(4,1,3)
if ~isempty(turndata)
    %%
    [tevents,~]=stack_events(turndata,timeframe,timeres);
hold on
 for i=1:circles
f=fill([waiting+(i-1)*(stimdur+stimint),waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)],[0,0,100,100],'k');
f.FaceAlpha=0.1;
f.EdgeColor='none';
 end
 %%
turn_prob=nan(1,timeframe);
turn_u=nan(1,timeframe);
for i=1:timeframe
    [turn_prob(i),turn_u(i)]=bernuli(TrkedEvent(:,i),tevents(:,i));
end
turn_CI=2*turn_u;
plot_with_errorbar(time,100*turn_prob,100*turn_CI,[1 0 1])
xlim([waiting-15 timespec]);
ylim([0,100]);
ylabel('Turning (%)');
xlabel('time (s)')
box off
hold off
end
%%
subplot(4,1,4)
hold on
if ~isempty(hunchdata)
    %%
    [hevents,~]=stack_events(hunchdata,timeframe,timeres);
for i=1:circles
f=fill([waiting+(i-1)*(stimdur+stimint),waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)+stimdur,waiting+(i-1)*(stimdur+stimint)],[0,0,100,100],'k');
f.FaceAlpha=0.1;
f.EdgeColor='none';
end
%%
hunch_prob=nan(1,timeframe);
hunch_u=nan(1,timeframe);
for i=1:timeframe
    [hunch_prob(i),hunch_u(i)]=bernuli(TrkedEvent(:,i),hevents(:,i));
end
hunch_CI=2*hunch_u;
plot_with_errorbar(time,100*hunch_prob,100*hunch_CI,[0.5 0.5 0.5])
xlim([waiting-15 timespec]);
ylim([0,100]);
ylabel('Hunching (%)');
xlabel('time (s)')
box off
hold off
end
print(figure3,strcat(name,'@patterns_in_time_series'),'-fillpage','-painters','-dpdf');
close
%%
end