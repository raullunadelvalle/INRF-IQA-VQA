function Ru = computeRuInterp_wg_noGPU(u, param, steps)

    % Calculate g*u
%     if sigmag == 1
%         gu = u;
%     else
	    g=fspecial('Gaussian', round(2*param.sigmag), param.sigmag);
	    gu = imfilter(u, g, 'symmetric');
%     end

    levels = linspace(min(gu(:)), max(gu(:)), steps);
    R_L = createPiecewiseR(u, levels, param.p, param.q, param.sigmaW);
    Ru = interpolateR(gu, R_L, levels);
end


function R = interpolateR(u, R_L, levels)
    L = length(levels);
    R = zeros(size(u));
    level_step = levels(2) - levels(1);

    for j = 1:L-2 
        indexL = (u >= levels(j)) & (u < levels(j+1));
        R_Lj = R_L(:, :, j); R_Lj1 = R_L(:, :, j+1);
        R(indexL) = R_Lj(indexL) + (R_Lj1(indexL) - R_Lj(indexL))...
                                    .*(u(indexL)-levels(j))/level_step;
    end

    indexL = (u >= levels(L-1)) & (u <= levels(L));
    R_Lj = R_L(:, :, L-1); R_Lj1 = R_L(:, :, L);
    R(indexL) = R_Lj(indexL) + (R_Lj1(indexL) - R_Lj(indexL))...
                                .*(u(indexL)-levels(j))/level_step;
end


function R_L = createPiecewiseR(u, levels, p, q, sigmaW)
    L = length(levels);
    [M, N] = size(u);
    R_L = zeros(M, N, L);
    w = createW(M, N, sigmaW); 

    for l = 1:L       
        S_L = sigmoid_atan(levels(l)-u);
%         S_L = sigmoid(levels(l)-u, p, q);
%         R_L(:, : , l) = conv2(S_L, w, 'same'); 
        R_L(:, : , l) = convolve(S_L, w, sigmaW); 
    end

end

function w = createW(M, N, sigmaW)
    [J, I] = meshgrid(1:N, 1:M);
    % K = 1.0/((2*pi)*sigmaW*sigmaW+1e-6);
    % f=K*exp(-((I-M/2).*(I-M/2) + (J-N/2).*(J-N/2))/(2*sigmaW*sigmaW));
    w=exp(-((I-M/2).*(I-M/2) + (J-N/2).*(J-N/2))/(2*sigmaW*sigmaW));
    %% Gaussian cropped
    % window_size = [59, 59];
    % w([1:floor(end/2)-window_size(1),floor(end/2)+window_size(1):end],  :) = 0;
    % w(:,[1:floor(end/2)-window_size(2),floor(end/2)+window_size(2):end]) = 0; 
    %%
    w = w/sum(w(:));
end


function C = convolve(u, w, pad)
    pad_i = pad; pad_j = pad;
    [M, N] = size(u);
    w = padarray(w, [pad_i, pad_j], 0);
    w = fftshift(w);
    W = fft2(w);

    pad_u = padarray(u, [pad_i, pad_j], 0);
    % pad_u = padarray(u, [pad_i, pad_j], 'symmetric');
    U = fft2(pad_u); 
    wu = ifft2(W.*U);
    C = wu(pad_i+1:pad_i+M, pad_j+1:pad_j+N);
end

function s=sigmoid(v, p, q)
    s = zeros(size(v));
    s(v<0) = -(abs(v(v<0)).^q);
    s(v>0) = v(v>0).^p;
end

function s=sigmoid_atan(v)
    s = atan(10*v);
%     s = s./max(s(:));
end

