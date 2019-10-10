function Color_Brain_Regions (V)

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

% Define here the Parcellation scheme to load from ParcelsMNI2mm:
% glasser378 AAL116 dbs80 Yeo7 glasser360
Parcellation='AAL116';
Volume=struct2array(load('ParcelsMNI2mm',['V_' Parcellation]));
% Volume contains 91x109x91 voxels, numbered according to the ROI they belong to, or 0 otherwise 

if length(V)>max(Volume(:))
    disp(['Note: The input vector has more elements (' num2str(length(V)) ') than ROIs in this parcellation'])
elseif length(V)<max(Volume(:))
    disp('Note: The input vector has less elements than ROIs in this parcellation')
    disp(['Only the first ' num2str(length(V)) ' ROIs out of ' num2str(max(Volume(:))) ' will be colored'])
end

% Rescale V such that it ranges between -1 and 1
V=V-min(V);
V=2*(V/max(V));
V=V-1;

%V=V>0; % Chose this to run the blue/red scheme

% Create a colormap cmap with size Nx3
cmap=jet(length(-1:0.01:1));
ind_color=-1:0.01:1;
V=round(V*100)/100;  % Round values in V, for the colormap (optional)

figure
hold on
for n=1:length(V) % Note, you can plot only a subset of areas
        sregion=smooth3(Volume==n);
        patch(isosurface(sregion,0.3),'FaceColor',cmap(find(abs(ind_color-V(n))<0.01,1),:),'EdgeColor','none')%'FaceAlpha', abs(V(n)))       
end

material dull
lighting gouraud
% Top view
view(-90,90)
daspect([1 1 1])
axis on
camlight;
xlim([5 105])
ylim([5 85])
zlim([10 80])
axis off

% Example to create a single patch with all brain areas (including
% reduction code)
% scortex=smooth3(Volume>0);
% cortexpatch=patch(isosurface(scortex,0.3), 'FaceColor', [0.9 0.9 0.9], 'EdgeColor', 'none','FaceAlpha', 0.1);
% reducepatch(cortexpatch,0.1);
% isonormals(scortex,cortexpatch);