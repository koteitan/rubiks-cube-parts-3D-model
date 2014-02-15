/*
 Parts of Rubik's Cube
*/

precision=30; /* precision of the surface */
apart=0.5;    /* distance of the pieces */

mrc3d();

module mrc3d(){
 color([1,0,0])corner();
 color([0,1,0])edge();
 color([0,0,1])center();
 color([1,0,1])volt();
}

module volt(){
 v([ 0,90,0]);
 v([90,90,0]);
 v([ 0, 0,0]);
}
module v(r){
  rotate(r)cylinder(h = 1/3, r=1/36, $fn=fn,center=true);
}

module center(){
 c(-1,0,0,[ 0,90,0]);c(+1,0,0,[ 0,90,0]);
 c(0,-1,0,[90,90,0]);c(0,+1,0,[90,90,0]);
 c(0,0,-1,[ 0, 0,0]);c(0,0,+1,[ 0, 0,0]);
}
module c(x,y,z,rot){
 translate([x,y,z]*apart){
  difference(){
   translate([x,y,z]/3)
    cube(size=1/3, center=true);
   sphere(r=1/3+1/9, $fn=precision,center=true);
  }
   translate([x/3,y/3,z/3])
    rotate(rot)
     cylinder(h = 1/3, r=1/36, $fn=fn,center=true);
 }
}

module edge(){
 e(-1,-1,0);e(+1,-1,0);e(-1,+1,0);e(+1,+1,0);
 e(-1,0,-1);e(+1,0,-1);e(-1,0,+1);e(+1,0,+1);
 e(0,-1,-1);e(0,+1,-1);e(0,-1,+1);e(0,+1,+1);
}
module e(x,y,z){
 translate([x,y,z]*apart){
  difference(){
   translate([x,y,z]/3)cube(size=1/3,center=true);
   sphere(r=1/3+1/9, $fn=precision,center=true);
  }
  intersection(){
   sphere(r=1/3+1/9, $fn=precision,center=true);
   translate([x*(1/3+1/9)/2,y*(1/3+1/9)/2,z*(1/3+1/9)/2])
    cube(size=[
     (1-abs(x))*1/18+abs(x)*(1/3+1/9),
     (1-abs(y))*1/18+abs(y)*(1/3+1/9),
     (1-abs(z))*1/18+abs(z)*(1/3+1/9)
    ],center=true);
   }
  }
}


module corner(){
 for(x=[-1,+1]){for(y=[-1,+1]){for(z=[-1,+1]){
  translate([x,y,z]*apart){
   union(){
    translate([x,y,z]/3)cube(size=1/3, center=true);
   intersection(){
    sphere(r=1/3+1/9, $fn=precision);
    translate([x,y,z]*(1/3+1/9)/2)
     cube(size=1/3+1/9,center=true);
   }
   }
  }
 }}}
}


