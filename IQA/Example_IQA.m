% This example code loads example images from the TID2008 dataset and computes INRF-IQA 

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


% Rescale INRF parameters
sigmaMuValues = sigmaMu1;
sigmawValues = sigmaw;
pValues = p; 
qValues = q; 
sigmagValues = sigmag; 
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



%% Computation of INRF-IQA

% Reference image: I01.BMP
% Distorted image: I01_01_4.bmp
Ref = im2double(imread('I01.BMP'));
Dist = im2double(imread('I01_01_4.bmp'));


% INRF computation: Reference Video
[L_Ref,I_Ref] = computeINRFModelInterpnoNR_wg(Ref,param);
INRF_Ref = L_Ref+I_Ref*lambdaValues;

% INRF computation: Distorted Video
[L_Dist,I_Dist] = computeINRFModelInterpnoNR_wg(Dist,param);
INRF_Dist = L_Dist+I_Dist*lambdaValues;

% INRF-IQA score
INRF_IQA = sqrt(mean(mean((INRF_Ref-INRF_Dist).^2)));

