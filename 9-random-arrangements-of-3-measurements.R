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









#####  "Nine Random 'Signals'!"  #####


## Load necessary libraries
library(ggplot2)
library(tibble)

# Define your data
false_signals <- tibble(
  signal = rep(c("Progress (?)", "Downturn  (?)", "Setback  (?)", "Turnaround  (?)", "Plummet  (?)", "Crises  (?)", "Plateau  (?)", "Rock Bottom  (?)", "Stuck  (?)" ), each = 3),
  y = c(0,1,2, 0,2,1, 1,2,0, 2,0,1, 2,1,0, 2,2,0, 1,2,2, 2,0,0, 1,1,1),
  x = rep(c(0, 1, 2), 9)
)

# Define a custom color palette with 9 distinct colors
custom_colors <- c("red", "blue", "darkgreen", "purple", "darkorange", "black", "deepskyblue", "firebrick",  "forestgreen")

# Create the line plot with facets using the custom color palette
false_signals_facet_plot <- false_signals %>%
  ggplot(aes(x = x, y = y)) +
  geom_line(aes(group = signal, color = signal), linewidth = 2) +
  geom_point(aes(x = x, y = y, group = interaction(signal, y), color = signal), size = 4) +
  facet_wrap(~ signal, ncol = 3, nrow = 4) +
  theme_minimal(base_size = 18) +  # Adjust base size for facet labels
  scale_x_continuous(breaks = c(0, 1, 2)) +
  scale_y_continuous(breaks = c(0, 1, 2)) +
  scale_color_manual(values = custom_colors) +
  labs(x = NULL, y = NULL) +
  theme(legend.position = "",
        strip.text = element_text(color = "black", face = "bold", size = 16),  # Adjust text size for facet labels
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing = unit(.25, "inches"),  # Adjust spacing between facets
        aspect.ratio = 1,  # Set aspect ratio of each facet to be a square
        strip.background = element_rect(fill = "white", color = "white"),  # Make facet labels stand out
        strip.placement = "outside"  # Place facet labels outside the plot area
  ) +
  theme(plot.margin = margin(1.5, 1.5, 1.5, 1.5, "cm"),
        plot.title = element_text(face = "bold")) +
  labs(title = "Emotional Reactions to Random Changes")  # Add main plot title

# Print the plot
print(false_signals_facet_plot)

#####  NOTE:  THE PLOT VIEWER DISPLAY LOOKS TERRIBLE, BUT THE PNG FILE LOOKS GREAT ####


# Save the plot as an image file with larger dimensions
# ggsave("img/9-random-arrangements-of-3-measurements.png",
#        plot = false_signals_facet_plot,
#        width = 12,
#        height = 12,
#        units = "in",
#        dpi = 300,
#        device = "png",
#        bg = "transparent")
#


