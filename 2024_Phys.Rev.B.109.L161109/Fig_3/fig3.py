import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import matplotlib.cm as cm
import matplotlib as mpl
from mpl_toolkits.axes_grid1 import make_axes_locatable

def latex_plot(scale = 1, fontsize = 12):
    """ Changes the size of a figure and fonts for the publication-quality plots. """
    fig_width_pt = 246.0
    inches_per_pt = 1.0/72.27
    golden_mean = (np.sqrt(5.0)-1.0)/2.0
    fig_width = fig_width_pt*inches_per_pt*scale
    fig_height = fig_width*golden_mean
    fig_size = [fig_width, fig_height]
    eps_with_latex = {
        "pgf.texsystem": "pdflatex", "text.usetex": True, "font.family": "serif", "font.serif": [], "font.sans-serif": [], "font.monospace": [], "axes.labelsize": fontsize, "font.size": fontsize, "legend.fontsize": fontsize, "xtick.labelsize": 12, "ytick.labelsize": 12, "figure.figsize": fig_size
        }
    mpl.rcParams.update(eps_with_latex)


def olap(J, U, d) -> np.float64:
    return J**2 / np.sqrt((J**2 + 2 * U**2) * (1 + 2 * d**2))


def olap2(J,U,d) -> np.float64:
    return 2 * (8*J**8 + d**4*U**4 + d**2*J**2*U**2*(d**2 - U**2) + 2*J**6*(2*d**2 + U**2))/(np.sqrt((4*d**8 + 19*d**6*J**2 + 48*d**4*J**4 + 56*d**2*J**6 + 8*J**8)*(4*J**2 + U**2)*(8*J**6 + 56*J**4*U**2 + 25*J**2*U**4 + 4*U**6)))    

norm = mcolors.Normalize(vmin=0, vmax=1)
latex_plot()

# 2x1 plot using GridSpec
fig = plt.figure(figsize=(5.2, 2.5), constrained_layout=True)
gs = fig.add_gridspec(1, 2, width_ratios=[1, 1], wspace=0.01, hspace=0.01)

ax1 = fig.add_subplot(gs[0])
ax2 = fig.add_subplot(gs[1])

fontsize = 12
deltamax = 1
umax = 1
clines = [0.2,0.3,0.5,0.7,0.9]
delta = np.arange(0, deltamax, 0.01)
U = np.arange(0, umax, 0.01)
delta, U = np.meshgrid(delta, U)
olaps =olap(1, U, delta)
olaps2 = olap2(1, U, delta)

# plot heatmap with contour lines
ax1.imshow(olaps, cmap=cm.viridis,  norm=norm, extent=[0, deltamax, 0, umax], origin="lower")
CS1 = ax1.contour(delta, U, olaps, clines, colors='k', linewidths=0.5)
ax1.clabel(CS1, inline=1, fontsize=fontsize, fmt="%1.1f",colors="k")

ax2.imshow(olaps2, cmap=cm.viridis, norm=norm, extent=[0, deltamax, 0, umax], origin="lower")
CS2 = ax2.contour(delta, U, olaps2, clines, colors="k", linewidths=0.5)
ax2.clabel(CS2, fontsize=fontsize, fmt="%1.1f",colors="k", inline=1)

ax1.set_ylabel(r"Interchain coupling $U$", fontsize=fontsize)
ax1.set_xlabel(r"Anisotropy $\Delta$", fontsize=fontsize)
ax2.set_xlabel(r"Anisotropy $\Delta$", fontsize=fontsize)

ax1.set_yticks([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax1.set_yticklabels([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax1.set_xticks([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax1.set_xticklabels([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax2.set_xticks([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax2.set_xticklabels([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax2.set_yticks([0,0.2, 0.4, 0.6, 0.8 ,1.0])
ax2.set_yticklabels([])

# turn on smaller ticks
ax1.minorticks_on()
ax2.minorticks_on()

cbar = plt.colorbar(cm.ScalarMappable(norm=norm, cmap=cm.viridis), ax = ax2, orientation="vertical", pad=0.03, shrink=1)

# set colorbar ticks manually
cbar.set_ticks([0.0, 0.2, 0.4, 0.6, 0.8, 1.0])
cbar.minorticks_on()

ax1.text(0.55, 0.85, r"(\textbf{a}) $\langle Q_3^{+} I_3 \rangle$", fontsize=fontsize, color='white')
ax2.text(0.55, 0.85, r"(\textbf{b}) $\langle Q_4^{+} I_4 \rangle$", fontsize=fontsize, color='white')

plt.show()
