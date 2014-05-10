function [customerDataN,restDataN] = NormData(customerData,restData)
%NORMDATA Summary of this function goes here
%   Detailed explanation goes here

RSub = restData(:,2:end);
CSub = customerData(:,2:end);

%size of feature set for restaurants and customers
sR = size(RSub,1);
sC = size(CSub,1);

maxR = repmat(max(RSub),sR,1);
minR = repmat(min(RSub),sR,1);

maxC = repmat(max(CSub),sC,1);
minC = repmat(min(CSub),sC,1);

%% Version 1 (0 to 1) (normalized by column)
%Find the normalized matrix
RSubN = (RSub-minR)./(maxR-minR);
CSubN = (CSub-minC)./(maxC-minC);

%% Version 2 (-1 to 1) (normalized by column)
%Find the normalized matrix
% RSubN = RSub./maxR;
% CSubN = CSub./maxC;

restDataN = [restData(:,1) RSubN];
customerDataN = [customerData(:,1) CSubN];

end

