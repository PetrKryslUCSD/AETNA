% The objective function for the cantilever truss w/ animation.
%
% See also tcant_objective_function()
function f =tcant_objective_function_movie(XY34)
    f =tcant_objective_function(XY34);
    [XY,en,minA,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    tcant_draw
    drawnow
end