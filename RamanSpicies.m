function RamanSpicies(RamanShift,DataMatrix,C,S,n)
figure
[~,K] = size(C);

hold on
Labels_P = cell(1,K+2);

for i = 1:K
    S_pc = C(n,i)*(S(:,i))';
    Q(i) = plot(RamanShift,S_pc,"LineWidth",2);
    
    Labels_P{i} = string(i);
end
Q(K+1) = plot(RamanShift,DataMatrix(n,:),'k--',"LineWidth",1);
Q(K+2) = plot(RamanShift,C(n,:)*S','k',"LineWidth",1.5);

hold off

%区別しやすく
newcolors = {'#ff0000','#ff8000','#ffdd00','#4dff00','#0400ff','#ff00f2','#c2003a'};
colororder(newcolors)
box on;

xlabel('Raman Shift [cm^{-1}]','FontName','Times','FontSize',15)
ylabel('Intensity [a.u.]','FontName','Times','FontSize',15)

Labels_P{1,end-1} = "measured";
Labels_P{1,end} = "fitted";

legend(Q,Labels_P)
ylim([0 1.1])
end