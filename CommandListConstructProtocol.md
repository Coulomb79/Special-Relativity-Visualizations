
This is the list of commands to construct the basic file "ConstructSystem.ggb"
==============================================================================

by Oliver Fechtig

<!--
  Compile this file using pandoc to obtain a html version:  
    pandoc CommandListConstructProtocol.md -o CLCP.html -s -c CLCP.css
-->


<section>

Construction steps:
-------------------

1) Set speed of light by defining a constant  
    `c=1`

2) Set velocity by defining a Slider  
    `v=Slider[0, 0.999*c, 0.01, 1, 100, false, true, false, false]`  
    [Slider Command](https://wiki.geogebra.org/en/Slider_Command)
    
3) Set gamma factor by defining a variable (greek symbol gamma via hot keys "Alt+g")  
    `γ=1/sqrt(1-(v/c)^2)`
    
4) Define the origin point  
    `O=(0, 0, 0)`
    
5) Define a point on the x'-axis of the moving frame:  
    `X'_0=(c, 0, v)`

6) Define a point on the ct'-axis of the moving frame:  
    `CT'_0=(v, 0, c)`

7) The x'-axis-line can be defined by means of a straight line  
    `X'_{axis}=Line[O, X'_0]`  
    [Line Command](https://wiki.geogebra.org/en/Line_Command)
    
8) The ct'-axis-line can also be defined by means of a straight line  
    `CT'_{axis}=Line[O, CT'_0]`

9) To define a clipping box, we first have to enter Corners points in 
   the following way (used in our file):  
    `Corner_{1}=Corner[-1,1]`  
    `Corner_{2}=Corner[-1,2]`  
    `Corner_{3}=Corner[-1,3]`  
    `Corner_{4}=Corner[-1,4]`  
    `Corner_{5}=Corner[-1,5]`  
    `Corner_{6}=Corner[-1,6]`  
    `Corner_{7}=Corner[-1,7]`  
    `Corner_{8}=Corner[-1,8]`  
    [Corner Command](https://wiki.geogebra.org/en/Corner_Command)
    
10) Faces of the clipping box are defined using polygons  
    `face_{1,2,3,4}=Polygon[Corner_{1}, Corner_{2}, Corner_{3}, Corner_{4}]`  
    `face_{5,6,7,8}=Polygon[Corner_{5}, Corner_{6}, Corner_{7}, Corner_{8}]`  
    `face_{1,2,6,5}=Polygon[Corner_{1}, Corner_{2}, Corner_{6}, Corner_{5}]`  
    `face_{2,3,7,6}=Polygon[Corner_{2}, Corner_{3}, Corner_{7}, Corner_{6}]`  
    `face_{3,4,8,7}=Polygon[Corner_{3}, Corner_{4}, Corner_{8}, Corner_{7}]`  
    `face_{1,4,8,5}=Polygon[Corner_{1}, Corner_{4}, Corner_{8}, Corner_{5}]`  
    [Polygon Command](https://wiki.geogebra.org/en/Polygon_Command)

11) Intersection points of the x'-axis-line with the corresponding faces 
    (watch out: GGB sets the indices to "1" and "2", must be adjusted manually within 
    the property window -> name. Seems to be a bug in the current GGB version):  
    `X'_{min}=Intersect[X'_{axis}, face_{1,4,8,5}]`  
    `X'_{max}=Intersect[X'_{axis}, face_{2,3,7,6}]`  
    [Intersect Command](https://wiki.geogebra.org/en/Intersect_Command)
    
12) Intersection points of the ct'-axis-line with the corresponding faces 
    (same index bug as in step 11):
    `CT'_{min}=Intersect[CT'_{axis}, face_{1,2,3,4}]`  
    `CT'_{max}=Intersect[CT'_{axis}, face_{5,6,7,8}]`  

    Note: in this simple version, these points can get the status >undefined<, 
    when the velocity becomes too big or the width of the 3D window is too small. 
    Therefore, the following axis vectors are also undefined and will disappear 
    in this case.    

13) Set the vectors of the axes of the moving frame by means of defining vectors  
    `x'_{axis}=Vector[X'_{min}, X'_{max}]`  
    `ct'_{axis}=Vector[CT'_{min}, CT'_{max}]`  
    [Vector Command](https://wiki.geogebra.org/en/Vector_Command)
    
14) Set the scaling marks of the moving frame by means of defining sequences  
    `x'_{scale}=Sequence[(n*γ*c,0, n*γ*v), n, ceil(x(Corner_{1})), floor(x(Corner_{2}))]`  
    `ct'_{scale}=Sequence[(n*γ*v,0, n*γ*c), n, ceil(z(Corner_{1})), floor(z(Corner_{5}))]`  
    [Sequence Command](https://wiki.geogebra.org/en/Sequence_Command)    
    
15) Define the X'- CT' - coordinate plane via:  
    `X'CT'_{plane}=Plane[X'_{axis}, CT'_{axis}]`  
    [Plane Command](https://wiki.geogebra.org/en/Plane_Command)
    
16) Fix the point A to reside in the X'- CT' - coordinate plane:  
    `A=PointIn[X'CT'_{plane}]`  
    [PointIn Command](https://wiki.geogebra.org/en/PointIn_Command)
    
17) Paraxial lines through A:  
    `X'_{parallel}=Line[A, X'_{axis}]`  
    `CT'_{parallel}=Line[A, CT'_{axis}]`  
    
