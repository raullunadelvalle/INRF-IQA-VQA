# INRF-IQA-VQA
This repository contains the Matlab code to run the INRF-IQA and INRF-VQA algorithms in "Luna, R., Zabaleta, I., & Bertalmío, M. (2023). State-of-the-art image and video quality assessment with a metric based on an intrinsically non-linear neural summation model. Frontiers in Neuroscience, 17."


Folder "IQA" contains an example script, "Example_IQA.m", to compute INFR-IQA given a distorted and a reference image
from the TID2008 dataset (Ponomarenko et al., 2009).

Folder "VQA" contains an example script, "Example_VQA.m", to compute INFR-VQA given a distorted and a reference video
from the LIVE-VQA dataset (Seshadrinathan, Soundararajan, Bovik & Cormack, 2010a; Seshadrinathan, Soundararajan, Bovik & Cormack, 2010b).

Folder "functions" contains specific functions to compute INRF calculations as well as the function "yuvRead" to read 
".yuv videos" (Mohammad Haghighat, 2023).




References

Mohammad Haghighat (2023). Read YUV Videos and Extract the Frames (https://github.com/mhaghighat/yuvRead), GitHub.

Seshadrinathan, K., Soundararajan, R., Bovik, A. C., & Cormack, L. K. (2010a). Study of subjective and objective 
quality assessment of video. IEEE transactions on Image Processing, 19(6), 1427-1441

Seshadrinathan, K., Soundararajan, R., Bovik, A. C., & Cormack, L. K. (2010b, February). A subjective study to 
evaluate video quality assessment algorithms. In Human Vision and Electronic 608 Imaging XV (Vol. 7527, pp. 128-137). SPIE.

Ponomarenko, N., Lukin, V., Zelensky, A., Egiazarian, K., Carli, M., and Battisti, F. (2009). TID2008 - 
A Database for Evaluation of Full-Reference Visual Quality Assessment Metrics. 
Advances of Modern Radioelectronics 10, 30–45
 
