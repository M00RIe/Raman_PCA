function RatioMatrix = RamanSpiciesRatio(C_nmf,Ns,X_value,X_label_txt)
[~,K] = size(C_nmf);
RatioMatrix = zeros(length(Ns),K);
Labels = cell(1,K);

for  n = 1:length(Ns)

C_n = C_nmf(Ns(n),:);
Ratio_Sum = sum(C_n);
RatioMatrix(n,:) = C_n./Ratio_Sum*100;

end

figure
hold on
for k = 1:K
    plot(X_value,RatioMatrix(:,k),'o-',"LineWidth",1.5,'MarkerFaceColor','auto')
    Labels{k} = string(k);
end
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%区別しやすく
newcolors = {'#ff0000','#ff8000','#ffdd00','#4dff00','#0400ff','#ff00f2','#c2003a'};
colororder(newcolors)

legend(Labels,"Location","bestoutside")
xlabel(X_label_txt,'FontName','Times','FontSize',15)
ylabel('Contribution rate (%)','FontName','Times','FontSize',15)

box on;
g = gca;g.LineWidth = 1.5;
ylim([0 max(RatioMatrix,[],'all')+10])

end
