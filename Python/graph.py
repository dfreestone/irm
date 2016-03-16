__author__ = 'davidfreestone'


import numpy as np
import matplotlib.pyplot as plt
plt.style.use('ggplot')

def plot_scatter(plotinfo):
    x, y, _, xlabel, ylabel, _ = extract_info(plotinfo)

    m, b = np.polyfit(x, y, 1)
    xfit = [x.min(), x.max()]
    yfit = np.dot(xfit, m) + b

    plt.scatter(x, y)
    plt.plot(xfit, yfit, lw=4)
    plt.xlabel(xlabel, fontsize=18)
    plt.ylabel(ylabel, fontsize=18)
    plt.show()
    return None

def plot_histogram(plotinfo):
    x, y, _, xlabel, ylabel, _ = extract_info(plotinfo)
    plt.bar(x, y)
    plt.xlabel(xlabel, fontsize=18)
    plt.ylabel(ylabel, fontsize=18)
    plt.show()
    return None

def plot_line(plotinfo):
    x, y, _, xlabel, ylabel, _ = extract_info(plotinfo)
    plt.plot(x, y, lw=4)
    plt.xlabel(xlabel, fontsize=18)
    plt.ylabel(ylabel, fontsize=18)
    plt.show()
    return None

def plot_heatmap(plotinfo):
    x, y, z, xlabel, ylabel, zlabel = extract_info(plotinfo)
    limits = (x.min(), x.max(), y.min(), y.max())
    plt.imshow(z, origin='lower', extent=limits, cmap=plt.cm.RdBu)
    plt.xlabel(xlabel, fontsize=18)
    plt.ylabel(ylabel, fontsize=18)
    plt.show()
    return None
def plot_contour(plotinfo):
    x, y, z, xlabel, ylabel, zlabel = extract_info(plotinfo)
    plt.contour(x, y, z, cmap=plt.cm.RdBu, linewidths=5)
    plt.xlabel(xlabel, fontsize=18)
    plt.ylabel(ylabel, fontsize=18)
    plt.show()
    return None

def plot_surface(plotinfo):
    x, y, z, xlabel, ylabel, zlabel = extract_info(plotinfo)
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.plot_surface(x, y, z, cmap=plt.cm.RdBu, lw=0, antialiased=False,
                    rstride=1, cstride=1, shade=True)
    plt.xlabel(xlabel, fontsize=18)
    plt.ylabel(ylabel, fontsize=18)
    plt.show()
    return None

def extract_info(plotinfo):
        return (plotinfo['x']['value'], plotinfo['y']['value'],
                plotinfo['z']['value'], plotinfo['x']['label'],
                plotinfo['y']['label'], plotinfo['z']['label'])



