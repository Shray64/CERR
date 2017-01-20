function q = imquantize_cerr(x,L,xmin,xmax)
% image quantization 

% outlier removal
x01 = quantile(x(:),0.01);
x99 = quantile(x(:),0.99);
x(x<x01) = x01;
x(x>x99) = x99;

if ~exist('xmin','var')
    % % from El Naqa's code.
    xmax=max(x(:));
    xmin=min(x(:));
    % range=xmax-xmin;
    % scale=(L-1)/range;
    % q1=round(x*scale)/scale;
    % xmax=85;
    % xmin=-160;
else
    x(x<xmin) = xmin;
    x(x>xmax) = xmax;
end

% matlab's discretization from graycomatrix
slope = (L-1) / (xmax - xmin);
intercept = 1 - (slope*(xmin));
%q = floor(imlincomb(slope,x,intercept,'double'));
q = round(imlincomb(slope,x,intercept,'double'));

return