function display(self)
    disp(['%# =' class(self)])
    disp(['%#.anchor=' serialize(self.anchor)])
    disp(['%#.color=' serialize(self.color)])
end