function [u,v]=TVL1OFComputation(video)
% Compute the TVL1 Optical flow using OPENCV implementation
%input:
%   video: Video in gray
%output:
%   u:   x component of the OF
%   v:   y component of the OF 

for k = 1 : size(video,3)-1
    I1=video(:,:,k);
    I2=video(:,:,k+1);
    
    [OF_TVL1,~]=OFALgorithm(I1,I2);
    u(:,:,k)=OF_TVL1(:,:,2);
    v(:,:,k)=OF_TVL1(:,:,1);
end
