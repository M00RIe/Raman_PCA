function [Concentrations,Speceis,ccr,PC] = RamanPCA(RamanShift,DataMatrix,NumberOfSpecies)

%average of DataMatrix
mean_DataMatrix = mean(DataMatrix,"all");
DataMatrix_centered = DataMatrix - mean_DataMatrix;

%SVD
[U,D,V] = svd(DataMatrix_centered);
k = NumberOfSpecies;
PC = diag(D);
Trace_D = sum(D,"all");

U = U(:,1:k);
D = D(1:k,1:k);
V = V(:,1:k);

%n*k
Concentrations = U;

%t*k 転置が必要
%プロットは残差のmin(Y_svd)は垂直方向の補正する必要ありそう
Speceis = V*D + mean_DataMatrix;

plot(RamanShift,Speceis,"LineWidth",1);

xlabel('Raman Shift [cm^{-1}]','FontName','Times','FontSize',15)
ylabel('Intensity [a.u.]','FontName','Times','FontSize',15)
Plot_spec

figure
S = stackedplot(RamanShift,Speceis);
S.LineWidth = 1;

%累積寄与率
ccr = trace(D)/Trace_D;
end