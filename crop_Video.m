function [ROI,Cropped]=crop_Video(Original)
% Creates a cropped video using a manual ROI 
%input:
%   Original: Original Video in gray
%output:
%   ROI:    Rect with the dimension of the Region of interest(ROI)
%   Cropped:Cropped video

        imshow(Original(:,:,1));
        hold on;
        h = imrect;
        position = wait(h);
        ROI = getPosition(h);
        hold off;
        close;
        for k = 1 : size(Original,3)
         Cropped(:,:,k) = imcrop(Original(:,:,k),ROI);
        end
 