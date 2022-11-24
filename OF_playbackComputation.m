function [OFGVG,GOFW,OFKG]=OF_playbackComputation(U)
% Implementation of the OF playbacks
%input:
%   U: x component of the OF
%output:
%   OFGVG: Optical flow Glottovibrogram
%   GOFW:  Glottal Optical-Flow Waveform  
%   OFDKG: Optical-Flow Kymogram


[m,~,l]=size(U);
OFGVG=zeros(m,l);
GOFW=zeros(1,l);
OFKG=zeros(size(U));

for i= 1: l
    vector=mean(abs(U(:,:,i)),2);
    OFGVG(:,i)=vector;
    GOFW(1,i)=sum(vector);
    OFKG(:,:,i)=U(:,:,i);
end
