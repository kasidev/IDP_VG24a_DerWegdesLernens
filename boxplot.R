# Load the dplyr package
library(dplyr)

# Convert the "Group" column to a factor to ensure proper order in the plot
result$Group <- factor(result$Group, levels = c("Gedächtnis_t0", 
                                                "Gedächtnis_t14", 
                                                "Konzentration_t0", 
                                                "Konzentration_t14"))

# Assign colors to each group based on the 'Group' column
# Groups containing "Gedächtnis" are assigned blue, the rest are assigned red
result$Color <- ifelse(grepl("Gedächtnis", result$Group), "blue", "red")

# Rename the group names for clearer labeling on the x-axis
# You can modify these names to whatever you prefer
group_rename <- c("Gedächtnis_t0" = "Memory Start",
                  "Gedächtnis_t14" = "Memory 14 Days",
                  "Konzentration_t0" = "Concentration Start",
                  "Konzentration_t14" = "Concentration 14 Days")

# Apply the renaming using recode() from dplyr
result$Group <- recode(result$Group, !!!group_rename)

# Create the boxplot with ggplot
ggplot(result, aes(x = Group, y = Score, fill = Color)) +
  # Create boxplots with the given data
  geom_boxplot() +
  
  # Manually set the colors for the boxplots (blue for Gedächtnis, red for others)
  scale_fill_manual(values = c("blue", "red")) +
  
  # Add titles and labels to the plot
  labs(title = "Resultate Experiment", 
       subtitle = "Klasse Gedächtnisstraining n=13, Klasse Konzentrationstraining n=15",
       y = "Test Score",
       x = "") +
  
  # Use a minimal theme for the plot
  theme_minimal() +
  
  # Customize the appearance of the x-axis labels (rotated for better visibility)
  theme(legend.position = "none", 
        axis.text.x = element_text(angle = 15, hjust = 1))  # Adjust angle of x-axis text for better readability
