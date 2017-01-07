% The objective function for the cantilever truss w/ animation.
%
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
% See also tcant_objective_function()
function f =tcant_objective_function_movie(XY34)
    f =tcant_objective_function(XY34);
    [XY,en,minA,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    tcant_draw
    drawnow
end