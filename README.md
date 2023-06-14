
<!-- ABOUT THE PROJECT -->
## About The Project

<!--[![Product Name Screen Shot][product-screenshot]](https://example.com)-->

Can you realize a real-time video game, in Matlab, by using a biaxial accelerometer as user interface? You can use the accelerometer to decide the movement directions and the speed of your avatar. 

For this experience you can choose to implement the mini-project with the DAQ NI-6221 and the external analog accelerometer, or you can also choose to use the accelerometer in your smartphone (please read the guide for acquiring data from sensors by using the Matlab app). Try to understand the differences between these two possibile implementations!

Then, after that you have chosen the implementation for your first mini-project, you can start to work on the flowchart. More details on the game will be provided in the next chapter.


<!-- DESCRIPTION THE PROJECT -->
## About The Project
The purpose of the game is to capture a given number of "coins" randomly placed in a square map. 

The gamer (i.e. your avatar) can move in the four directions (up-down, left-right) in the map by using a biaxial accelerometer as a user interface. When instead the acceleration is below a given threshold (near zero)  the speed should be zero, so the gamer remains in the same position. You can optionally implement different speeds by considering also the information about the inclination of your sensor. 

For the sake of simplicity, let's assume only one speed, if the accelerometer measures an acceleration greater than a given value along the x-axis, you can move the player of +1 position along this direction. The same for the other y-axis. It means that, if (x(iT),y(iT)) is the position on the map in the time instant i, then in the next time instant i+1 the new position will be (x(i+1)T,y(i+1)T)=(x(i)T+m∗Δx,y(i)T+n∗Δy) where the two increments Δx and Δy depends on the resolution of your map (e.g. you can choose 1 as increment) and the two factors m and n depend on the directions and can assume the following values: -1,+1.  The direction can be estimated by comparing the acceleration with a given threshold value.

The initial position of the gamer should correspond to the center of the map. 

Furthemore, the game should be terminated when the accelerometer is kept in an horizontal position for a given time interval and its position should be ri-initialized to the center of the map.

Optionally, you win if you are able to collect all the coins before the count-down timer expires!

<!-- Get started -->
## Get Started

For start:
1. Download and install the matlab mobile app
2. Register in the matlab Cloud 
3. Insert inside the matlab cloud my projects
4. Connect the phone with the matlab cloud
5. Start the Real Time game

## Contact

Giulio Savian  - giuliosavian@gmail.com

<!--Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)-->

