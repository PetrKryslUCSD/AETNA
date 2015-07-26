function display(self)
    disp(['%# =' class(self)])
    disp(['%#.arrowstyle=' serialize(self.arrowstyle)])
    disp(['%#.arrowsize=' serialize(self.arrowsize)])
    disp(['%#.arrowaspect=' serialize(self.arrowaspect)])
    disp(['%#.followorientation=' serialize(self.followorientation)])
    display(self.GPath)
end