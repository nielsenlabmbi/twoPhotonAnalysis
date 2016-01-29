function sig = pullsigs(fullFilePath,segment,info,align)
    % Given the segmentation, this method pulls the timecourse for each ROI
    % from the channel specified in 'segment'
    % Accepts:
    %   fullFilePath        - full path of the sbx file without extension
    %   segment             - segment structure that defines the ROI
    %   info                - sbx info structure
    %   align               - structure containing the x-y shifts for each frame
    % Returns:
    %   sig                 - full timecourse for all ROI
    
    nRoi    = segment.nRoi;
    nFrames = info.max_idx+1;
    chan    = segment.chan;
    idx     = cell(1,nRoi);
    
    for c=1:nRoi
        idx{c} = find(segment.fullMask == c);
    end

    sig = zeros(nFrames, nRoi);
    for ii=1:nFrames
        z = sbxread(fullFilePath,ii-1,1);
        z = squeeze(z(chan,:,:));
        if ~isempty(align)
            z = circshift(z,align.T(ii,:));
        end
        for c=1:nRoi
            sig(ii,c)        = mean(z(idx{c}));
        end
    end
end