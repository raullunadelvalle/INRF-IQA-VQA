function [L_mu,INRF] = computeINRFModelInterpnoNR_wg(u, param) 
	if (ndims(u) == 3)
		% Obtain the linear luminance
        L=(rgb2lab(u))/100;
        L=L(:,:,1);
	else
		L = im2double(u);
    end

	% Calculate local mean
	h=fspecial('Gaussian', param.sizeMu, param.sigmaMu);
	L_mu = imfilter(L, h, param.boundMu);

	% Calculate the INRF model
% 	C = L - mean(L(:));
    INRF = computeRuInterp_wg_noGPU(L, param, 25);

end

% function l = rgb2lightness(u)
% 	lab = rgb2lab(u);
% 	l = lab(:, :, 1);
% end
