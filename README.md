%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Function to set the color and/or transparency of brain areas.
%
%  Brain areas are defined according to a given parcellation scheme.
%  One patch is created for each brain area. 
%  Color/Transparency of each brain region are scaled by input vector V.
% 
%  Vector V has the size Nx1, where N is the number of brain areas, sorted
%  in the same order as in the parcellation scheme.
% 
%  Basically it creates one patch for each brain areas and then the
%  properties can be defined by:
%  - 'Facecolor', an 1x3 vector with relative amount of Red, Green and Blue
%  - 'FaceAlpha', a value between 0 (transparent) and 1 (opaque).
%
%  It is possible to plot only one or a subset of areas. Also, it is
%  possible to create a patch for the whole brain choosing smooth3(Volume>0)
%  
%  3-D volumes of some parcellation schemes are saved in ParcelsMNI2mm, but
%  new volumes can be easily created from the NIFTI files
%  e.g. V_dbs80 = niftiread('dbs80symm_2mm.nii.gz');
%
%  To run an example, set:
%  Parcellation='AAL116';
%  and call:
%  Color_Brain_Regions(rand(90,1))
%  or 
%  Color_Brain_Regions(rand(116,1)) 
%  to include also the cerebellum
%
%  Joana Cabral
%  October 2019
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%
