%Demo - Optical Flow playbacks
load('Original');

%manual ROI
[ROI,Cropped]=crop_Video(Original);

%% compute OF and playbacks
    [uTVL1,vTVL1]=TVL1OFComputation(Cropped);%TVL1 optical flow
    [uMT,vMT]=FanerbackOFComputation(Cropped);% Fanerback OF
    
    % compute playbacks for TVL1
    [OFGVG_TVL1,GOFW_TVL1,OFKG_TVL1]=OF_playbackComputation(uTVL1);
    [OFKG_RGBTVL1]=PLOTOFDKG(OFKG_TVL1,78);
    
    % TVL1 Playbacks 
    h=figure;
    set(h, 'Position', [100, 100, 500, 800]);
    subplot(3,1,1),plot(GOFW_TVL1);
    title('GOFW');
    subplot(3,1,2),imshow(OFKG_RGBTVL1,[]);
    title('OFDKG');
    hsp1 = get(gca, 'Position');
    subplot(3,1,3),imshow(OFGVG_TVL1,[]);
    title('OFGVG');
    hsp2 = get(gca, 'Position');                     
    set(gca, 'Position', [hsp2(1) hsp2(2)-0.1  hsp1(3) 2*hsp1(4)]);
    
    
    
    %% compute playbacks for MT
    [OFGVG_MT,GOFW_MT,OFKG_MT]=OF_playbackComputation(uMT);
    [OFKG_RGBMT]=PLOTOFDKG(OFKG_MT,78);
    
    % MT Playbacks 
    h=figure;
    set(h, 'Position', [100, 100, 500, 800]);
    subplot(3,1,1),plot(GOFW_MT);
    title('GOFW');
    subplot(3,1,2),imshow(OFKG_RGBMT,[]);
    title('OFDKG');
    hsp1 = get(gca, 'Position');
    subplot(3,1,3),imshow(OFGVG_MT,[]);
    title('OFGVG');
    hsp2 = get(gca, 'Position');                     
    set(gca, 'Position', [hsp2(1) hsp2(2)-0.1  hsp1(3) 2*hsp1(4)]);

