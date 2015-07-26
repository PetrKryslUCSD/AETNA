function display(self)
    disp(['%# =' class(self)])
    disp(['%#.xy=' class(self.xy)])
    disp(['%#.edgecolor=' serialize(self.edgecolor)])
    disp(['%#.linestyle=' serialize(self.linestyle)])
    disp(['%#.linewidth=' serialize(self.linewidth)])
    disp(['%#.decorations={'  class(self.decorations) '}'])
    display(self.GPath)
end