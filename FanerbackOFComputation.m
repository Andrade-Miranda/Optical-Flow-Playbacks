function [u,v]=FanerbackOFComputation(video)
% Compute the Fanerback Optical flow using OPENCV implementation
%input:
%   video: Video in gray
%output:
%   u:   x component of the OF
%   v:   y component of the OF

for k = 1 : size(video,3)-1
    I1=video(:,:,k);
    I2=video(:,:,k+1);
    
    [~,OF_faner]=OFALgorithm(I1,I2);
    u(:,:,k)=OF_faner(:,:,2);
    v(:,:,k)=OF_faner(:,:,1);
end