# Force dplyr's select to take precedence
select <- dplyr::select
filter <- dplyr::filter

# Options
options(scipen = 999)
options(qic.clshade = T) # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(qic.linecol = 'black') # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(qic.signalcol = "firebrick") # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(qic.targetcol = "purple") # NO LONGER NEEDED; CHARTS ALL PREPARED WITH GGPLOT2 ONLY
options(DT.options = list(dom = 'pBlfrti')) # Add buttons, filtering, and top (t) pagination controls
options(shiny.maxRequestSize = 50 * 1024^2) # Set upload maximum to 50 MB
options(tigris_use_cache = TRUE)


flextable::set_flextable_defaults(
  font.size = 14,
  font.family = "Cabin",
  font.color = "black",
  table.layout = "fixed",
  border.color = "darkgray",
  padding.top = 3,
  padding.bottom = 3,
  padding.left = 4,
  padding.right = 4,
  line_spacing = 1.3,
  digits = 2,
  decimal.mark = ",",
  big.mark = " ",
  na_str = "<na>"
)


# Set global theme for consistent plots
ggplot2::theme_set(
  ggplot2::theme_minimal(base_size = 20) +
    ggplot2::theme(
      plot.title.position = "plot",
      plot.title = ggtext::element_textbox_simple(
        family = "Cabin",
        face = "bold",
        color = "darkgreen",
        size = 22,
        fill = "yellow",
        lineheight = 1.0,
        padding = ggplot2::margin(5.5, 5.5, 0.0, 5.5),
        margin = ggplot2::margin(0, 0, 5.5, 0)
      ),
      plot.subtitle = ggtext::element_textbox_simple(
        family = "Cabin",
        color = "darkgreen",
        face = "bold",
        size = 20,
        fill = "yellow",
        lineheight = 1.0,
        padding = ggplot2::margin(0.0, 5.5, 5.5, 5.5),
        margin = ggplot2::margin(0, 0, 5.5, 0)
      ),
      plot.caption = ggtext::element_markdown(
        family = "Cabin",
        size = 16,
        hjust = 1,
        color = "darkblue",
        face = "italic",
        fill = "yellow",
        lineheight = 1.0
      ),
      axis.text.x = ggplot2::element_blank(),
      # ggtext::element_markdown(
      #   family = "Cabin",
      #   face = "bold",
      #   color = "blue",
      #   size = 16,
      #   angle = 45,
      #   hjust = 1
      # ),
      axis.title.x = ggplot2::element_blank(),
      # ggtext::element_markdown(
      #   family = "Cabin",
      #   face = "bold",
      #   color = "blue",
      #   size = 16),
      axis.text.y = ggplot2::element_blank(),
      # ggtext::element_markdown(
      #   family = "Cabin",
      #   face = "bold",
      #   color = "blue",
      #   size = 16,
      #   angle = 45,
      #   hjust = 1
      # ),
      axis.title.y = ggplot2::element_blank(),
      # ggtext::element_markdown(
      #   family = "Cabin",
      #   face = "bold",
      #   color = "blue",
      #   size = 16),
      strip.text = ggtext::element_markdown(
        family = "Cabin",
        color = "black",
        size = ggplot2::rel(1.1),
        face = "italic",
        margin = ggplot2::margin(2, 0, 0.5, 0, "lines")
      ),
      axis.text = ggtext::element_markdown(
        family = "Cabin",
        color = "black"
      ),
      panel.background = ggplot2::element_rect(fill = "white", color = NA),
      plot.background = ggplot2::element_rect(fill = "white", color = NA),
      legend.position = "none",
      panel.spacing.x = grid::unit(1.5, "cm"),
      panel.spacing.y = grid::unit(1.5, "cm"),
      plot.margin = ggplot2::margin(20, 20, 20, 20, "pt")
    )
)


# Set seed for reproducibility
set.seed(123)


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
# People often incorrectly see patterns in random data - they might
# interpret random fluctuations as meaningful trends. By showing that
# there are only 9 possible shapes with 3 time points
# (using 3 possible values) demonstrates that certain patterns will
# naturally emerge even from completely random processes.

#####  "Nine Random 'Signals'!"  #####

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

# Get signal names in order they appear
signal_levels <- unique(false_signals$signal)

# Convert signal to factor to preserve order
false_signals$signal <- factor(false_signals$signal, levels = signal_levels)

# Create a SEPARATE named color vector for the scale (don't modify custom_colors)
signal_colors <- setNames(custom_colors, signal_levels)

# Create colored labels separately
colored_labels <- setNames(
  paste0(
    "<b style='color:",
    custom_colors,
    "; font-size:18pt'>",
    signal_levels,
    "</b>"
  ),
  signal_levels
)

# Create the line plot with facets using the custom color palette
false_signals_facet_plot <- false_signals |>
  ggplot2::ggplot(ggplot2::aes(x = x, y = y)) +
  ggplot2::geom_line(
    ggplot2::aes(group = signal, color = signal),
    linewidth = 2
  ) +
  ggplot2::geom_point(
    ggplot2::aes(x = x, y = y, group = interaction(signal, y), color = signal),
    size = 4
  ) +
  ggplot2::facet_wrap(
    ~signal,
    labeller = ggplot2::as_labeller(colored_labels)
  ) +

  # ggplot2::facet_wrap(~signal, ncol = 3, nrow = 4) +
  ggplot2::scale_x_continuous(breaks = c(0, 1, 2)) +
  ggplot2::scale_y_continuous(breaks = c(0, 1, 2)) +
  ggplot2::scale_color_manual(values = signal_colors) +
  ggplot2::labs(x = NULL, y = NULL) +
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
