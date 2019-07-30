function mark=behavior_pattern(data)
if sum(strcmp(fieldnames(data),'ampl'))
    mark='C';
elseif sum(strcmp(fieldnames(data),'rampl'))
    mark='R';
elseif sum(strcmp(fieldnames(data),'tampl'))
    mark='T';
elseif sum(strcmp(fieldnames(data),'hampl'))
    mark='H';
else
    disp('unknown behavior pattern');
end
end