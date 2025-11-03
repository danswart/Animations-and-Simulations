# The 9 possible "shapes" or patterns for time-ordered measurements represent the unique ways the values can change from one time point to the next.
#
# These 9 shapes can be enumerated as:
#
#     Flat at level 0: (0,0,0)
#     Flat at level 1: (1,1,1)
#     Flat at level 2: (2,2,2)
#     Rise then fall: (0,1,0), (1,2,1)
#     Fall then rise: (1,0,1), (2,1,2)
#     Continuous rise: (0,1,2)
#     Continuous fall: (2,1,0)
#     Rise then flat: (0,1,1), (1,2,2)
#     Fall then flat: (2,1,1), (1,0,0)
#
# People often incorrectly see patterns in random data - they might interpret random fluctuations as meaningful trends. By showing that there are only 9 possible shapes with 3 time points (using 3 possible values), you're demonstrating that certain patterns will naturally emerge even from completely random processes.

# Prevent scientific notation globally
options(scipen = 999)
options(tigris_use_cache = TRUE)

# install.packages(c("mapview", "survey", "srvyr", "arcgislayers"))

# census_api_key("95496766c51541ee6f402c1e1a8658581285b759", install = TRUE, overwrite = TRUE)

# load libraries

# library(BayesFactor) # Computation of Bayes Factors for Common Designs
# library(boot) # Bootstrap Functions
# library(broom) # Convert Statistical Objects into Tidy Tibbles
# library(colorspace) # A Toolbox for Manipulating and Assessing Colors and Palettes
# library(camcorder) # Record Your Plot History
# library(car) # Companion to Applied Regression
# library(corrplot) # Visualization of a Correlation Matrix
# library(cowplot) # Streamlined Plot Theme and Plot Annotations for 'ggplot2'
# library(dagitty) # Graphical Analysis of Structural Causal Models
# library(DiagrammeR) # Graph/Network Visualization
# library(dlookr) # Tools for Data Diagnosis, Exploration, Transformation
library(dplyr) # A Grammar of Data Manipulation
# library(DT) # A Wrapper of the JavaScript Library 'DataTables'
# library(dutchmasters) # Color Palettes based on Famous Paintings
# library(flexdashboard) # R Markdown Format for Flexible Dashboards
# library(flextable) # Functions for Tabular Reporting
# library(forcats) # Tools for Working with Categorical Variables (Factors)
# library(gganimate) # A Grammar of Animated Graphics
# library(ggcorrplot) # Visualization of a Correlation Matrix using 'ggplot2'
# library(ggdag) # Analyze and Create Elegant Directed Acyclic Graphs
# library(ggforce) # Accelerating 'ggplot2'
# library(gghighlight) # Highlight Lines and Points in 'ggplot2'
# library(ggplot2) # Create Elegant Data Visualizations Using the Grammar of Graphics
# library(ggokabeito) # 'Okabe-Ito' Scales for 'ggplot2' and 'ggraph'
# library(ggpubr) # 'ggplot2' Based Publication Ready Plots
# library(ggrepel) # Automatically Position Non-Overlapping Text Labels with 'ggplot2'
# library(ggtext) # Improved Text Rendering Support for 'ggplot2'
# library(ggthemes) # Extra Themes, Scales and Geoms for 'ggplot2'
# library(glue) # Interpreted String Literals
# library(grid) # The Grid Graphics Package
# library(gt) # Easily Create Presentation-Ready Display Tables
# library(gtExtras) # Extending 'gt' for Beautiful HTML Tables
# library(haven) # Import and Export 'SPSS', 'Stata' and 'SAS' Files
# library(here) # A Simpler Way to Find Your Files
# library(htmltools) # Tools for HTML
# library(htmlwidgets) # HTML Widgets for R
# library(janitor) # Simple Tools for Examining and Cleaning Dirty Data
# library(kableExtra) # Construct Complex Table with 'kable' and Pipe Syntax
# library(knitr) # A General-Purpose Package for Dynamic Report Generation in R
# library(lavaan) # Latent Variable Analysis
# library(lubridate) # Make Dealing with Dates a Little Easier
# library(monochromeR) # Easily Create, View and Use Monochrome Color Palettes
# library(paletteer) # Comprehensive Collection of Color Palettes
# library(patchwork) # The Composer of Plots
# library(plotly) # Create Interactive Web Graphics via 'plotly.js'
# library(ppcor) # Partial and Semi-Partial (Part) Correlation
# library(prettycode) # Pretty Print R Code in the Terminal
# library(purrr) # Functional Programming Tools
# library(pwr) # Basic Functions for Power Analysis
# library(qgraph) # Graph Plotting Methods, Psychometric Data Visualization and Graphical Model Estimation
# library(qicharts2) # Quality Improvement Charts
# library(RColorBrewer) # ColorBrewer Palettes
# library(readr) # Read Rectangular Text Data
# library(readxl) # Read Excel Files
# library(rethinking) # Statistical Rethinking book package
# library(rlang) # Functions for Base Types and Core R and 'Tidyverse' Features
# library(scales) # Scale Functions for Visualization
# library(shiny) # Web Application Framework for R
# library(shinyobjects) # Access Reactive Data Interactively
# library(skimr) # Compact and Flexible Summaries of Data
# library(stringr) # Simple, Consistent Wrappers for Common String Operations
# library(tibble) # Simple Data Frames
# library(tidycensus) # Load US Census Boundary and Attribute Data as 'tidyverse' and 'sf'-Ready Data Frames
# library(tidylog) # Logging for 'dplyr' and 'tidyr' Functions
# library(tidyr) # Tidy Messy Data
# library(tidytext) # Text Mining using 'dplyr', 'ggplot2', and Other Tidy Tools
# library(tsibble) # Tidy Temporal Data Frames and Tools
# library(viridis) # Colorblind-Friendly Color Maps for R
# library(visdat) # Preliminary Visualization of Data
# library(vroom) # Read and Write Rectangular Text Data Quickly
# library(wesanderson) # A Wes Anderson Palette Generator
# library(writexl) # Export Data Frames to Excel 'xlsx' Format
# library(WRS2) # A Collection of Robust Statistical Methods

