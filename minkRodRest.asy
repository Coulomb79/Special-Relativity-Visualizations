// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  File:    minkRodRest.asy
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
real lwB = 3.0;

pair O1 = (0.0,3.5);
pair O2 = (5.5,5.8);

pen op = rgb(0,0.6,0.0);

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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


pair w1p = (2,0);
pair w2p = (3,0);
pair dw = (0,1);

// worldlines of the left and right endings of the rod
draw((w1p-0.3*dw)--(w1p+5.5*dw),1bp+gray+dashed);
draw((w2p-0.3*dw)--(w2p+5.5*dw),1bp+gray+dashed);
label("$\mathcal{W}_1$",align=N,(w1p+5.5*dw),gray);
label("$\mathcal{W}_2$",align=N,(w2p+5.5*dw),gray);

// backward light cone of O1
draw(O1--(O1+3.1*(1,-1)),red+dashed);

// backward light cone of O2
draw(O2--(O2+3.7*(-1,-1)),red+dashed);

// Observer 1
draw((O1.x,-0.2)--(O1.x,5.5),op+dashed);
dot(O1,6bp+op);
label("$O_1$",O1,align=NE,op);

// Observer 2
draw((O2.x,-0.2)--(O2.x,6.2),op+dashed);
dot(O2,6bp+op);
label("$O_2$",O2,align=E,op);

// apparent rod as seen by O1
pair w1s1 = (w1p.x,O1.y-w1p.x);
pair w2s1 = (w2p.x,O1.y-w2p.x);
draw(w1s1--w2s1,3bp+op);
dot(w1s1,4bp+black);
dot(w2s1,4bp+black);
label("$P_{1l}$",w1s1,align=W);
label("$P_{1r}$",w2s1,align=E);

// apparent rod as seen by O2
pair w1s2 = (w1p.x,O2.y+w1p.x-O2.x);
pair w2s2 = (w2p.x,O2.y+w2p.x-O2.x);
draw(w1s2--w2s2,3bp+op);
dot(w1s2,4bp+black);
dot(w2s2,4bp+black);
label("$P_{2l}$",w1s2,align=NW);
label("$P_{2r}$",w2s2,align=SE);

draw(w1p--w2p,3bp+blue);
label("$l$",(w1p+w2p)/2,align=N,blue);


