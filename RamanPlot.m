function [Raman_Shift,Spectrum_Intensity_norm,Temprature] = RamanPlot(FileName,LaserWavwlength)

Raman_spectrum = FileName + ".asc";
Raman_BackGround = FileName + "_BG" + ".asc";

Spectrum = readtable(Raman_spectrum,"FileType","text");
Spectrum.Properties.VariableNames = {'Var1','Var2'};

BG = readtable(Raman_BackGround,"FileType","text");
BG.Properties.VariableNames = {'Var1','Var2'};

Spectrum_x_wavelength = Spectrum.Var1;

Raman_Shift  = (10^7)/LaserWavwlength - (10^7)./Spectrum_x_wavelength;

%Spectrum correction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Splitname = split(FileName,"_");
Temprature = Splitname(end);
T = double(Temprature);

w_0 = (10^7)/LaserWavwlength;
h = 6.626*10^(-34);
c = 2.998 * 10^8;
k = 1.381 * 10^(-23);

%(1)Background and blackbody radiation subtraction
Spectrum_Intensity = Spectrum.Var2 - BG.Var2;

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
%Spectrum correction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(Raman_Shift,Spectrum_Intensity_norm,"LineWidth",1.5)

box on
g = gca;g.LineWidth = 1.5;

xlim([400 1400])
ylim([0 1])
legend(Temprature)

xlabel('Raman Shift [cm^{-1}]','FontName','Times','FontSize',15)
ylabel('Intensity [a.u.]','FontName','Times','FontSize',15)


end