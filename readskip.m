function z = readskip(rawFullPath,startFrame,numFramesToSkip,align,info,chan)
    % Reads a subset of frames in the sbx file as specified.
    % Accepts:
    %	rawFullPath			- full path of the sbx file without extension
    %	startFrame			- frame at which reading is to begin (should ideally be 0)
    %   numFramesToSkip     - number of frames to skip
    %	align				- structure containing the x-y shifts for each frame
    %	info				- sbx info structure
    %	chan 				- channel number
    % Returns:
    %   z 					- frames, as read

    numFramesToRead = floor(info.max_idx/numFramesToSkip);
    z = sbxread(rawFullPath,startFrame,1);
    z = zeros([size(z,2) size(z,3) numFramesToRead]);

    for jj=1:numFramesToRead
        q = sbxread(rawFullPath,j*numFramesToSkip,1);
        q = squeeze(q(channel,:,:));
        if ~isempty(align)
            q = circshift(q,align.T(jj*numFramesToSkip,:)); 
        end
        z(:,:,jj) = q;
    end
end