# Force dplyr's select to take precedence
select <- dplyr::select
filter <- dplyr::filter

# Options
options(scipen = 999)
options(qic.clshade = T) # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(qic.linecol = "black") # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(qic.signalcol = "red") # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(qic.targetcol = "purple") # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(DT.options = list(dom = "pBlfrti")) # Add buttons, filtering, and top (t) pagination controls
options(shiny.maxRequestSize = 50 * 1024^2) # Set upload maximum to 50 MB
options(tigris_use_cache = TRUE)


# Set global theme for consistent plots
ggplot2::theme_set(
  ggplot2::theme_minimal(base_size = 20) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = 26),
      plot.subtitle = ggplot2::element_text(face = "bold", size = 24),
      axis.title.x = ggplot2::element_text(face = "bold", size = 22),
      axis.title.y = ggplot2::element_text(face = "bold", size = 22),
      axis.text.x = ggplot2::element_text(
        face = "bold",
        size = 22,
        angle = 45,
        hjust = 1
      ),
      legend.position = "bottom",
      strip.text = ggplot2::element_text(face = "bold"),
      panel.spacing.x = grid::unit(0.5, "cm"),
      panel.spacing.y = grid::unit(0.5, "cm"),
      plot.margin = ggplot2::margin(20, 20, 20, 20, "pt")
    )
)


# Set seed for reproducibility
set.seed(123)

#####  "Nine Random 'Signals'!"  #####

## Load necessary libraries
# library(ggplot2) # Create Elegant Data Visualizations Using the Grammar of Graphics
# library(tibble) # Simple Data Frames

# Define your data
false_signals <- tibble::tibble(
  signal = rep(
    c(
      "Progress (?)",
      "Downturn  (?)",
      "Setback  (?)",
      "Turnaround  (?)",
      "Plummet  (?)",
      "Crises  (?)",
      "Plateau  (?)",
      "Rock Bottom  (?)",
      "Stuck  (?)"
    ),
    each = 3
  ),
  y = c(
    0,
    1,
    2,
    0,
    2,
    1,
    1,
    2,
    0,
    2,
    0,
    1,
    2,
    1,
    0,
    2,
    2,
    0,
    1,
    2,
    2,
    2,
    0,
    0,
    1,
    1,
    1
  ),
  x = rep(c(0, 1, 2), 9)
)

# Define a custom color palette with 9 distinct colors
custom_colors <- c(
  "red",
  "blue",
  "darkgreen",
  "purple",
  "darkorange",
  "black",
  "deepskyblue",
  "firebrick",
  "forestgreen"
)

# Create the line plot with facets using the custom color palette
false_signals_facet_plot <- false_signals %>%
  ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
  ggplot2::geom_line(
    ggplot2::aes(group = signal, color = signal),
    linewidth = 2
  ) +
  ggplot2::geom_point(
    ggplot2::aes(x = x, y = y, group = interaction(signal, y), color = signal),
    size = 4
  ) +
  ggplot2::facet_wrap(~signal, ncol = 3, nrow = 4) +
  ggplot2::scale_x_continuous(breaks = c(0, 1, 2)) +
  ggplot2::scale_y_continuous(breaks = c(0, 1, 2)) +
  ggplot2::scale_color_manual(values = custom_colors) +
  ggplot2::labs(x = NULL, y = NULL) +
  ggplot2::theme(
    legend.position = "",
    strip.text = ggplot2::element_text(
      color = "black",
      face = "bold",
      size = 12
    ), # Adjust text size for facet labels
    axis.title.x = ggplot2::element_blank(),
    axis.title.y = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.spacing = ggplot2::unit(.25, "inches"), # Adjust spacing between facets
    strip.background = ggplot2::element_rect(fill = "white", color = "white"), # Make facet labels stand out
    strip.placement = "outside" # Place facet labels outside the plot area
  ) +
  ggplot2::theme(
    plot.margin = ggplot2::margin(1.5, 1.5, 1.5, 1.5, "cm"),
    plot.title = ggplot2::element_text(face = "bold")
  ) +
  ggplot2::labs(title = "Emotional Reactions to Random Changes") # Add main plot title

# Print the plot
print(false_signals_facet_plot)

# # Save the plot as an image file with larger dimensions
#  ggsave("img/9-random-arrangements-of-3-measurements.png",
#         plot = false_signals_facet_plot,
#         width = 12,
#         height = 12,
#         units = "in",
#         dpi = 300,
#         device = "png",
#         bg = "transparent")
#
