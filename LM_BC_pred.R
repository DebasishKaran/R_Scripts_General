library("tidyverse") # for tidy data analysis
library("readr")     # for fast reading of input files
library("mice")
setwd("D://Machine_Learning/")
bc_data <- read_delim("breast-cancer-wisconsin.data",
                      delim = ",",
                      col_names = c("sample_code_number", 
                                    "clump_thickness", 
                                    "uniformity_of_cell_size", 
                                    "uniformity_of_cell_shape", 
                                    "marginal_adhesion", 
                                    "single_epithelial_cell_size", 
                                    "bare_nuclei", 
                                    "bland_chromatin", 
                                    "normal_nucleoli", 
                                    "mitosis", 
                                    "classes")) %>%
  mutate(bare_nuclei = as.numeric(bare_nuclei),
         classes = ifelse(classes == "2", "benign",
                          ifelse(classes == "4", "malignant", NA)))
head(bc_data)
summary(bc_data)

dim(bc_data)

# how many NAs are in the data - check missingness
mice::md.pattern(bc_data, plot = FALSE)

bc_data <- bc_data %>%
  drop_na() %>%
  select(classes, everything(), -sample_code_number)
head(bc_data)

#dim(bc_data)
ggplot(bc_data, aes(x = classes, fill = classes)) +
  geom_bar()
  
ggplot(bc_data, aes(x = clump_thickness)) +
  geom_histogram(bins = 10)
  
gather(bc_data, x, y, clump_thickness:mitosis) %>%
  ggplot(aes(x = y, color = classes, fill = classes)) +
    geom_density(alpha = 0.3) +
    facet_wrap( ~ x, scales = "free", ncol = 3) 
    
co_mat_benign <- filter(bc_data, classes == "benign") %>%
  select(-1) %>%
  cor()

co_mat_malignant <- filter(bc_data, classes == "malignant") %>%
  select(-1) %>%
  cor()
  
library(igraph)
g_benign <- graph.adjacency(co_mat_benign,
                         weighted = TRUE,
                         diag = FALSE,
                         mode = "upper")

g_malignant <- graph.adjacency(co_mat_malignant,
                         weighted = TRUE,
                         diag = FALSE,
                         mode = "upper")

# http://kateto.net/networks-r-igraph

cut.off_b <- mean(E(g_benign)$weight)
cut.off_m <- mean(E(g_malignant)$weight)

g_benign_2 <- delete_edges(g_benign, E(g_benign)[weight < cut.off_b])
g_malignant_2 <- delete_edges(g_malignant, E(g_malignant)[weight < cut.off_m])

c_g_benign_2 <- cluster_fast_greedy(g_benign_2) 
c_g_malignant_2 <- cluster_fast_greedy(g_malignant_2)                         
  
par(mfrow = c(1,2))

plot(c_g_benign_2, g_benign_2,
     vertex.size = colSums(co_mat_benign) * 10,
     vertex.frame.color = NA, 
     vertex.label.color = "black", 
     vertex.label.cex = 0.8,
     edge.width = E(g_benign_2)$weight * 15,
     layout = layout_with_fr(g_benign_2),
     main = "Benign tumors")

plot(c_g_malignant_2, g_malignant_2,
     vertex.size = colSums(co_mat_malignant) * 10,
     vertex.frame.color = NA, 
     vertex.label.color = "black", 
     vertex.label.cex = 0.8,
     edge.width = E(g_malignant_2)$weight * 15,
     layout = layout_with_fr(g_malignant_2),
     main = "Malignant tumors") 
#PCA
library(ellipse)

# perform pca and extract scores
pcaOutput <- prcomp(as.matrix(bc_data[, -1]), scale = TRUE, center = TRUE)
pcaOutput2 <- as.data.frame(pcaOutput$x)

# define groups for plotting
pcaOutput2$groups <- bc_data$classes

centroids <- aggregate(cbind(PC1, PC2) ~ groups, pcaOutput2, mean)

conf.rgn  <- do.call(rbind, lapply(unique(pcaOutput2$groups), function(t)
  data.frame(groups = as.character(t),
             ellipse(cov(pcaOutput2[pcaOutput2$groups == t, 1:2]),
                     centre = as.matrix(centroids[centroids$groups == t, 2:3]),
                     level = 0.95),
             stringsAsFactors = FALSE)))

ggplot(data = pcaOutput2, aes(x = PC1, y = PC2, group = groups, color = groups)) + 
  geom_polygon(data = conf.rgn, aes(fill = groups), alpha = 0.2) +
  geom_point(size = 2, alpha = 0.6) + 
  labs(color = "",
       fill = "") 

#Multidimensional Scaling
select(bc_data, -1) %>%
  dist() %>%
  cmdscale %>%
  as.data.frame() %>%
  mutate(group = bc_data$classes) %>%
  ggplot(aes(x = V1, y = V2, color = group)) +
  geom_point()