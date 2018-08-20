# TLGC: Trajectory Learning using Generalized Cylinders #
### version 2.0 ###

This is the demo version of the "Trajectory Learning using Generalized Cylinders" (TLGC) approach. 

## What is TLGC? ##

TLGC is a novel geometric approach for learning and reproducing trajectory-based skills from human demonstrations. TLGC models a skill as a Generalized Cylinder, a geometric representation composed of an arbitrary space curve called spine and a smoothly varying cross-section. While this model has been utilized to solve other robotics problems, this is the first application of Generalized Cylinders to manipulation. The strengths of TLGC are the model’s ability to identify and extract the implicit characteristics of the demonstrated skill, support for multiple reproduction of trajectories that maintain those characteristics, generalization to new situations through nonrigid registration, and interactive human refinement of the resulting model through kinesthetic teaching. We validated TLGC through several real-world experiments with several robotic platforms. For more information, see the reference section.

![Jaco performing a skill](http://www.ahmadzadeh.info/_/rsrc/1481221808081/research/jaco6.jpg?height=345&width=400)

<!-- https://github.com/gt-rail-internal/GeneralizedCylinder/blob/master/jaco6.jpg?raw=true "Jaco2" -->


## Summary ##

This package uses Differential Geometry to encode the given set of demonstrations to learn a model for the demonstrated skill. The model is constructed as a Generalized Cylinder (GC). The algorithm can also reproduce new trajectories from any initial pose inside the Generalized Cylinder. The reproduced trajectories preserve the main features of the demonstrated skill. For more detail, see the reference section.


## Results ##

Check the [Wiki](https://github.com/rezaahmadzadeh/TLGC/wiki) for more illustrations, results, descriptions, etc.


## Info ##

### Current Contributors: ###
*  Reza Ahmadzadeh - Georgia Tech - [Feb. 2016] - (reza.ahmadzadeh@gatech.edu) 

### Previous Contributors: ###
*  Roshni Kaushik - Rice University - [Jun. 2016 - Aug. 2016] - MATLAB
*  Assia Benbihi - Georgia Tech - [Sep. 2016 - Dec. 2016] - MATLAB, C++
*  Hanbeen Kim - Georgia Tech - [Feb. 2017 - May 2017] - Python
*  Muhammad Asif Rana - Georgia Tech - [Since Jan. 2017] - MATLAB, ROS
*  Josh Ting - Georgia Tech - [May. - Dec. 2017] - Python, ROS


### Version ###
*  2.0

### What is new? ###
This version of the TLGC algorithm is available as opensource under GNU GPL v3.0.
Several bugs have been fixed and multiple scripts have been improved.

### How do I get set up? ###

#### MATLAB ####
* The algorithm is coded in MATLAB
* No extra Toolbox is required
* clone the repository, `git clone https://github.com/rezaahmadzadeh/TLGC.git`
* In Matlab, set the `Matlab` folder as the current path and run the `main.m` file.
* There are several datasets included that can be set on the main script.
* To change the dataset, change the filename when loading the `.mat` file (line 23).
* To reproduce new trajectories after the learning process, set `reproduceIt` flag to `true`.

#### PYTHON ####
* Not available for this demo version (Being developed and debugged)

#### ROS ####
* Not available for this demo version (Being developed and debugged)

### Contribution guidelines ###

I would appreciate your contribution to this repo in following ways:

* Implementing in different programming languages - Python, C++
* Implementing in ROS
* Adding a new dataset - including artificial data or demonstrations captured from a real-robot
* Testing and Debugging the code
* Improving the code - by proposing new/more efficient solutions to the existing problems
* Extending the approach - by proposing, implementing, and testing novel ideas 

### Who do I talk to? ###

* Owner: Reza Ahmadzadeh (reza.ahmadzadeh@gatech.edu)



## References and Citation ##
If you use this code (even in part) please cite the following papers:

* Our RSS 2017 paper:



		@INPROCEEDINGS{ahmadzadeh2017generalized,
		TITLE={Generalized Cylinders for Learning, Reproduction,Generalization, and Refinement of Robot Skills},
		AUTHOR={Ahmadzadeh, S. Reza and Rana Muhammad Asif and Chernova, Sonia},
		BOOKTITLE={Robotics: Science and Systems ({RSS} 2017)},
		YEAR={2017},
		MONTH={July},
		ADDRESS={Cambridge, Massachusetts, USA}
		}
        
        
* Our Humanoids 2016 paper:



		@INPROCEEDINGS{ahmadzadeh2016trajectory,
		TITLE={Trajectory Learning from Demonstration with Canal Surfaces: A Parameter-free Approach},
		AUTHOR={Ahmadzadeh, Seyed Reza and Kaushik, Roshni and Chernova, Sonia},
		BOOKTITLE={Humanoid Robots ({H}umanoids), 2016 {IEEE-RAS} International Conference on},
		YEAR={2016},
		MONTH={November},
		ORGANIZATION={IEEE},
		PAGES={544--549}
		}


* Our IJCAI-2016 workshop paper:


		@INPROCEEDINGS{ahmadzadeh2016encoding,
		TITLE={Encoding Demonstrations and Learning New Trajectories using Canal Surfaces},
		AUTHOR={Ahmadzadeh, Seyed Reza and Chernova, Sonia},
		BOOKTITLE={25th Inernational joint Conference on Artificial Intelligence ({IJCAI} 2016), orkshop on Interactive Machine Learning: Connecting Humans and Machines},
		PAGES={1--7},
		YEAR={2016},
		MONTH={July},
		ADDRESS={New York City, NY, USA},
		ORGANIZATION={{IEEE}}
		}

* Our RSS-2016 workshop paper:


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


