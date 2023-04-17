function [C_nmf,S_nmf,g] = RamanNMF(RamanShift,DMatrix,k)

DMatrix(DMatrix<0) = 0;

[W,H] = nnmf(DMatrix,k,'Replicates',50);

C_nmf = W;
S_nmf = H';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
for i = 1:k
    plot(RamanShift,S_nmf(:,i)./max(S_nmf(:,i))+k-1.3*(i-1),"LineWidth",1.5);
end
hold off
%区別しやすく
newcolors = {'#ff0000','#ff8000','#ffdd00','#4dff00','#0400ff','#ff00f2','#c2003a'};
colororder(newcolors)
box on;
ylim([-1 k+2])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g = gcf;

end