// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  File:    minkLengthTime.asy
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

// System S'
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

pair w1p = 2*(gam,gam*beta);
pair w2p = 3*(gam,gam*beta);
pair dw  = (beta,1);

// worldlines of the left and right endings of the rod
draw((w1p-1.3*dw)--(w1p+5.0*dw),1bp+gray+dashed);
draw((w2p-1.9*dw)--(w2p+4.4*dw),1bp+gray+dashed);
draw(w1p--w2p,linewidth(lwB)+gray);
label("$l'$",align=N,(w1p+w2p)/2,gray);
label("$\mathcal{W}_1$",align=N,(w1p+5.0*dw),gray);
label("$\mathcal{W}_2$",align=N,(w2p+4.4*dw),gray);

label("$x'_l$",w1p,align=NW,gray);
label("$x'_r$",w2p+(0.1,0),align=S,gray);

real ct0 = 4.0;
pair w1l = (2/gam+beta*ct0,ct0);
pair w1r = (3/gam+beta*ct0,ct0);

pair O1 = w1l;
draw((O1.x,-0.2)--(O1.x,5.5),op+dashed);
label("$O_1$",(O1.x,5.5),align=N,op);

pair O2 = w1r;
draw((O2.x,-0.2)--(O2.x,5.5),op+dashed);
label("$O_2$",(O2.x,5.5),align=N,op);

pair O3 = 2*gam*(beta,1);
draw((O3.x,-0.2)--(O3.x,5.5),op+dashed);
label("$O_3$",(O3.x,5.5),align=N,op);

draw((O3.x,0.0)--O3,2bp+blue);
draw((0.0,0.0)--O3,2bp+gray);
label(rotate(90)*"$c\Delta t$",(1.2,1.4),align=E,blue);
label(rotate(90-psi/pi*180)*"$c\Delta t'$",O3/2-(0.1,0),align=NW,gray);

draw((0,ct0)--(w1r),blue+dashed);
draw(w1l--w1r,3bp+blue);
label("$l$",(w1l+w1r)/2,align=N,blue);
label("$ct_0$",(0,ct0),align=W,blue);

dot(O3,4bp+black);
label("$q$",O3,align=E);

label("$ct'_l$",w1l,align=NW,op);
label("$ct'_r$",w1r,align=E,op);
label("$x_1$", (w1l.x,-0.15),align=S,op);
label("$x_2$", (w1r.x,-0.15),align=S,op);
