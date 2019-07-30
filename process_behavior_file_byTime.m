function process_behavior_file_shua(driver,effector,tracker,protocol,value,timestamp)
switch value
    case 2
        %% read the crawl stats file
        crawldata=[];
        crawldata=import_data_shua(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100\',timestamp),'animal_stats_peran');
        %% read the roll stats file
        rolldata=[];
        rolldata=import_data_shua(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100\',timestamp),'animal_stats_rolls');
        %% process crawl file
        [crawldata,stamp_index,exp_date]=process_crawl_shua(crawldata);
        %% process roll file
        rolldata=process_events(rolldata,crawldata);
     
        %% save .mat files
        FileName=strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\matlab_file\original_behavior\',driver,'@',effector,'@',tracker,'@',protocol,'@100.mat');%adapt
        save(FileName,'crawldata','rolldata','stamp_index','exp_date','FileName');
    case 4
        %% read the crawl stats file
        crawldata=[];
        crawldata=import_data_shua(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100'),'animal_stats_peran');
        %% read the roll stats file
        rolldata=[];
        rolldata=import_data_shua(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100'),'animal_stats_rolls');
        %% read the hunch stats file
        hunchdata=[];
        hunchdata=import_data_shua(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100'),'animal_stats_turns');
        %% read the turn stats file
        turndata=[];
        turndata=import_data_shua(strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\',tracker,'\',driver,'@',effector,'\',protocol,'@100'),'animal_stats_hunches');
        %% process crawl file
        [crawldata,stamp_index,exp_date]=process_crawl_shua(crawldata);
        %% process roll file
        rolldata=process_events(rolldata,crawldata);
        %% process hunch file
        hunchdata=process_events(hunchdata,crawldata);        
        %% process turn file
        turndata=process_events(turndata,crawldata);
        %% save .mat files
        FileName=strcat('C:\Users\Ohyama_Dell\Documents\feature_extraction\matlab_file\original_behavior\',driver,'@',effector,'@',tracker,'@',protocol,'@100.mat');%adapt
        save(FileName,'crawldata','rolldata','hunchdata','turndata','exp_date','stamp_index','FileName');
end   
end