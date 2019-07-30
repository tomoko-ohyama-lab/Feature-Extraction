function [x,y,address]=load_JAABA(driver,effector,tracker,protocol,timestamp)
%% load textfile
address=cd(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100\',timestamp,'_JAABA'));
JAABAroll=load('scores_updated');
y=nanmean(JAABAroll.allScores.allScores.totalProcessed);
x=JAABAroll.allScores.allScores.timestamps;
end