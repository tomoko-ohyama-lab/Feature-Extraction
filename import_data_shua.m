%% import data file
function data=import_data_shua(directory,pattern)
    %% extract data from txt files
    Folder= dir(directory);
    for i=1:numel(Folder)
        if strfind(Folder(i).name,pattern)
            filename=strcat(directory,'\',Folder(i).name);
            break
        end
    end

    %% Read columns of data as strings:
    % For more information, see the TEXTSCAN documentation.
    if isempty(strfind(pattern,'peran'))==0
        formatSpec = '%s%s%s%s%s%s%s%s%s%s%s\n';
    elseif isempty(strfind(pattern,'rolls'))==0
        formatSpec = '%s%s%s%s%s%s%s%s%s\n';
    elseif isempty(strfind(pattern,'hunches'))==0
        formatSpec = '%s%s%s%s%s%s%s%s%s\n';
    elseif isempty(strfind(pattern,'turns'))==0
        formatSpec = '%s%s%s%s%s%s%s%s%s\n';
    end
    %% Convert all the numbers
    data=convert_str2num(filename,formatSpec);
end