18) Intersection of paraxial lines with coordinate axes:  
    `X'_{coord}=Intersect[CT'_{parallel}, X'_{axis}]`  
    `CT'_{coord}=Intersect[X'_{parallel}, CT'_{axis}]`  

19) Line segments of the coordinates of A: Defining line segments  
    `x'_{coord}=Segment[A, X'_{coord}]`  
    `ct'_{coord}=Segment[A, CT'_{coord}]`  
    
20) Setting colors of objects (only one example)  
    `SetColor[x'_{scale}, 1, 0, 0]`  
    `SetColor[ct'_{scale}, 0, 0, 1]`

21) The values of the coordinates X'_{coord} and ct'_{coord} of A with respect to S'
    can be determined by
    `x'_A=Distance[X'_{coord}, O] / (γ sqrt(v^2 + c^2)) sgn(x(X'_{coord}))`
    `ct'_A=Distance[CT'_{coord}, O] / (γ sqrt(v^2 + c^2)) sgn(z(CT'_{coord}))`

</section>


<section>
Plane list of commands:
-----------------------
    c=1  
    v=Slider[0, 0.999*c, 0.01, 1, 100, false, true, false, false]  
    γ=1/sqrt(1-(v/c)^2)  
    O=(0, 0, 0)  
    X'_0=(c, 0, v)  
    CT'_0=(v, 0, c)  
    X'_{axis}=Line[O, X'_0]  
    CT'_{axis}=Line[O, CT'_0]  
    Corner_{1}=Corner[-1,1]  
    Corner_{2}=Corner[-1,2]   
    Corner_{3}=Corner[-1,3]  
    Corner_{4}=Corner[-1,4]  
    Corner_{5}=Corner[-1,5]  
    Corner_{6}=Corner[-1,6]  
    Corner_{7}=Corner[-1,7]  
    Corner_{8}=Corner[-1,8]  
    face_{1,2,3,4}=Polygon[Corner_{1}, Corner_{2}, Corner_{3}, Corner_{4}]  
    face_{5,6,7,8}=Polygon[Corner_{5}, Corner_{6}, Corner_{7}, Corner_{8}]  
    face_{1,2,6,5}=Polygon[Corner_{1}, Corner_{2}, Corner_{6}, Corner_{5}]  
    face_{2,3,7,6}=Polygon[Corner_{2}, Corner_{3}, Corner_{7}, Corner_{6}]  
    face_{3,4,8,7}=Polygon[Corner_{3}, Corner_{4}, Corner_{8}, Corner_{7}]  
    face_{1,4,8,5}=Polygon[Corner_{1}, Corner_{4}, Corner_{8}, Corner_{5}]      
    X'_{min}=Intersect[X'_{axis}, face_{1,4,8,5}]  
    X'_{max}=Intersect[X'_{axis}, face_{2,3,7,6}]  
    CT'_{min}=Intersect[CT'_{axis}, face_{1,2,3,4}]  
    CT'_{max}=Intersect[CT'_{axis}, face_{5,6,7,8}]  

Here, you have to rename the indices '1' and '2' to 'min' and 'max' because
of the above mentioned bug.

    x'_{axis}=Vector[X'_{min}, X'_{max}]  
    ct'_{axis}=Vector[CT'_{min}, CT'_{max}]  
    x'_{scale}=Sequence[(n*γ*c, 0, n*γ*v), n, ceil(x(Corner_{1})), floor(x(Corner_{2}))]  
    ct'_{scale}=Sequence[(n*γ*v, 0, n*γ*c), n, ceil(z(Corner_{1})), floor(z(Corner_{5}))]  
    X'CT'_{plane}=Plane[X'_{axis}, CT'_{axis}]  
    A=PointIn[X'CT'_{plane}]  
    X'_{parallel}=Line[A, X'_{axis}]  
    CT'_{parallel}=Line[A, CT'_{axis}]  
    X'_{coord}=Intersect[CT'_{parallel}, X'_{axis}]  
    CT'_{coord}=Intersect[X'_{parallel}, CT'_{axis}]  
    x'_{coord}=Segment[A, X'_{coord}]  
    ct'_{coord}=Segment[A, CT'_{coord}]  
    SetColor[x'_{scale}, 1, 0, 0]  
    SetColor[ct'_{scale}, 0, 0, 1]  

</section>

***END***
