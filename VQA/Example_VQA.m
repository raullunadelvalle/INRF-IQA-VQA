% This example code loads example videos from the LIVE-VQA dataset and computes INRF-VQA 

clear all
close all 
clc

addpath(genpath('..\functions'));



% INRF parameter values
sigmaMu1 = 1.74; 
sigmaw = 25; 
p = 0; 
q = 0; 
sigmag = 1; 
lambda = 3; 

% Scaling factor to scale INRF parameters
hor_size_TID2008 = 512; % 512x384 size images in TID2008 image dataset (where parameters are tuned)
hor_size_LIVEVQA = 768; % 768x432 size frames in LIVE-VQA video dataset
scaling_factor = hor_size_LIVEVQA/hor_size_TID2008;

% Rescale INRF parameters
sigmaMuValues = sigmaMu1.*scaling_factor;
sigmawValues = round(sigmaw.*scaling_factor);
pValues = p; 
qValues = q; 
sigmagValues = sigmag*scaling_factor; 
lambdaValues = lambda; 



boundMu = 0;
sigmaMu = sigmaMuValues;
sizeMu = round(2*sigmaMu);
h=fspecial('Gaussian', sizeMu, sigmaMu);

param.boundMu = boundMu;
param.sizeMu = sizeMu;
param.sigmaMu = sigmaMu;
param.sigmaW = sigmawValues;
param.p = pValues;
param.q = qValues;
param.sigmag = sigmagValues;



%% Computation of INRF-VQA

% Reference video: bs1_25fps.yuv
% Distorted video: bs4_25fps.yuv
total_frames = 25; %25 fps videos have been trimed to 1 sec for this example

INRF_VQA = zeros(1,total_frames);
for i = 1:total_frames

    Ref = yuvRead('bs1_25fps.yuv',768,432,i);
    Dist = yuvRead('bs4_25fps.yuv',768,432,i);


    % INRF computation: Reference Video
    [L_Ref,I_Ref] = computeINRFModelInterpnoNR_wg(Ref,param);
    INRF_Ref = L_Ref+I_Ref*lambdaValues;

    % INRF computation: Distorted Video
    [L_Dist,I_Dist] = computeINRFModelInterpnoNR_wg(Dist,param);
    INRF_Dist = L_Dist+I_Dist*lambdaValues;

    % Frame-by-frame INRF-VQA scores
    INRF_VQA(i) = sqrt(mean(mean((INRF_Ref-INRF_Dist).^2)));

end

