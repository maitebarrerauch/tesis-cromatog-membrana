function z=weno5(a,b,c,d,e)
% r=3
% Polynomial reconstructions in the three stencils
q1=a/3-7*b/6+11*c/6;
q2=-b/6+5*c/6+d/3;
q3=c/3+5*d/6-e/6;
% Smoothness indicators
S1=( 13*(a-2*b+c).^2+3*(a-4*b+3*c).^2 )/12;
S2=( 13*(b-2*c+d).^2+3*(d-b).^2 )/12;
S3=( 13*(c-2*d+e).^2+3*(3*c-4*d+e).^2 )/12;
%
ep=1e-6;
% Otras elecciones de ep
%ep=eps;
%ab=max(a.^2,b.^2);
%bc=max(ab,c.^2);
%cd=max(bc,d.^2);
%de=max(cd,e.^2);
%ep=1e-6*de+1e-15;
a1=1./( 10*(ep+S1).^2 );
a2=6./( 10*(ep+S2).^2 );
a3=3./( 10*(ep+S3).^2 );
% % Ideal weights for Central Upwinding 5:
% a1=1/10;
% a2=6/10;
% a3=3/10;
z=(a1.*q1+a2.*q2+a3.*q3)./(a1+a2+a3);