# epipolarLines

          1.	Introduction

Stereo matching is the process of taking two or more images and estimating a 3D model of the scene by finding matching pixels in the images and converting their 2D positions into 3D depths1. The depth of a scene point along the corresponding projection ray is not directly accessible in a single image. Here's how we can see it with a simple experiment. With our two eyes open, we keep our finger at our eye level, and if we start opening and closing our right or left eyes, our finger will shift to the right or left depending on the background. The same phenomenon will also apply to photos taken from two different points. Through epipolar geometry, we can compute the corresponding point an image when given points in the other image. This report includes epipolar geometry, calculating this geometry, and explaining it with the help of the Matlab software on a pair of images.


        2.	Epipolar Geometry

Consider the images x0 and x1 of a point P observed by two cameras with optical centers c0 and c1. Epipolar plane defined by P, c0 and c1. The point c0 lies on the line e0 where this plane and the second camera intersect. The line l1 is the epipolar line associated with the point x0, and it passes through the point e1 where the baseline joining the optical centers c0 and c1. Likewise, the epipolar line l0 associated with the point x1, and this line passes through the point e0. These e0 and e1 points are called epipole. Given x0, P can lie anywhere on the ray from c0 throguh x0. The image of this ray in the right image is the epipolar line through the corresponding point x1. As a result, corresponding points must lie on conjugate epipolar lines.


![image](https://user-images.githubusercontent.com/39493696/162598097-5eacd78d-51ef-4f25-9c0f-3e5628685f6c.png)

 Figure 1 Epipolar Geometry










 
          3.	Estimating the Epipolar Geometry
          
          
   3.1	Fundamental Matrix F

The fundamental matrix(3*3) is a relationship between any two images of the same scene that constrains where the projection of points from the scene can occur in both images2. Suppose that M0 and M1 are the matrices of the intrinsic parameters of the left and right camera, then the pixel coordinates x0 and x1 of x’0 and x’1 are:

x’0 =M0* x0 , x’1 =M1* x1

- Using the above equations and 𝒙𝟏𝑻*E*x0= 0 we have:
𝒙’𝟏𝑻*F* x’0=0

F = (M1	)	E*M0	= (M1	) R*S*M0	is called the fundamental matrix where E Essential Matrix.

As you can see, there is both the extrinsic and intrinsic parameters for the calculation of the fundamental matrix. It can also be found with the F matrix eight point algorithm3. In the case of extrinsic and intrinsic parameters, a brief information is given on how to obtain the F matrix to be used in the calculation. E matrix was not used in this assignment, so no explanation was made.

   3.2	Epipolar Line

When the coordinates of the point on an image and the Fundamental matrix are multiplied, coefficients of a linear equation are obtained. The x and y values obtained from the solution of this equation are the point and slope of the epipolar line. The corresponding point is located on this line.

EpipolarLine= [xn yn 1]*F	A*x + B*y + C = 0

Where A represent of first element, B is the second element and C is the third element of the EpipolarLine matrix[n*3] matrix respectively.














 https://en.wikipedia.org/wiki/Fundamental_matrix_(computer_vision)
 
 https://en.wikipedia.org/wiki/Eight-point_algorithm
