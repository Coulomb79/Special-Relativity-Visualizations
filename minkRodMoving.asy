// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  File:    minkRodMoving.asy
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

pair O1 = (0.0,4.5);
pair O2 = (5.5,6.5);

pen op = rgb(0,0.6,0.0);

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// from S to S'
pair LT( pair q ) {
    real x  = q.x;
    real ct = q.y;
    return gam*(x-beta*ct,ct-beta*x);
}

// from S' to S
pair invLT( pair q ) {
    real xs = q.x;
    real cts = q.y;
    return gam*(xs+beta*cts,cts+beta*xs);
}

pair intersec( real xs, pair o, real pm ) {
    real x = gam*(1-pm*beta)*xs + beta*(o.y+pm*o.x)/(1+pm*beta);
    real ct = (o.y+pm*o.x)/(1+pm*beta) - pm*gam*(1.0 - pm*beta)*xs;
    return (x,ct);
}

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

// -------------------------------
//  System S'
// -------------------------------
draw((0,0)--(cs+0.5)*(cos(psi),sin(psi)),linewidth(lwS)+gray,Arrow(2mm));
draw((0,0)--(cs+0.5)*(sin(psi),cos(psi)),linewidth(lwS)+gray,Arrow(2mm));
label("$x'$",(cs+0.5)*(cos(psi),sin(psi)),align=S,gray);
label("$ct'$",(cs+0.5)*(sin(psi),cos(psi)),align=W,gray);

for(int i=0; i<NSticks; ++i) {
    real ct = gam*beta*i;
    real x  = gam*i;
    pair p1 = (x,ct) - ts*(-sin(psi),cos(psi));
    pair p2 = (x,ct) + ts*(-sin(psi),cos(psi));
    draw(p1--p2,linewidth(lwS)+gray);
    pair p3 = (ct,x) - ts*(cos(psi),-sin(psi));
    pair p4 = (ct,x) + ts*(cos(psi),-sin(psi));
    draw(p3--p4,linewidth(lwS)+gray);
    //dot((x,ct),3bp+black);
}
//label("$\tiny 1$",align=S,(gam,gam*beta),blue);
//label("$\tiny 1$",align=W,(gam*beta,gam),blue);

pair w1p = (gam,gam*beta);
pair w2p = (2*gam,2*gam*beta);
pair dw  = (beta,1);

// worldlines of the left and right endings of the rod
draw((w1p-0.7*dw)--(w1p+5.5*dw),1bp+gray+dashed);
draw((w2p-1.3*dw)--(w2p+4.9*dw),1bp+gray+dashed);
draw(w1p--w2p,linewidth(lwB)+gray);
label("$l'$",align=N,(w1p+w2p)/2,gray);
label("$\mathcal{W}_1$",align=N,(w1p+5.5*dw),gray);
label("$\mathcal{W}_2$",align=N,(w2p+4.9*dw),gray);

// -------------------------------
//  backward light cone of O1
// -------------------------------
draw(O1--(O1+2.8*(1,-1)),red+dashed);

// backward light cone of O2
draw(O2--(O2+3.2*(-1,-1)),red+dashed);

// -------------------------------
//  Observer 1
// -------------------------------
draw((O1.x,-0.2)--(O1.x,5.5),op+dashed);
dot(O1,6bp+op);
label("$O_1$",O1,align=NE,op);

// -------------------------------
//  Observer 2
// -------------------------------
draw((O2.x,-0.2)--(O2.x,6.2),op+dashed);
dot(O2,6bp+op);
label("$O_2$",O2,align=E,op);

// -------------------------------
//  apparent rod as seen by O1
// -------------------------------
pair w1s1 = intersec(1,O1,1);
pair w2s1 = intersec(2,O1,1);
draw(w1s1--w2s1,3bp+op);
dot(w1s1,4bp+black);
dot(w2s1,4bp+black);
label("$P_{1l}$",w1s1,align=W);
label("$P_{1r}$",w2s1,align=E);

// -------------------------------
//  apparent rod as seen by O2
// -------------------------------
pair w1s2 = intersec(1,O2,-1);
pair w2s2 = intersec(2,O2,-1);
draw(w1s2--w2s2,3bp+op);
dot(w1s2,4bp+black);
dot(w2s2,4bp+black);
label("$P_{2l}$",w1s2,align=NW);
label("$P_{2r}$",w2s2,align=SE);

pair w1l = (1/gam,0);
pair w1r = (2/gam,0);
draw(w1l--w1r,3bp+blue);
label("$l$",(w1l+w1r)/2,align=N,blue);


