function T = realign(rawFullPath,idx,chan,Tcheck)
    % Uses the aligned images to realign the file; this should ideally yield a string of 0s
    % Accepts:
    %   rawFullPath - filename
    %   idx         - indices of frames to align
    %   chan        - which channel to align
    %   Tcheck      - the x-y shift values for all frames
    % Returns:
    %   T           - optimal translation for each frame

    if(length(idx)==1)
        A = sbxread(rawFullPath,idx(1),1);
        A = squeeze(A(chan,:,:));
            A = circshift(A,align.Tcheck(idx(1),:));
        T = [0 0];
    elseif (length(idx)==2)
        A = sbxread(rawFullPath,idx(1),1);
        B = sbxread(rawFullPath,idx(2),1);
        A = squeeze(A(chan,:,:));
            A = circshift(A,align.Tcheck(idx(1),:));
        B = squeeze(B(chan,:,:));
            B = circshift(B,align.Tcheck(idx(2),:));
        
        [u,v] = fftalign(A,B);
        
        T = [[u v] ; [0 0]];
    else
        idx0 = idx(1:floor(end/2));
        idx1 = idx(floor(end/2)+1 : end);
        
        [A,T0] = realign(rawFullPath,idx0,chan,Tcheck);
        [B,T1] = realign(rawFullPath,idx1,chan,Tcheck);
       
        [u,v] = fftalign(A,B);

        T = [(ones(size(T0,1),1)*[u v] + T0) ; T1];
    end
end