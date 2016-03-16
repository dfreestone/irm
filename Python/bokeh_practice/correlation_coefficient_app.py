"""
This file demonstrates a bokeh applet, which can be viewed directly
on a bokeh-server. See the README.md file in this directory for
instructions on running.
"""


import logging
logging.basicConfig(level=logging.DEBUG)

import numpy as np

# For now, hack adding it to the path...
import sys
sys.path.append('../')
import correlation_coefficient as cc
rpdf = cc.rpdf

from bokeh.plotting import figure
from bokeh.models import Plot, ColumnDataSource
from bokeh.properties import Instance
from bokeh.server.app import bokeh_app
from bokeh.server.utils.plugins import object_page
from bokeh.models.widgets import HBox, Slider, TextInput, VBoxForm


class CorrelationCoefficientApp(HBox):
    """An example of a browser-based, interactive plot with slider controls."""

    r, dr = np.linspace(-1, 1, 1000, endpoint=True, retstep=True)

    extra_generated_classes = [["CorrelationCoefficientApp", "CorrelationCoefficientApp", "HBox"]]

    inputs = Instance(VBoxForm)
    text = Instance(TextInput)
    rho = Instance(Slider)
    N = Instance(Slider)

    plot1 = Instance(Plot)
    plot2 = Instance(Plot)
    source = Instance(ColumnDataSource)

    @classmethod
    def create(cls):
        """One-time creation of app's objects.
        This function is called once, and is responsible for
        creating all objects (plots, datasources, etc)
        """
        obj = cls()

        obj.source = ColumnDataSource(data=dict(x=[], y=[]))

        obj.text = TextInput(title="title",
                             name='title',
                             value='look, I can change things too')

        obj.rho = Slider(title="rho",
                         name='rho',
                         value=0.0,
                         start=-1.0,
                         end=1.1,
                         step=0.1,
                         )

        obj.N = Slider(title="N",
                       name='N',
                       value=26,
                       start=1,
                       end=52,
                       step=1)

        def create_plot():
            toolset =  "crosshair,pan,reset,resize,save,wheel_zoom"
            plot = figure(title_text_font_size="12pt",
                          plot_height=400,
                          plot_width=400,
                          tools=toolset,
                          title=obj.text.value,
                          x_range=[-1, 1],
                          y_range=[0, 0.015])
            plot.line('x', 'y', source=obj.source,
                      line_width=3,
                      line_alpha=0.6)
            return plot

        # This removes the toolbar from the plot (along with the Bokeh logo!)
        #plot.toolbar_location = None

        obj.plot1 = create_plot()
        obj.plot2 = create_plot()

        obj.update_data()

        obj.inputs = VBoxForm(children=[obj.text, obj.rho, obj.N])

        obj.children.append(obj.inputs)
        obj.children.append(obj.plot1)
        obj.children.append(obj.plot2)

        return obj

    def setup_events(self):
        """Attaches the on_change event to the value property of the widget.
        The callback is set to the input_change method of this app.
        """
        super(CorrelationCoefficientApp, self).setup_events()
        if not self.text:
            return

        # Text box event registration
        self.text.on_change('value', self, 'input_change')

        # Slider event registration
        for w in ["rho", "N"]:
            getattr(self, w).on_change('value', self, 'input_change')

        self.plot1.on_change('selected', self, 'plot_selected')

    def plot_selected(self, obj, attrname, old, new):
        print('Hi')
        #print(attrname, old, new)

    def input_change(self, obj, attrname, old, new):
        """Executes whenever the input form changes.
        It is responsible for updating the plot, or anything else you want.
        Args:
            obj : the object that changed
            attrname : the attr that changed
            old : old value of attr
            new : new value of attr
        """
        self.update_data()
        self.plot1.title = 'rho ' + str(self.rho.value) + ' N ' + str(self.N.value)
        self.plot2.title = 'rho ' + str(self.rho.value) + ' N ' + str(self.N.value)

    def update_data(self):
        """Called each time that any watched property changes.
        This updates the sin wave data with the most recent values of the
        sliders. This is stored as two numpy arrays in a dict into the app's
        data source property.
        """

        # Get the current slider values
        rho = self.rho.value
        N = self.N.value

        # Generate the CC distribution
        y = self.dr * rpdf(self.r, rho, N)

        logging.debug("PARAMS: rho: %s N: %s",
                      self.rho.value,
                      self.N.value)

        self.source.data = dict(x=self.r, y=y)


# The following code adds a "/bokeh/sliders/" url to the bokeh-server. This
# URL will render this sine wave sliders app. If you don't want to serve this
# applet from a Bokeh server (for instance if you are embedding in a separate
# Flask application), then just remove this block of code.
@bokeh_app.route("/IRM/ccDistribution/")
@object_page("rpdf")
def make_App():
    app = CorrelationCoefficientApp.create()
    return app