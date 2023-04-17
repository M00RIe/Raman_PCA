# Readme

### RamanCorrection_PCA_NMF

Preprocessing of Raman spectra

```matlab
[RamanShift,Intensity] = RamanCorrection_PCA_NMF("Raman_Spectrum.csv",Temperature,Minimum Wavenumber);
```

### RamanPCA

This is for performing PCA and determining the number of components.

X: the matrix of the Raman intensities as a function of wavenumber

C: the matrix of the abundances of the species

S: the partial Raman spectra for the individual species.

n: the number of spectra

t: the number of wavenumber

k: the number of raman-active species

$$
X_{nt} = C_{nk}\times{S_{tk}}^T
$$

```matlab
[C_PCA,S_PCA,Cumulative_Contribution_Rate,Prinsiple_Compornent] = RamanPCA(RamanShift,X,k);
```

### RamanNMF

```matlab
[C_NMF,S_NMF,g_FigureHandle] = RamanNMF(RamanShift,X,k);
```

### RamanSpicies,RamanSpiciesRatio

This is for ploting contribution.
