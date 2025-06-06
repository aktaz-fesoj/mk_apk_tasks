function[XC,YC] = continent(R, uk, vk, s0, proj, file)
    % Project continent in a specific projection
    
    % Load input file
    P = load(file);

    % Extract its coordinates
    u = P(:,1)*pi/180;
    v = P(:,2)*pi/180;

    %Transform to oblique aspect
    [s, d] = uv_sd(u, v, uk, vk);

    %Threshold
    s_min = 45 * pi/180;

    %Preserve northern points
    idxs = find(s>s_min);
    s = s(idxs); d = d(idxs);

    %Remove southern popints
    %idxs = find(s<=s_min);
    %s(idxs) = []; d(ixs) = [];

    %Project points
    [XC,YC] = proj(R, s, d, s0);