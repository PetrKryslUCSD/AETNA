% Define the data for the satellite motion problem
function [G,M,R,v0,r0]=satellite_data
G=6.67428 *10^-11;% cubic meters per kilogram second squared;
M=5.9736e24;% kilogram
R=6378e3;% meters
v0=[-2900;-3200;0]*0.9;% meters per second
r0=[R+20000e3;0;0];% meters