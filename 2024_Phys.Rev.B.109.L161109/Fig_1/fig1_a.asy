size(200);
settings.outformat="pdf";
settings.prc = false;
settings.render = 0;
import graph3;
import three;
import solids;
// size(4cm,4cm);
currentprojection=orthographic(7,1/2,1/2,up=Z);
pen viridis1 = rgb(0.127568, 0.566949, 0.550556);
pen viridis2 = rgb(0.267004, 0.004874, 0.329415);
pen viridis3 = rgb(0.229739, 0.322361, 0.545706);
pen viridis4 = rgb(0.127568, 0.566949, 0.550556);
pen viridis5 = rgb(0.369214, 0.788888, 0.382914);
pen viridis6 = rgb(0.993248, 0.906157, 0.143936);

pen viridis7 = rgb(0.267004, 0.004874, 0.329415);
pen viridis8 = rgb(0.163625, 0.471133, 0.558148);
pen viridis9 = rgb(0.477504, 0.821444, 0.318195);


triple circleCenter = (0,0,0);
path3 mycircle = circle(c=circleCenter, r=1,normal=Z);
path3 mycircle2 = circle(c=circleCenter, r=1,normal=Z);
// shift mycircle2 upwards
mycircle2 = shift(0,0,0.2)*mycircle2;

int n = 14;

real i1 = 0.9;
real i2 = 2;
real i3 = 3.1;
path3 pathlower = subpath(mycircle,reltime(mycircle,i1/n),reltime(mycircle,i3/n));// -- subpath(mycircle2,reltime(mycircle2,i2/n),reltime(mycircle2,i3/n)) -- cycle;
path3 pathupper = subpath(mycircle2,reltime(mycircle2,i3/n),reltime(mycircle2,i1/n));// -- subpath(mycircle2,reltime(mycircle2,i2/n),reltime(mycircle2,i3/n)) -- cycle;
draw(shift(0,0,-0.07)*scale(1,1,1.55)*surface(pathlower--pathupper --cycle), emissive(0.7*viridis8+opacity(0.3)));

real i1 = -3.1;
real i2 = -2;
real i3 = -0.9;
pathlower = subpath(mycircle,reltime(mycircle,i1/n),reltime(mycircle,i3/n));// -- subpath(mycircle2,reltime(mycircle2,i2/n),reltime(mycircle2,i3/n)) -- cycle;
pathupper = subpath(mycircle2,reltime(mycircle2,i3/n),reltime(mycircle2,i1/n));// -- subpath(mycircle2,reltime(mycircle2,i2/n),reltime(mycircle2,i3/n)) -- cycle;
draw(shift(0,0,-0.07)*scale(1,1,1.55)*surface(pathlower--pathupper --cycle), emissive(0.7*viridis9+opacity(0.3)));


// draw half of the circle with solid pen
draw(subpath(mycircle,-1.0,1.0), solid+black);
// draw the other half with dashed pen
draw(subpath(mycircle,1.0,3.0), solid+black);

draw(subpath(mycircle2,-1.0,1.0), solid+black);
// draw the other half with dashed pen
draw(subpath(mycircle2,1.0,3.0), solid+black);

// revolution cyl=cylinder(circleCenter,1,0.2,circleCenter+(0,0,0.2));


// draw(subsurface(surface(cyl),1.0,3.0),black+opacity(0.5));

triple p, p1;
p = (1,0,0);
p1 = p+(0,0,0.2);
path3 intU = p -- p1;
draw(intU, 1.5+viridis2);
// add text at the midpoint of the line
label("$\propto U$", midpoint(intU)-(0.0,0.02,0.03), align=2*dir(0), p=fontsize(8pt)+viridis2);

pen vir = rgb(0.250425, 0.27429, 0.533103);
path3 intd = subpath(mycircle,0,reltime(mycircle,-1/n));
draw(intd, 1.5+vir);
label("$\propto \Delta$", midpoint(intd)+(0.0,-0.1,0.05), align=2*dir(0), p=fontsize(8pt)+vir);

for(int i=0;i<n;++i){
    p =(cos(i*2*pi/n),sin(i*2*pi/n),0);
    p1 = p + (0,0,0.2);
    dot(p, 3.5+black);
    dot(p1, 3.5+black);

  }

  // draw a part of the circle with an arrow
  path3 arrow1 = shift(0, 0,-0.04)*subpath(mycircle,reltime(mycircle,1/n),reltime(mycircle,3/n));
  draw(arrow1, 1.5+viridis8, arrow=Arrow3(TeXHead2(normal=Z),position=Relative(1),size=1.25));
  path3 arrow2 = shift(0, 0,-0.04)*subpath(mycircle2,reltime(mycircle2,1/n),reltime(mycircle2,3/n));
  draw(arrow2, 1.5+viridis8, arrow=Arrow3(TeXHead2(normal=Z),position=Relative(1),size=1.25));
  // p = (cos(3*2*pi/n),sin(3*2*pi/n),0);
  // label("$Q_3^{+}$", p, p=fontsize(8pt)+viridis2);
  label("$Q_3^{+}$", shift(0,0,0.15)*endpoint(arrow1), align=2*dir(0), p=fontsize(8pt)+viridis8);

  path3 arrow3 = shift(0,0,-0.04)*subpath(mycircle,reltime(mycircle,-1/n),reltime(mycircle,-3/n));
  draw(arrow3, 1.5+viridis9, arrow=Arrow3(TeXHead2(normal=Z),position=Relative(1),size=1.25));
  path3 arrow4 = shift(0,0,-0.04)*subpath(mycircle2,reltime(mycircle2,-3/n),reltime(mycircle2,-1/n));
  draw(arrow4, 1.5+viridis9, arrow=Arrow3(TeXHead2(normal=Z),position=Relative(1),size=1.25));
  // p = (cos(11*2*pi/n),sin(11*2*pi/n),0);
  // label("$Q_3^{-}$", p, p=fontsize(8pt)+viridis4);
  label("$Q_3^{-}$", shift(0,-2.18,0.14)*endpoint(arrow1), align=2*dir(0), p=fontsize(8pt)+viridis9);