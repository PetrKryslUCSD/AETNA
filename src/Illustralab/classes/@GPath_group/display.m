function display(self)
    disp(['%# =' class(self)])
    disp(['%#.group={' num2str(length(self.group)) ' of objects}'])
    display(self.GPath)
end