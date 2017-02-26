function [acks,preprocessedData] = batchPreprocessLocal(fileList)
    % This method preprocesses all sbx files in the list and generates and 
    % returns align and image files. This might be done using the parallel
    % processing toolbox in the future but for now it is serial.
    % Accepts:
    %   fileList    - List of files to be preprocessed in predefined structure
    % Returns:
    %   m                - String list of exceptions/acks
    %   preprocessedData - Structure array of image and align data
    
    nFiles = length(fileList);
    
    for ii=1:nFiles
        load(fileList(ii).fullPath);
        % align
        for ch=1:info.channels
            [alignStruct(ch).m,alignStruct(ch).T] = align(fileList(ii).fullPath,0:info.max_idx,ch); 
            alignStruct(ch).algo = 'corr';
            alignStruct(ch).chan = ch;
            alignStruct(ch).name = ['a(c' num2str(ch) '_' alignStruct.algo];
            alignStruct(ch).expt = fileList(ii).fullExpt;
        end
        
        processedData(ii).align = alignStruct;
        
        % create image
        [zGreen,zRed]     = readskip(fullFileName,0,numFramesToSkip);
        disp(['Created average image for ' thisfilename]);
        avgImage = normImage(zGreen);
%         avgImage = [avgImage; normImage(zRed)];

        parsave([fullFileName '.image'],avgImage,channelNum,numFramesToSkip);
    end
    

end