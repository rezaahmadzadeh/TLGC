%{
 ======================================================================
 ============================== M A I N ===============================
 ======================================================================

  @@@@@ Trajectory Learning using Generalized Cylinders (TLGC) @@@@@
 For more details check the bottom of this code.

 -----------------------------------------------------------------------
 Reza Ahmadzadeh (reza.ahmadzadeh@gatech.edu) IRIM-2016-2018
 -----------------------------------------------------------------------
%}

clc, clear, close all

% add path to scripts
addpath('dataset');
addpath('plot');
addpath('scripts');
addpath('utils');

% load the dataset
load('dataset\reaching1.mat');

%% === (1) model learning (Constructing the Generalized Cylinder) ===
% ------------------------------------------------------------------------
crossSectionType= 'circle';         % GC cross section type 'circle' or 'spline'
doPlotGC        = true;             % true to plot the GC

% Encode the dataset, extract the directrix, boundaries and construct the GC
encodedModel    = constructGC(smoothData, numDemos, numPoints, idx, crossSectionType);

%% === (2) Reproduction (retrieving new trajectories using the encoded model) ===
% -----------------------------------------------------------------------
doReproduce = true;
numRepro = 1;           % number of reproductions 
starting = ones(1,numRepro); 

if doReproduce
    % generate random initial points
    [initPoints, Ratio] = randomInitialPoints(encodedModel, numRepro, crossSectionType);
    % reproduction
    newTrajectories = reproduce(encodedModel, numRepro, starting, initPoints, Ratio, crossSectionType);
end

%% === (3) Plot results ===
% -----------------------------------------------------------------------
% plot GC and reproduction
if doPlotGC
    hMainPlot   = figure;      
    hold on;
    gcPlotType  = 'line';   % GC plot type 'surface' or 'line'
    plotGC(encodedModel, smoothData, numSet, numDemos, gcPlotType, crossSectionType, hMainPlot);
    if doReproduce
        plotReproduction(initPoints, newTrajectories, hMainPlot);
    end
end

%% === Description ===
%{
this package uses Differential Geometry to encode the given set of
demonstrations to learn a model for the demonstrated skill.
It can also reproduce new trajectories from any initial pose inside the
canal. The reproduced trajectories are time-independent and the
representation is continuous.

If you use this code (even in part) please cite at least one of the following papers:

@INPROCEEDINGS{ahmadzadeh2017generalized,
	TITLE={Generalized Cylinders for Learning, Reproduction,Generalization, and Refinement of Robot Skills},
    AUTHOR={Ahmadzadeh, S. Reza and Rana Muhammad Asif and Chernova, Sonia},
	BOOKTITLE={Robotics: Science and Systems ({RSS})},
	YEAR={2017},
	MONTH={July},
    PAGES={1--10},
	ADDRESS={Cambridge, MA, USA}
}

@INPROCEEDINGS{ahmadzadeh2016trajectory,
	TITLE={Trajectory Learning from Demonstration with Canal Surfaces: A Parameter-free Approach},
	AUTHOR={Ahmadzadeh, Seyed Reza and Kaushik, Roshni and Chernova, Sonia},
	BOOKTITLE={Humanoid Robots ({H}umanoids), 2016 {IEEE-RAS} International Conference on},
	YEAR={2016},
	MONTH={November},
	ORGANIZATION={IEEE},
}

@INPROCEEDINGS{ahmadzadeh2016encoding,
	TITLE={Encoding Demonstrations and Learning New Trajectories using Canal Surfaces},
	AUTHOR={Ahmadzadeh, Seyed Reza and Chernova, Sonia},
	BOOKTITLE={25th Inernational joint Conference on Artificial Intelligence ({IJCAI} 2016), Workshop on Interactive Machine Learning: Connecting Humans and Machines},
	PAGES={1--7},
	YEAR={2016},
	MONTH={July},
	ADDRESS={New York City, NY, USA},
	ORGANIZATION={{IEEE}}
}

@INPROCEEDINGS{ahmadzadeh2016geometric,
	TITLE={A Geometric Approach for Encoding Demonstrations and Learning New Trajectories},
	AUTHOR={Ahmadzadeh, Seyed Reza and Chernova, Sonia},
	BOOKTITLE={Robotics: Science and Systems  ({RSS} 2016), Workshop on Planning for Human-Robot Interaction: Shared Autonomy and Collaborative Robotics},
	PAGES={1--3},
	YEAR={2016},
	MONTH={June},
	ADDRESS={Ann Arbor, Michigan, USA},
	ORGANIZATION={{IEEE}}
}
-------------------------------------------------------------------
Reza Ahmadzadeh (reza.ahmadzadeh@gatech.edu) IRIM-2016-2018
-------------------------------------------------------------------
%}