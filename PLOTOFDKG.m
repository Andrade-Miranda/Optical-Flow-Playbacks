function [OFDKG_RGB]=PLOTOFDKG(OFDKG,line)
% Compute OFDKG for a specific line.
%input:
%   OFDKG: OFDKG for all the lines of the video
%output:
%   OFDKG_RGB:OFDKG for a specific line with its respective color code
%   

for i=1:size(OFDKG,3)
    OFDKG_line(:,i)=OFDKG(line,:,i);
end

    OFDKG_line_H=zeros(size(OFDKG_line));
    OFDKG_line_V=abs(OFDKG_line);
    OFDKG_line_S=ones(size(OFDKG_line));
    
    % color coding
    ind_blue=find(OFDKG_line<0);
    ind_red=find(OFDKG_line>0);
    OFDKG_line_H(ind_blue)=0.666; % Blue 
    OFDKG_line_H(ind_red)=0;      % Red 
    
    OFDKG_HSV(:,:,1)=OFDKG_line_H;
    OFDKG_HSV(:,:,2)=OFDKG_line_S;
    OFDKG_HSV(:,:,3)=OFDKG_line_V;
    
    OFDKG_RGB=hsv2rgb(OFDKG_HSV);
