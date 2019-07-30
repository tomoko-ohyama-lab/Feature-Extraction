function data=convert_str2num(filename,formatSpec)
    %% Open the text file.
    fileID = fopen(filename,'r');
    %% Read columns of data according to format string.
    % This call is based on the structure of the file used to generate this
    % code. If an error occurs for a different file, try regenerating the code
    % from the Import Tool.
    filescan = textscan(fileID,formatSpec);
    %% filescan = 1 x 11 cells
        % {1,1}=timestamps (eg. {'20190322_115140'} all same in 625 cells)
        % {1,2}=animal number (eg. 00001)
        % {1,3}=time1 (eg. 30.00)
        % {1,4}=time2 (eg. 45.00)
        % {1,5}=ampl (eg. 0.773, NA)
        % {1,6}=freq (eg. 2.236, NA)
        % {1,7}=Pval (eg. 0.353, 0, NA)
        % {1,8}=freq2 (eg. 6.381, NA)
        % {1,9}=dur (eg. 31.514, NA)
        % {1,10}=beg (eg. 109.508, NA)
        % {1,11}=tsize (eg. 15.000)
    %%  1 cell = 626 x 1 cells
    col = numel(filescan); % col = 11
    row = numel(filescan{1}); % row = 626
    %% scan = 626 x 11 cells
    % One big data table as seen on Notepad
    scan=[];
    scan=[filescan{1:col}]; 
    for i=2:col
        for j=2:row
            scan{j,i}=str2num(filescan{1,i}{j,1});
            if isempty(scan{j,i})
                scan{j,i}=NaN;
            end
        end
    end
    % Now, all numerical data has been changed from string to double
    %% Store area in data
    headers=scan(1,:);
    data=[];
    %structArray = cell2struct(cellArray, fields, dim)
    data=cell2struct(scan(2:row,:),headers,2);
    %% Close the text file.
    fclose(fileID);
end