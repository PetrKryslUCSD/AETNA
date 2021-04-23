function render(p)
    hold on;
    for j=1:length(p.group) 
        render(p.group{j});
    end
end