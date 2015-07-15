// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  File:    minkowski.asy
//  Author:  Thomas Mueller, University of Stuttgart, VISUS
//
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

import graph;
import geometry;
defaultpen(fontsize(10pt)+linewidth(1));

size(2.8inch);

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

real beta = 0.5;
real gam  = 1.0/sqrt(1-beta*beta);
real psi  = atan(beta);
real h = 1.0;
int  NSticks = 6;
real ts = 0.08;

real cs = 6.5;
real lw = 1;
real lwS = 1;


pair P = (3.3,2.8);
pair o = (0.0,0.0);

pen op = rgb(0,0.6,0.0);

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

pair lorentzTrafo( pair q ) {
    real x  = q.x;
    real ct = q.y;
    return gam*(x-beta*ct,ct-beta*x);
}

real hb1(real x) {
    return sqrt(h^2+x^2);
}

real hb2(real x) {
    return sqrt(x^2-h^2);
}

draw(line((-0.2,0),false,(cs,0),false),linewidth(lw),Arrow(2mm));
draw(line((0,-0.2),false,(0,cs),false),linewidth(lw),Arrow(2mm));
label("$x$",(cs,0),align=S);
label("$ct$",(0,cs),align=W);


for(int i=0; i<=6; ++i) {
  draw(line((i,-ts),false,(i,ts),false));
}
for(int i=0; i<=6; ++i) {
  draw(line((-ts,i),false,(ts,i),false));
}

label("\small $1$",align=S,(1,-0.05));
label("\small $1$",align=W,(-0.05,1));

h = 1.0;
draw(graph(hb1,0,6,n=100),gray+dashed);
h = 2.0;
//draw(graph(hb1,0,6,n=100),gray+dashed);
h = 3.0;
draw(graph(hb1,0,5.5,n=100),gray+dashed);
h = 4.0;
//draw(graph(hb1,0,5,n=100),gray+dashed);
h = 5.0;
draw(graph(hb1,0,4,n=100),gray+dashed);

h = 1.0;
draw(graph(hb2,1,6,n=100),gray+dashed);
h = 2.0;
//draw(graph(hb2,2,6,n=100),gray+dashed);
h = 3.0;
draw(graph(hb2,3,6,n=100),gray+dashed);
h = 4.0;
//draw(graph(hb2,4,6,n=100),gray+dashed);
h = 5.0;
draw(graph(hb2,5,6,n=100),gray+dashed);

draw((0,0)--(6,6),red);

// System S'
draw((0,0)--(cs+0.5)*(cos(psi),sin(psi)),linewidth(lwS)+blue,Arrow(2mm));
draw((0,0)--(cs+0.5)*(sin(psi),cos(psi)),linewidth(lwS)+blue,Arrow(2mm));
label("$x'$",(cs+0.5)*(cos(psi),sin(psi)),align=S,blue);
label("$ct'$",(cs+0.5)*(sin(psi),cos(psi)),align=W,blue);

for(int i=0; i<NSticks; ++i) {
    real ct = gam*beta*i;
    real x  = gam*i;
    pair p1 = (x,ct) - ts*(-sin(psi),cos(psi));
    pair p2 = (x,ct) + ts*(-sin(psi),cos(psi));
    draw(p1--p2,linewidth(lwS)+blue);
    pair p3 = (ct,x) - ts*(cos(psi),-sin(psi));
    pair p4 = (ct,x) + ts*(cos(psi),-sin(psi));
    draw(p3--p4,linewidth(lwS)+blue);
    //dot((x,ct),3bp+black);
}
//label("$\tiny 1$",align=S,(gam,gam*beta),blue);
//label("$\tiny 1$",align=W,(gam*beta,gam),blue);


draw((P.x,0)--P,linewidth(lw)+black+dashed);
draw((0,P.y)--P,linewidth(lw)+black+dashed);
dot(P,3bp+black);
label("\small $p$",P,align=NE);
label("\small $x_p$",(P.x,0),align=S);
label("\small $ct_p$",(0,P.y),align=W);

pair Ps = lorentzTrafo(P);
draw(Ps.x*gam*(1,beta)--P,linewidth(lwS)+blue+dashed);
draw(Ps.y*gam*(beta,1)--P,linewidth(lwS)+blue+dashed);
label("\small $x'_p$",Ps.x*gam*(1,beta),align=S,blue);
label("\small $ct'_p$",Ps.y*gam*(beta,1),align=W,blue);

draw(arc((0,0),0.85,0,psi/pi*180),linewidth(lwS)+blue);
label("\small $\psi$",(0.65,0.17),blue);
draw(arc((0,0),0.85,90-psi/pi*180,90),linewidth(lwS)+blue);
label("\small $\psi$",(0.15,0.65),blue);

dot(o,3bp+op);
label("$o$",o,align=SW,op);
