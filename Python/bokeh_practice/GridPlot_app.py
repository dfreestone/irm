
import logging
logging.basicConfig(level=logging.DEBUG)

import numpy as np

# For now, hack adding it to the path...
import sys
sys.path.append('../')
import correlation_coefficient as cc
rpdf = cc.rpdf

from bokeh.plotting import figure
from bokeh.models import Plot, ColumnDataSource, GridPlot
from bokeh.properties import Instance
from bokeh.server.app import bokeh_app
from bokeh.server.utils.plugins import object_page
from bokeh.models.widgets import HBox, VBox, Slider, TextInput, VBoxForm, Tabs, Panel


class GridPlot_app(HBox):

    extra_generated_classes = [["GridPlot_app", "GridPlot_app", "HBox"]]

    slider_row = Instance(HBox)
    plot_row = Instance(HBox)

    rho = Instance(Slider)
    N = Instance(Slider)
    grid = Instance(GridPlot)
    source = Instance(ColumnDataSource)
    plot = Instance(Plot)

    tab = Instance(Tabs)
    panel1 = Instance(Panel)
    panel2 = Instance(Panel)

    @classmethod
    def create(cls):
        obj = cls()
        obj.source = ColumnDataSource(data=dict(x=[], y=[]))

        obj.rho = Slider(title="rho",
                         name='rho',
                         value=0.0,
                         start=-1.0,
                         end=1.1,
                         step=0.1)

        obj.N = Slider(title="N",
                       name='N',
                       value=26,
                       start=1,
                       end=52,
                       step=1)

        obj.slider_row = HBox(children=[obj.rho, obj.N])
        #obj.children.append(obj.slider_row)

        def create_plot():
            toolset =  "crosshair,pan,reset,resize,save,wheel_zoom"
            plot = figure(title_text_font_size="12pt",
                        plot_height=200,
                        plot_width=200,
                        tools="tap",
                        title='Hey',
                        x_range=[-1, 1],
                        y_range=[0, 0.015],
                        min_border=2)
            plot.line('x', 'y', source=obj.source,
                    line_width=3,
                    line_alpha=0.6)

            plot.axis.major_label_text_font_size = '0pt'
            plot.axis.major_tick_line_color = None  # turn off major ticks
            plot.axis[0].ticker.num_minor_ticks = 0  # turn off minor ticks
            plot.axis[1].ticker.num_minor_ticks = 0
            return plot

        plots = []
        for row in range(5):
            row_plots = []
            for col in range(5):
                if col >= row:
                    row_plots.append(create_plot())
                else:
                    row_plots.append(None)
            plots.append(row_plots)

        grid = GridPlot(children=plots,
                        toolbar_location=None)
        obj.grid = grid
        obj.plot_row = HBox(children=[obj.grid])
        #obj.children.append(obj.plot_row)


        obj.panel1 = Panel(child=obj.grid, title="Panel1")
        obj.panel2 = Panel(child=obj.slider_row, title="Panel2")
        obj.tab = Tabs(tabs=[obj.panel1, obj.panel2])
        print(dir(obj.tab))
        obj.children.append(obj.tab)

        return obj

    def setup_events(self):
        """Attaches the on_change event to the value property of the widget.
        The callback is set to the input_change method of this app.
        """
        super(GridPlot_app, self).setup_events()
        # Slider event registration
        #print("hi", self.rho.value)
        #print(getattr(self, 'rho').value)
        #self.rho.on_change('value', self, 'input_change')
        #for w in ["rho", "N"]:
        #    getattr(self, w).on_change('value', self, 'input_change')
        #print(dir(self.grid))
        #self.grid.on_change('click', self, 'input_change')
        #getattr(self, "grid").on_change('click', self, 'input_change')
        print("hey")
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

    def update_data(self):
        """Called each time that any watched property changes.
        This updates the sin wave data with the most recent values of the
        sliders. This is stored as two numpy arrays in a dict into the app's
        data source property.
        """

        # Generate the CC distribution
        y = self.dr * rpdf(self.r,
                           self.rho.value,
                           self.N.value)

        logging.debug("PARAMS: rho: %s N: %s",
                      self.rho.value,
                      self.N.value)

        self.source.data = dict(x=self.r, y=y)



@bokeh_app.route("/IRM/ccDistribution/")
@object_page("rpdf")
def make_App():
    app = GridPlot_app.create()
    return app
