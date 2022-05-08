args=(commandArgs(TRUE))

var1 <- args[1]
var1

options(echo=FALSE)
#setwd(args[1])


filename <- "group_ko-group_wt_logFC0585_L"
myData <- read.table(file = filename, sep="\t", header=FALSE)
filename
colnames(myData) <- c("RNASeq", "Group")
myData$Group <- as.factor(myData$Group)
head(myData)
xlabs <- paste(levels(myData$Group), "\n(n=", table(myData$Group),")", sep="")

library(ggplot2)
library(ggpubr)
library(grid)
library("extrafont")

ppi <- 300

boxName <- paste("group_ko_wt", "logFC0585", "tLength.png", sep="_")
png(file = boxName, width = 3, height = 2, units = 'in', res = ppi)                    
plot <- ggplot(myData, aes(x = Group, y = RNASeq, fill = Group)) +
  stat_boxplot(geom = "errorbar",
    width = 0.40,
	position = position_dodge(0.68),
	size = 0.2) +
  geom_boxplot(
    width = 0.47, 
	position = position_dodge(0.68),
    size = 0.2, 
    outlier.size = 0.2,
	notch = TRUE) +
  scale_x_discrete(labels = c("ns", "down", "up")) +
  theme_classic(base_line_size = 0.2) +
  scale_fill_manual(values=c("#C0C0C0", "#00BFFF", "#FA8072"))
#     ggtitle(title) +
#     ylab("log2(normalized rsem + 1)") +

#     rotate_x_text(angle = 90) +
#	 ylim(-2,2) +
#	 stat_compare_means(aes(group = Group), label = "p.format", label.y = 14.0, size = 1.2, color = "red", angle = 45) +
#     theme(
#           plot.title = element_text(family = "Times New Roman", face = "bold.italic", color = "darkred", size = 8, hjust = 0.5),
#           axis.title.x = element_text(family = "Helvetica", face = "plain", color = "black", size = 6),
#           axis.title.y = element_text(family = "Helvetica", face = "plain", color = "black", size = 6),
#           legend.text = element_text(family = "Helvetica", face = "plain", color = "black", size = 6),
#           legend.title = element_text(family = "Helvetica", face = "italic", color = "black", size = 6),
#		   axis.ticks.length = unit(-0.1, "cm"),
#		   axis.text.x = element_text(margin=unit(c(0.2,0.2,0.2,0.2), "cm"),
#		                              family = "Helvetica",
#									  face = "plain",
#									  color = "black",
#									  size = 6),
#		   axis.text.y = element_text(margin=unit(c(0.2,0.2,0.2,0.2), "cm"),
#		                              family = "Helvetica", 
#									  face = "plain", 
#									  color = "black", 
#									  size = 6),
#		   axis.line.x = element_line(size = 2, colour = "white"),
#           legend.position = "right") +
#	  scale_fill_manual(values=c("#6495ED", "#FF6347"))
#
plot
dev.off()

#     stat_boxplot(geom = "errorbar", width = 0.47, size = 0.2) +
#      geom_violin(position = position_dodge(0.68),
#                 size = 0.2) +
# geom_dotplot(binaxis='y', stackdir='center', dotsize=0.01, binwidth = 0.4)
#     guides(color = guide_legend(override.aes = list(size = 2, alpha = 1)))
#     stat_summary(fun.y = mean, geom = "point", shape = 23, size = 2, col = "black", fill = "black") + 

#myData$`Group` <- factor(myData$`Group`, levels=unique(myData$`Group`))
#head(myData)
#xlabs <- paste(levels(myData$Group), "\n(n=", table(myData$Group),")", sep="")

#library(ggplot2)
#library(ggpubr)
#library(grid)
#library("extrafont")

# compare_means using ggpubr
#compare_means(formula = Gene_Expr ~ Group, 
#              data = myData, 
#             group.by = "Group", 
#             method = "wilcox.test",
#             p.adjust.method = "holm")
#title <- paste("expression", sep=" ")

# compare_means(formula, data, method = "wilcox.test", paired = FALSE,
#  group.by = NULL, ref.group = NULL, ...)
