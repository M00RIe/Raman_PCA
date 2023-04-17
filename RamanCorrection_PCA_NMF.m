function [Raman_Shift,Spectrum_Intensity_norm] = RamanCorrection_PCA_NMF(FileName,T,WavnumEnd)

Raman_spectrum = FileName;

Spectrum = readtable(Raman_spectrum,"FileType","text");
Spectrum.Properties.VariableNames = {'Var1','Var2'};

Raman_Shift = Spectrum.Var1;
Spectrum_Intensity  = Spectrum.Var2;

Range = Raman_Shift>WavnumEnd&Raman_Shift<1400;
Raman_Shift = Raman_Shift(Range);
Spectrum_Intensity = Spectrum_Intensity(Range);


%Spectrum correction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w_0 = (10^7)/531.79;%直すべきところ
h = 6.626*10^(-34);
c = 2.998 * 10^8;
k = 1.381 * 10^(-23);

%(1)Background and blackbody radiation subtraction
%補正済みデータなのでなし

%(2)baseline subtraction
%baseline range (1300-1400cm-1)
Baseline_Range = Raman_Shift(Raman_Shift > 1300);
Baseline_Intensity = Spectrum_Intensity(Raman_Shift > 1300);

%liner fitting
p_Intensity_fitted = polyfit(Baseline_Range,Baseline_Intensity,1);
baseline = polyval(p_Intensity_fitted,Raman_Shift);

Spectrum_Intensity = Spectrum_Intensity - baseline;

%(3)correction of temperature and frequency
Spectrum_Intensity = Spectrum_Intensity.*(Raman_Shift./(w_0-Raman_Shift).^4).*(1-exp(-(h*c.*Raman_Shift./(k*(T+273)))));

%(4)normarization
Spectrum_Intensity_Max = max(Spectrum_Intensity);
Spectrum_Intensity_norm = Spectrum_Intensity./Spectrum_Intensity_Max;

%(5)Qn range & liner interpolation
Qn_Raman_Shift_Range = WavnumEnd+1:0.45:1399;
Spectrum_Intensity_norm =  interp1(Raman_Shift,Spectrum_Intensity_norm,Qn_Raman_Shift_Range);
Raman_Shift = Qn_Raman_Shift_Range;

%Spectrum correction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(Raman_Shift,Spectrum_Intensity_norm,"LineWidth",1.5)
%plot(Raman_Shift,Spectrum_Intensity_norm,".")

box on
g = gca;g.LineWidth = 1.5;

xlim([Qn_Raman_Shift_Range(1) Qn_Raman_Shift_Range(end)])
ylim([-0.1 1.1])

xlabel('Raman Shift [cm^{-1}]','FontName','Times','FontSize',15)
ylabel('Intensity [a.u.]','FontName','Times','FontSize',15)


end